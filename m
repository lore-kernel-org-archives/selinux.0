Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4]) by
	tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3T0l0I4026287 for
	<selinux@tycho.nsa.gov>; Mon, 28 Apr 2003 20:47:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1]) by
	jazzband.ncsc.mil  with ESMTP id h3T0kx7R005949 for
	<selinux@tycho.nsa.gov>; Tue, 29 Apr 2003 00:46:59 GMT
Received: from sat.sws.net.au ([202.5.161.49]) by jazzband.ncsc.mil  with
	ESMTP id h3T0kkKP005946 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2003
	00:46:57 GMT
Received: from localhost (localhost [127.0.0.1]) by sat.sws.net.au
	(Postfix) with ESMTP id 41E19BF37 for <selinux@tycho.nsa.gov>; Tue, 29 Apr
	2003 10:46:33 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1]) by localhost (sat
	[127.0.0.1:10024]) (amavisd-new) with ESMTP id 30632-07 for
	<selinux@tycho.nsa.gov>; Tue, 29 Apr 2003 10:46:32 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2]) by
	sat.sws.net.au (Postfix) with ESMTP id EB232BF11 for
	<selinux@tycho.nsa.gov>; Tue, 29 Apr 2003 10:46:31 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1]) by tsv.sws.net.au
	(Postfix) with ESMTP id ADF98924A3 for <selinux@tycho.nsa.gov>; Tue, 29 Apr
	2003 10:46:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1]) by lyta.coker.com.au
	(Postfix) with ESMTP id 9AA227B40 for <selinux@tycho.nsa.gov>; Tue, 29 Apr
	2003 10:45:33 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: busybox wrapper rough design
Date: Tue, 29 Apr 2003 10:45:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <200304291045.32789.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

busybox is a program that contains dozens of utilities in cut-down form.  A 
typical compile will have init, getty, ps, ls, ping, and much more.

This makes things difficult when using SE Linux as several of those programs 
would normally have different types to trigger automatic domain transition 
rules.

So I am writing a bbwrap program which runs in it's own domain and can 
transition to ping_t, getty_t, login_t, etc when running busybox_t.

The bbwrap program does the following:

1)  Check argv[0] and make sure it's an absolute or relative path (IE it 
contains an absolute or relative path.

2)  lstat_secure(argv[0]) to determine the type of the link.

3)  Determine it's parent domain via getosecsid().

4)  Read it's config file which is something like the following.  The first 
field is the parent SID, the second is the type of the link, the third is the 
domain to transition to, and the fourth is the program to run.
user_t ping_exec_t ping_t /bin/busybox
sysadm_t ping_exec_t ping_t /bin/busybox

So if user_t runs bbwrap with an argv[0] of a symlink that has type 
ping_exec_t then it will mean to run /bin/busybox with argv[0] of "ping" in 
domain ping_t.

5)  Check whether the type of the link would be a suitable entry point for the 
target domain if it was a file.  In this example ping_t can be entered via 
ping_exec_t so it's OK.

6)  Use execve_secure() to run the program with argv[0] being the basename(1) 
of the original argv[0], the filename being the fourth parameter of the 
config file, and the context being the original context with the domain 
changed to the target domain.


Now if you can create a symlink of the appropriate type or a hard link to such 
a symlink then it is assumed that you are authorised for controlling which 
programs enter the domain in question (just as if you could create a file of 
the type in question on a regular SE Linux setup).  A correct SE policy 
prevents unauthorized users from doing such things (and if it doesn't then 
it's exploitable anyway).

The issue is, can someone trick such a wrapper program into thinking that it's 
run with a link named "sh" while it's running a link with type init_exec_t?


I welcome any comments on or off list.  I plan to publish this program in a 
couple of days...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
