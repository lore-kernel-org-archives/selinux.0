Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n377k5FK026268
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 03:46:05 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n377k5Pj029621
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 07:46:05 GMT
Received: by yx-out-1718.google.com with SMTP id 3so1648064yxi.84
        for <selinux@tycho.nsa.gov>; Tue, 07 Apr 2009 00:46:04 -0700 (PDT)
Message-Id: <B2B8AAE9-85F2-4A92-AA25-88C1493A2EB2@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: diff between name_bind,bind and node_bind
Date: Tue, 7 Apr 2009 09:46:00 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

i'm working on a tutorial for selinux. in this tutorial i use nc  
(netcat) as simple server. but i wonder, why nc -l 5555** (nc runs in  
a own domain) does not need the name_bind permission to bind a port.
i already asked here regarding to this, but nobody has answered.

can someone tell me how name_bind,bind and node_bind work and where  
the differences are?

i tried this  with socat (http://www.dest-unreach.org/socat/) too.  
same effect. both socat and nc  "never"* need name_bind.

is it possible that this pb is relying on how nc and socat work?

tnx in advance && if you need  further information, please let me  
know ...

--
Sebastian Pfaff

* funny is, if i implement a boolean which allows nc or socat to use  
any port or only a speficic port, then i can see a name_bind "entry"   
when in permissive mode in my avc log.  but i can't reproduce it.  
maybe this is another problem.
** same with echo "hello world" | socat - TCP-LISTEN: 
33331,bind=127.0.0.1 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
