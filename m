Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA26779
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 07:20:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA21540
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 11:19:23 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA21530 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 11:19:23 GMT
Date: Tue, 9 Jul 2002 07:20:49 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: quota and ampd
In-Reply-To: <000401c226ca$7a507e20$6501a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0207090714340.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Jul 2002, Ryan Bergauer wrote:

> I just installed the new release of SELinux, and I get about 7 messages
> at boot-time requesting different permissions for quotaon, per the
> following:
>
> avc:   denied   { read } for  pid=141 exe=/sbin/quotaon
> path=/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION dev=03:02
> ino=1289283 scontext=system_u:system_r:quota_t
> tcontext=system_u:object_r:writeable_t tclass=file
>
> That wasn't there before the new release, and my kernel configuration
> should've been the same. Anyone else getting this?

The quota_t domain is new to this upstream release.  It was contributed by
Russell Coker.  Hence, it isn't surprising that you may see some denials
on RH systems, since Russell is using Debian.  Feel free to grant quota_t
read access to writeable_t (and even write access, if required).

> In addition, I'm getting quite a few denied messages at boot and
> shutdown regarding killall5 when I enable Advanced Power Management Bios
> in the kernel (with apmd_t wanting read-type permissions for items in
> init_t and kernel_t.) This sound familiar to anyone else? Please note
> that this was occurring before the new release, I just never got around
> to confronting it until now.

What are the specific audit messages (or at least some examples)?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
