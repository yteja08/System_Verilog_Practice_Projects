class generator;

    transaction tr;
  mailbox #(transaction) gen2drv;

    function new(mailbox #(transaction) gen2drv);
        this.gen2drv = gen2drv;
    endfunction

    task run();
      repeat(40) begin
            tr = new();

        if (!tr.randomize())
          $display("Randomization Failed");

            gen2drv.put(tr);

            $display("Generator: a=%0d b=%0d cin=%0d",
                     tr.a, tr.b, tr.cin);
        end
    endtask

endclass
