Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25104
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:11:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA11117
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:10:50 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id UAA11113 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:10:44 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524317@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "Leslie J. French"
	 <ljf@semandex.net>
Cc: selinux@tycho.nsa.gov
Subject: RE: SMP mode?
Date: Wed, 20 Mar 2002 14:11:55 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have it running on SMP box.

-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Wednesday, March 20, 2002 1:02 PM
To: Leslie J. French
Cc: selinux@tycho.nsa.gov
Subject: Re: SMP mode?



On Wed, 20 Mar 2002, Leslie J. French wrote:

> Is it known if SELinux works/doesn't work when installed on top of
> RedHat7.1-smp? I'm running a dual-processor system and the apps (which are
> very CPU & network intensive) work OK in the normal boot and fail
> mysteriously in SELinux (e.g. "Operation not permitted" but with nothing
in
> the log, even in avc "permissive" mode). It's running 2002011718 version.
>
> I'll repeat the experiment on a single-CPU box, since it is most likely my
> fault, but I'd appreciate it if it's *known* that there are problems in
this
> area.

As far as I know, SELinux _should_ work on SMP, but it hasn't been tested.
SELinux uses coarse-grained locking at present, but that shouldn't
manifest as denials.  What are your kernel config option settings,
particularly the CONFIG_SECURITY_* settings?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
