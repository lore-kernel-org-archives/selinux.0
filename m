Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB9J5HRb024329
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 14:05:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB9J4XlU007647
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 19:04:33 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hB9J4VSX007643
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 19:04:32 GMT
Date: Tue, 9 Dec 2003 19:05:03 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More on selinux-default policy install probs
Message-ID: <20031209190503.GA3812@vnl.com>
References: <20031209184253.GZ3812@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031209184253.GZ3812@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just so you can see what I'm seeing... first to make
sure all is virgin, I purge the files:

# dpkg --purge selinux-policy-default                         
(Reading database ... 15591 files and directories currently installed.)
Removing selinux-policy-default ...
Purging configuration files for selinux-policy-default ...

Okay, now we are in a clean state. I attempt to install
the policy package:

# dpkg -i selinux-policy-default_1%3a1.2.real-13_all.deb 
Selecting previously deselected package selinux-policy-default.
(Reading database ... 15228 files and directories currently installed.)
Unpacking selinux-policy-default (from selinux-policy-default_1%3a1.2.real-13_all.deb) ...
Setting up selinux-policy-default (1.2.real-13) ...
/etc/selinux does not exist, aborting!
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
"/bin/run-parts --arg=selinux-policy-default /etc/dpkg/postinst.d" failed: 256
dpkg: error processing selinux-policy-default (--install):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 selinux-policy-default

And it fails... and leaves the postinit.d hook 
behind just to make sure all other package
installs will fail too!

It looks to me like the postinst.d hook might run
before selinux-policy-default.postinst creates the
link. But that doesn't make sense because that 
would happen on any system and always fail the
first time around.

Next I guess I'll have to try debugging these
scripts to see why this happens...

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
