Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB9IhvRb024203
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 13:43:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB9IgglU005639
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 18:42:42 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hB9IgfSX005629
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 18:42:41 GMT
Date: Tue, 9 Dec 2003 18:42:53 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: More on selinux-default policy install probs
Message-ID: <20031209184253.GZ3812@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russ, I've a few minutes free this evening to dig into
the package problems and as a starter I suggest you experiment
with a way around this:

Attempt to install any old package after selinux-default-policy fails:

# dpkg -i dpkg-dev_1.10.18_all.deb 
(Reading database ... 15591 files and directories currently installed.)
Preparing to replace dpkg-dev 1.10.18 (using dpkg-dev_1.10.18_all.deb) ...
Unpacking replacement dpkg-dev ...
Setting up dpkg-dev (1.10.18) ...
/etc/selinux does not exist, aborting!
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
"/bin/run-parts --arg=dpkg-dev /etc/dpkg/postinst.d" failed: 256
dpkg: error processing dpkg-dev (--install):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 dpkg-dev

This happens because for some reason because /etc/selinux doesn't 
exist... in fact there is only a /usr/share/selinux/policy/default 
and no current left behind. Your postint.d script explicitely
forces a fail on every package install because of it.

Removing just the post install hook:

# mv /etc/dpkg/postinst.d/selinux /root/selinux

Allows normal dpkg installing to work again:

# dpkg -i dpkg-dev_1.10.18_all.deb 
(Reading database ... 15591 files and directories currently installed.)
Preparing to replace dpkg-dev 1.10.18 (using dpkg-dev_1.10.18_all.deb) ...
Unpacking replacement dpkg-dev ...
Setting up dpkg-dev (1.10.18) ...

-------------------------------

I'll try to dig deeper... for one I'd like to figure out why
the policy package install didn't create the link. As you can
probably guess I was installing dpkg-dev on the loopback image
so I can figure out what you've done to me ;-)

If this is something that could happen to anyone
who "just tries" installing selinux-default-policy
for the hell of it on a normal debian machine, it
could cause a bit of a problem for them.

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
