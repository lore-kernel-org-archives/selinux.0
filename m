Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24424
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 14:02:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA15995
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 19:01:15 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA15991
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 19:01:13 GMT
Date: Wed, 20 Mar 2002 14:02:15 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Leslie J. French" <ljf@semandex.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SMP mode?
In-Reply-To: <BFEMIIHKHLALNELLMPOMGEMDCAAA.ljf@semandex.net>
Message-ID: <Pine.GSO.4.33.0203201355360.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Leslie J. French wrote:

> Is it known if SELinux works/doesn't work when installed on top of
> RedHat7.1-smp? I'm running a dual-processor system and the apps (which are
> very CPU & network intensive) work OK in the normal boot and fail
> mysteriously in SELinux (e.g. "Operation not permitted" but with nothing in
> the log, even in avc "permissive" mode). It's running 2002011718 version.
>
> I'll repeat the experiment on a single-CPU box, since it is most likely my
> fault, but I'd appreciate it if it's *known* that there are problems in this
> area.

As far as I know, SELinux _should_ work on SMP, but it hasn't been tested.
SELinux uses coarse-grained locking at present, but that shouldn't
manifest as denials.  What are your kernel config option settings,
particularly the CONFIG_SECURITY_* settings?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
