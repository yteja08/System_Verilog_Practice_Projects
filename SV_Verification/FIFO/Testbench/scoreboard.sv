
class ScoreBoard #(parameter int width = 8, depth = 16);

  Transaction tr;

  mailbox #(Transaction) mon_scr;

  bit [width-1:0] fifo_q[$];
  bit [width-1:0] expected_data;

  bit exp_full, exp_empty;

  int pass, fail;

  function new(mailbox #(Transaction) mon_scr);

    this.mon_scr = mon_scr;

    pass = 0;
    fail = 0;

  endfunction


  task run();

    forever begin

      mon_scr.get(tr);
      
      if(tr.reset) begin //RESET

        fifo_q.delete();

        expected_data = 0;

        exp_full  = 0;
        exp_empty = 1;

      end

     
      else begin

       
        if(tr.r_en && !tr.empty) begin  // READ FIRST

          if(fifo_q.size() > 0) begin

            expected_data = fifo_q.pop_front();

            if(expected_data == tr.d_out) begin

              $display("[SCR] DATA PASS expected=%0d actual=%0d", expected_data, tr.d_out);
              pass++;

            end
            else begin

              $display("[SCR] DATA FAIL expected=%0d actual=%0d", expected_data, tr.d_out);
              fail++;

            end

          end

        end


        if(tr.w_en && !tr.full) begin  // WRITE AFTER

          fifo_q.push_back(tr.data);

        end


        exp_full  = (fifo_q.size() == depth);
        exp_empty = (fifo_q.size() == 0);


        if(exp_full == tr.full) begin

          $display("[SCR] FULL PASS expected=%0b actual=%0b",exp_full, tr.full);
          pass++;

        end
        else begin

          $display("[SCR] FULL FAIL expected=%0b actual=%0b",exp_full, tr.full);
          fail++;

        end


        if(exp_empty == tr.empty) begin

          $display("[SCR] EMPTY PASS expected=%0b actual=%0b", exp_empty, tr.empty);
          pass++;

        end
        else begin

          $display("[SCR] EMPTY FAIL expected=%0b actual=%0b",exp_empty, tr.empty);
          fail++;

        end

      end

      $display();

    end

  endtask


  function void report();

    $display("--------------------------");
    $display("    PASSED CASE : %0d   ", pass);
    $display("    FAILED CASE : %0d   ", fail);
    $display("--------------------------");

  endfunction

endclass
