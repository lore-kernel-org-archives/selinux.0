Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00290
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 08:37:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA14246
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 13:37:34 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA14242
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 13:37:33 GMT
Date: Wed, 28 Nov 2001 08:37:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Vasantha Harikrishna <vsharikrishna@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: access denial,networking in selinux
In-Reply-To: <F91HpPKdGQA6DrEOIvm00013849@hotmail.com>
Message-ID: <Pine.GSO.4.33.0111280835020.1519-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Nov 2001, Vasantha Harikrishna wrote:

> I had sucessfully proceded till lilo configaration of SELinux,when i
> rebooted my system with SELinux Kernel ,i get an aceess denial error during
> the next step of procedure:Viz make verbose in setfiles directory[error
> 126].

Did you login in the sysadm_r role and su to root prior to running
'make verbose'?  Did you get any avc log messages in /var/log/messages or
the 'dmesg' output?

> I have a 3c905 card which works in the normal linux kernel,but does not
> initialise during the booting process of seLinux?
> Awaiting a response at the earliest.Thanks in advance.

You need to enable the network driver in the kernel configuration when you
configure the LSM-patched kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
