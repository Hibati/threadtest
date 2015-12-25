class ThreadsController < ApplicationController
    @@order = 0
    @@th = []
    @@thread =Array.new(10)
    @@stopflag = []
    def new
        
        
        @localorder = @@order 
        @@th << t =  Thread.new do
        @@stopflag << 0
        #  @@order = @@order+1     
                loop do 
                    
                    if @@stopflag[@localorder]==1
                        Thread.stop
                    end
                    r = @@thread
                    
                    p r
                    p @@stopflag[@localorder]
                    sleep 3
                end
            end
    
        @@order = @@order+1         
        s=String.try_convert(t.to_s)
        t  = s.index(":")
        
    
        @@thread.push(s[t+1,s.length-10])    
        
        redirect_to action: 'index' 
    end
    
    def delete
        
        
        @@th.each do |th| 
            s=String.try_convert(th.to_s)
            t  = s.index(":")
            u = s[t+1,s.length-10]
            if u.eql? params[:id]
                th.exit
            end
            
             
        end
        
        redirect_to action: 'index'
    end
    def stop
         
        @@stopflag[params[:order].to_i] = 1
        redirect_to action: 'index' 
    end
    
    def start
        @@th.each do |th| 
            s=String.try_convert(th.to_s)
            t  = s.index(":")
            u = s[t+1,s.length-10]
            if u.eql? params[:id]
                @@stopflag[params[:order].to_i] = 0
                if th.status
                
                    th.wakeup
                end
            end
            
             
        end
        redirect_to action: 'index' 
        
    end
    
    def index
       
        @i =0
         @localthread = @@thread
        @me = @@th
        
    end
    
end
