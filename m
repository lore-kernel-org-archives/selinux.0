Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04893
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 10:00:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA29983
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 13:59:06 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA29979 for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 13:59:05 GMT
Date: Wed, 24 Apr 2002 09:59:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: split admins
In-Reply-To: <20020424154523.B14453@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204240955190.17117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Apr 2002, Tom wrote:

> I've tried setting up a seperate "security admin" role, as a 1st step
> towards a split admin concept. Idea being that sysadm_r can not change the
> SELinux policy (obviously I'll have to think about "circumvention" ways
> like access to lilo, raw devices, etc. later), but a new role,
> secadm_r, has control over these areas.

When the example policy was originally being developed, there was an
initial attempt to provide such a distinction between a system
administrator and a security administrator, but the separate role was
discarded because it turns out to be very difficult to truly enforce a
separation between these two roles without severely limiting the system
administrator role, making it relatively useless.  The topic has also come
up previously on the list, e.g. see
http://marc.theaimsgroup.com/?l=selinux&m=100799744813965&w=2.

> one problem I encountered was that newrole -r secadm_r didn't work,
> kicking me out with:
> arkham:~# newrole -r secadm_r
> Couldn't get default type.
>
> So where do I set this default type? I didn't find anything obvious,
> and actually, I believed that my modification of domains/admin.te,
> which included role secadm_r type secadm_t would've taken care of that.

This is another one of those annoying application configuration files,
/etc/security/default_type.  Might be obsoleted in the future.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
