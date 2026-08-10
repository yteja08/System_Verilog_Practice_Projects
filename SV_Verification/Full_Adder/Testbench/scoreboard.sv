class scoreboard;

    transaction tr;
    mailbox #(transaction) mon2scb;

    function new(mailbox #(transaction) mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task run();

        bit expected_sum;
        bit expected_cout;

      repeat(40) begin

            mon2scb.get(tr);

            expected_sum  = tr.a ^ tr.b ^ tr.cin;
          expected_cout = ((tr.a & tr.b) |
                           (tr.b & tr.cin) |
                           (tr.cin & tr.a));

            if ((tr.sum == expected_sum) &&
                (tr.cout == expected_cout)) begin
              $display("+----+");
              $display("|PASS|");
              $display("+----+");
            end
          
            else begin

              $display("+----+");
              $display("|FAIL|");
              $display("+----+");
            end

        end

    endtask

endclass
