Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02765
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:31:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA24325
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 20:30:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA24321
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 20:30:02 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 550FC92443
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 07:31:15 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2AA20226CF
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 21:31:08 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: does bin_t vs sbin_t really make sense?
Date: Thu, 21 Mar 2002 21:31:07 +0100
MIME-Version: 1.0
Message-Id: <20020321203108.2AA20226CF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been thinking about the division of bin_t vs sbin_t.

Does preventing a regular user from running a (non-SUID and non-SGID) program 
in /sbin actually gain us anything?  The only possible advantage I can see is 
if the user is denied execute access to all directories where they have write 
access, if the user is denied ptrace() access, and if we suspect that there 
is a kernel bug allowing one of these programs to do nasty things in spite of 
SE policy and unix permissions prohibiting it.

Having the two types just requires an additional entry on allow lines for no 
great benefit as far as I can tell.

What I think would be more useful is to give /usr/bin a different type, then 
you can either ban sysadm_t from executing it or trigger an automatic type 
conversion to something safe!

One reason for blocking sysadm_t from executing it is the issue of security 
holes in those programs which may allow hijacking an active session and 
causing a command to be run.  How many times have you run "man" as superuser? 
I know I've done it many times, there was at one time a bug in man that 
allowed non-root users to crash and possibly exploit a root invocation of 
man.  All you need to do is run "avc_toggle ; chmod 666 /etc/shadow" and the 
machine is open!

One reason for blocking sysadm_t instead of doing a type transition is to 
enforce safe usage.  I once shared root access of a machine with someone who 
gloried in having the power of root.  They used root for many things that 
they shouldn't have, which was a great concern for me as they didn't have 
much experience in Unix administration.  So I put the following in some of 
the more commonly used shell scripts:
"if [ "$USER" = "root" ]; then
  echo "Can't do this as root"
  exit 0
fi

;)


Of course someone that has full root access can easily change such things, if 
they know how and believe that they can do it without breaking anything.  But 
in this case they didn't.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
