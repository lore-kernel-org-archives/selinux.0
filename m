Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA06766
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 17:52:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA21122
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 21:51:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA21116
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 21:51:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Linux Security Module <linux-security-module@wirex.com>
Subject: Re: OLS: Packaging NSA SELinux for Debian
Date: Sun, 30 Jun 2002 00:41:30 -0400
References: <3D1E051B.1020500@wirex.com>
In-Reply-To: <3D1E051B.1020500@wirex.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020704214517.C94FF2B9D@lyta.coker.com.au>
List-ID: <selinux@tycho.nsa.gov>

>     * Q: [Alan Cox] should dpkg create files in a super-secure mode to
>       prevent install-time tampering, and some stuff about /tmp handling
>       that I couldn't hear
>     * A: couldn't hear Russ' answer either

Apparently there are some potential race conditions regarding files in /tmp, 
I have made a change to my policy tree to address one this which I will 
release soon.

Most of the stuff about /tmp was about how when user_t domain processes 
create files in /tmp they get type user_tmp_t while sysadm_t processes create 
files as sysadm_tmp_t.  This means that users can't read files from the 
administrator, but as the administrator can read files from the users we will 
be vulnerable to symlink race conditions.

In some situations it may be desirable to prevent sysadm_t from reading links 
that have type user_tmp_t to avoid such sym-link attacks (although stacking 
OpenWall would probably be a better solution).


I will put my slides on http://www.coker.com.au/selinux/ols/ in the near 
future, however reading Crispin's notes is probably a good idea too, he noted 
quite a few things that aren't in my slides...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
