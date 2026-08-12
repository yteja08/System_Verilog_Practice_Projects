class environment;

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;

    mailbox #(transaction) gen2drv;
    mailbox #(transaction) drv2mon;
    mailbox #(transaction) mon2scb;

    mailbox #(bit) mon2drv_ack;

    virtual full_adder_itf vitf;


  function new(virtual full_adder_itf vitf);

        this.vitf = vitf;

        gen2drv = new();
        drv2mon = new();
        mon2scb = new();

        mon2drv_ack = new();

        gen = new(gen2drv);

        drv = new(gen2drv,
                   drv2mon,
                   mon2drv_ack,
                   vitf);

        mon = new(drv2mon,
                  mon2scb,
                  mon2drv_ack,
                  vitf);

        scb = new(mon2scb);

    endfunction


    task run();

        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join

    endtask

endclass
