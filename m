Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69CJnHa022829
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 08:19:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h69CIqnJ016056
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 12:18:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h69CIphr016053
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 12:18:51 GMT
Subject: Re: context trouble with 2.5 bits
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
In-Reply-To: <200307091017.42539.russell@coker.com.au>
References: <1057701768.25921.53.camel@columbia>
	 <200307091017.42539.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1057753181.13738.29.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jul 2003 08:19:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-08 at 20:17, Russell Coker wrote:
> Also while in permissive mode do some tests at the command line, do:
> # echo user_u:user_r:user_t > /proc/whatever-it-is
> # id
> 
> Then id should report a context of user_u:user_r:user_t if the context change 
> is working correctly.

You can't change your context on-the-fly like this, since we only permit
context transitions upon exec, and you cannot effectively test
/proc/self/attr/exec from the shell, as the attribute is per-process and
automatically cleared upon exec.  You can use the 'execcon' utility from
libselinux or 'runcon' (formerly runas) from the patched coreutils to
try it, e.g. 'execcon root:sysadm_r:sysadm_t /bin/bash'. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
