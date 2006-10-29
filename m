Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T1g7sG022310
	for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 21:42:07 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T1fKa8007970
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 01:41:21 GMT
Received: by wx-out-0506.google.com with SMTP id i26so1174687wxd
        for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 18:42:06 -0700 (PDT)
Subject: New to SELinux -- any suggestions?
From: Michael Graffam <michael.graffam@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 28 Oct 2006 21:41:20 -0400
Message-Id: <1162086080.2566.16.camel@endless>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone,

I just installed Fedora Core 6 on my laptop. In the past I've chosen to
disable selinux because it interfered with running my chosen programming
environment: Common Lisp. 

Having been increasingly impressed with FC, and its tools to manage
SELinux, this time I decided to roll up my sleeves and figure out what I
could do to make my Lisp systems work without throwing out the baby with
the bathwater. I'm glad I did, because a simple 

chcon -t uncontained_execmem_exec_t /usr/bin/sbcl
(and /usr/local/bin/lisp)

fixed my troubles. It begs the question, which I will soon pose to the
SBCL and CMUCL lists as to why, exactly, CL implementations require an
executable stack -- but that's another story. 

After fixing my problem, I wanted to demonstrate the behavior to a
friend of mine, and found that I didn't have the foggiest idea of how to
actually use chcon :) .. I couldn't remove the indicated permission from
my bins. 

So, my first questions is: how do I do that? 'man chcon' and 'info
chcon' didn't prove helpful. 

This leads to my second question: is there a comprehensive set of
documentation for the SELinux-related command set?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
