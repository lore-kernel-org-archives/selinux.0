Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA26849
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 16:18:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA13988
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 21:17:45 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id VAA13984 for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 21:17:45 GMT
Date: Tue, 5 Mar 2002 16:18:20 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Odd acces denied messages
In-Reply-To: <1015361067.29041.1.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0203051615260.7137-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 5 Mar 2002, Justin Smith wrote:

> I get the following messages (have all along) and wonder what they mean:
>
> avc:  denied  { write } for  pid=1339 exe=/sbin/insmod
> path=/sys/kernel/tainted dev=00:03 ino=4144
> scontext=system_u:system_r:kmod_t
> tcontext=system_u:object_r:sysctl_kernel_t tclass=file
>
> avc:  denied  { write } for  pid=1340 exe=/sbin/insmod
> path=/sys/kernel/tainted dev=00:03 ino=4144
> scontext=system_u:system_r:kmod_t
> tcontext=system_u:object_r:sysctl_kernel_t tclass=file
>
> These messages come from my home computers (which has an nvidia card and
> driver). The one in my office does not have this card but still produces
> these messages.

/sbin/insmod tries to update the kernel's tainted flag when it loads a
non-GPL'd module.  You need to add the following statements to kmod.te and
modutil.te:

# policy/domains/system/kmod.te
allow kmod_t sysctl_kernel_t:file rw_file_perms;

# policy/domains/program/modutil.te
allow insmod_t sysctl_kernel_t:file rw_file_perms;

These statements have been added to the example policy configuration and
will be included in future public releases.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
