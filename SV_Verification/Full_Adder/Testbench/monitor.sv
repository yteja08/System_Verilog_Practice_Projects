class monitor;

    transaction tr;

    mailbox #(transaction) drv2mon;
    mailbox #(transaction) mon2scb;
    mailbox #(bit) mon2drv_ack;

    virtual full_adder_itf vitf;


    function new(mailbox #(transaction) drv2mon,
                 mailbox #(transaction) mon2scb,
                 mailbox #(bit) mon2drv_ack,
                 virtual full_adder_itf vitf);

        this.drv2mon = drv2mon;
        this.mon2scb = mon2scb;
        this.mon2drv_ack = mon2drv_ack;
        this.vitf = vitf;

    endfunction


    task run();

        bit ack;

      repeat(40) begin

            // Wait for Driver
            drv2mon.get(tr);

            #1;

            // Sample interface
            tr.a    = vitf.a;
            tr.b    = vitf.b;
            tr.cin  = vitf.cin;
            tr.sum  = vitf.sum;
            tr.cout = vitf.cout;

            $display("Monitor: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                     tr.a, tr.b, tr.cin, tr.sum, tr.cout);

            // Send captured transaction to scoreboard
            mon2scb.put(tr);

            // Tell Driver it can continue
          mon2drv_ack.put(1'b1);

        end

    endtask

endclass
