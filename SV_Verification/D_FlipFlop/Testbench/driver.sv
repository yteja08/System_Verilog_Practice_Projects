class driver;

    transaction tr;

    mailbox #(transaction) gen2drv;
    mailbox #(transaction) drv2mon;
    mailbox #(bit) mon2drv_ack;

    virtual full_adder_itf vitf;


    function new(mailbox #(transaction) gen2drv,
                 mailbox #(transaction) drv2mon,
                 mailbox #(bit) mon2drv_ack,
                 virtual full_adder_itf vitf);

        this.gen2drv = gen2drv;
        this.drv2mon = drv2mon;
        this.mon2drv_ack = mon2drv_ack;
        this.vitf = vitf;

    endfunction


    task run();
      
      bit ack;

      repeat(40) begin

            gen2drv.get(tr);

            vitf.a   = tr.a;
            vitf.b   = tr.b;
            vitf.cin = tr.cin;

            $display("Driver: a=%0d b=%0d cin=%0d",
                     vitf.a, vitf.b, vitf.cin);

            // Tell monitor that inputs are driven
            drv2mon.put(tr);

            // Wait until monitor captures this transaction
          mon2drv_ack.get(ack);

        end

    endtask

endclass
