Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06229
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 07:21:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA20078
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:20:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA20074
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:20:05 GMT
Date: Thu, 31 Oct 2002 07:21:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: strange problem
In-Reply-To: <200210311246.37017.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210310713590.23380-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 31 Oct 2002, Russell Coker wrote:

> avc:  denied  { execute_no_trans } for  pid=11872 exe=/bin/bash
> path=/usr/bin/tr dev=09:03 ino=459224 scontext=system_u:system_r:crack_t
> tcontext=system_u:object_r:unlabeled_t tclass=file
> root@test:~# ls --context /usr/bin/tr
> -rwxr-xr-x  root     root     system_u:object_r:bin_t          /usr/bin/tr
> root@test:~#
>
> The above is a problem that's happened twice to me now.  This time it happened
> with all the SE patches applied, the previous time it happened without.
>
> When I run "tr" from the command line it works!
>
> So why is it being denied when run from crack_t?

This is expected without the separate SELinux patch due to a gap in LSM,
but should be addressed by the separate SELinux patch.  Please verify that
this happens with the SELinux patch applied (and not your hacked version
of the patch, but the original one).  Is this 2.4.19 or 2.5.44?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
