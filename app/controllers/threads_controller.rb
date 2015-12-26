class ThreadsController < ApplicationController
   
   #wget -O - https://railstest-hibati.c9users.io/
   
    @@order = 0
    @@th = []
    @@thread =Array.new(1)
    @@stopflag = []
    
    @@initialflag = 0
    def new
        
       
        createth()
       # p  @@thread[@@thread.length-1]
        Bgjob.create(:status => 0, :address =>@@thread[@@thread.length-1])
       redirect_to action: 'index'
      # render :action => :index
    end
    
    def delete
        
        
        deleteth()
        
        redirect_to action: 'index'
    end
    def stop
         
        @@stopflag[params[:order].to_i] = 1
        Bgjob.find_by(address: params[:id]).update(status: 1)
        
        redirect_to action: 'index' 
    end
    
    def start
          @@th.each do |th| 
            s=String.try_convert(th.to_s)
            t  = s.index(":")
            u = s[t+1,s.length-10]
            if u.eql? params[:id]
                
               
               # user.update(name: 'Dave')
                if th.status
                    # user = Bgjob.find_by(id: 3)
                    @@stopflag[params[:order].to_i] = 0
                   Bgjob.find_by(address: params[:id]).update(status: 0)
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
        @status = @@stopflag
        @c = 0
        
    end
    
    
    
    def initialize
        
      
        
       # params[:tt] = "hibati"
        
        if @@initialflag == 0
           @@initialflag  =1
            mytest()
        end
        
        
    end
    
    def startth
        
      
    end
    
    def mytest
        
    
     
     Bgjob.all.each do |t|
        
        createth()
        t.update(address: @@thread[@@thread.length-1])
        sleep(0.125)
        setstatus(@@order-1,t.status)
        #p @@order
        
        
     end
        
    end
    
    
    
    def createth
        
       
        localorder = @@order 
        @@stopflag << 0
         p  @@stopflag.to_s 
        @@th << t =  Thread.new do
        
       
        #  @@order = @@order+1     
                loop do 
                    
                    if @@stopflag[localorder]==1
                        Thread.stop
                    end
                    #r = @@thread
                    
                    p "I'm "+ localorder.to_s 
                    
                    sleep 3
                end
            end
    
        @@order = @@order+1         
        s=String.try_convert(t.to_s)
        t  = s.index(":")
        
    
        @@thread.push(s[t+1,s.length-10])    
    end
    
    
    
    def deleteth
        
          @@th.each do |th| 
            s=String.try_convert(th.to_s)
            t  = s.index(":")
            u = s[t+1,s.length-10]
            if u.eql? params[:id]
                th.exit
                 @@stopflag[params[:order].to_i] = -1
                 Bgjob.find_by(address: params[:id]).destroy
            end
            
             
        end
        
    end
    
    
    
    def setstatus(id,s)
        
        
          @@stopflag[id] =s
    end
end
