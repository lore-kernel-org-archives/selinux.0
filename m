Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux@tycho.nsa.gov
Subject: install parameters
Date: Fri, 28 Sep 2001 20:03:30 +0200
MIME-Version: 1.0
Message-Id: <20010928180802.58DC4369FB6@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any reason why selinux/module/Makefile runs "install" without using 
the "-m" parameter to specify the permissions?

I think that installing /usr/local/selinux/flask/* mode 755 is a bad idea, 
executing them could lead to unexpected results (yes I know that people 
should be smart enough to not execute them, but it's easy for us to get the 
permissions right).

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
