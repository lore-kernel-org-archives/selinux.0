Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23967
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 09:33:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA21474
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:33:16 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id OAA21470
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:33:15 GMT
Date: Mon, 3 Dec 2001 09:33:46 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: boot messages
In-Reply-To: <1007212536.2059.0.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112030927080.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 1 Dec 2001, Justin Smith wrote:

> avc:  denied  { search } for  pid=93 exe=/bin/cat dev=00:08 ino=1
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:unlabeled_t
>    tclass=dir

I provided a possible explanation for these messages in my earlier
reply - see http://marc.theaimsgroup.com/?l=selinux&m=100688827827241&w=2.

> avc:  denied  { mounton } for  pid=149 exe=/bin/mount path=/local
> dev=03:0a ino=
> 32705
>    scontext=system_u:system_r:mount_t
>    tcontext=system_u:object_r:usr_t
>    tclass=dir

I'll add this permission to the example policy.

> avc:  denied  { write } for  pid=224 exe=/bin/mv path=/log dev=03:05
> ino=96193
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:var_log_t
>    tclass=dir
<text deleted>

I've seen these messages on RH7.2, and am adding permissions for RH7.2,
but I've never seen them on RH7.1.  RH7.1 is still our recommended base
platform, although we are working on the transition to RH7.2, as I've
explained in other postings.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
