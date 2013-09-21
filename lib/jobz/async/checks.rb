module Jobz
    module Async
        module Checks
            protected
            def check_queueable!(subject, method, *args)
                check_responds_to!(subject, method)
                check_arity!(subject, method, args.length)
            end

            def check_responds_to!(subject, method)
                unless subject.respond_to?(method)
                  raise "subject should respond to #{method}"
                end
            end

            def check_arity!(subject, method, arity)
                required = subject.method(method).arity
                # Optional arguments
                if required < 0 && arity < -required
                  raise "#{method}: #{arity} of #{-required} arguments given"
                # Fixed-number of arguments
                elsif required >= 0 && required != arity
                  raise "#{method}: #{arity} of #{required} arguments given"
                end
            end
        end
    end
end