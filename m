Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAE5QSf003702
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 09:05:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAAE511W002055
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 14:05:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hAAE515e002052
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 14:05:01 GMT
Subject: Re: Invalid Security Context error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dhruv Gami <dgami@uncc.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200311090545.hA95j16H029965@ns3.biznetindia.com>
References: <200311090545.hA95j16H029965@ns3.biznetindia.com>
Content-Type: text/plain
Message-Id: <1068473123.32532.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 Nov 2003 09:05:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-09 at 00:45, Dhruv Gami wrote:
> Hello Everyone,
> 
> finally i managed to compile everything, though some of the patches
> needed manual changes (will post a list of patches that didnt work
> properly).
> 
> Now, when i rebooted the machine for the first time after compiling
> everything, and following the README doc step by step, i was asked
> 
> -------------
> login: root
> password: *****
> 
> would you like to enter a security context? [y]
>        Enter role sysadm_r
>        Enter type sysadm_t
> Not a valid security context
> -------------
> 
> have i missed some context setting somewhere ?
> 
> regards,
> Gami

This implies that you never loaded a policy during initialization.
You can either perform the load via an initrd as described in
the README, or you can use Dan's patched init program.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
