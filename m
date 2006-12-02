Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4GOeP0023924
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 11:24:40 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB4GMt5U010820
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 16:22:55 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kB4GMC41003938
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 11:22:12 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kB4GMCXP003937
	for selinux@tycho.nsa.gov; Mon, 4 Dec 2006 11:22:12 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB2JLDuh017913
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 14:21:13 -0500
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB2JJTSq022402
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 19:19:29 GMT
Message-ID: <4571D234.5000207@hp.com>
Date: Sat, 02 Dec 2006 14:21:24 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
Cc: russell@coker.com.au, James Antill <jantill@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: User home directory creation with useradd (rhbz#217441)
References: <6FE441CD9F0C0C479F2D88F959B015885C821F@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C821F@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> The sys-admin is wanting to create an entry for a user who 
>>> can login.  They don't want to think about creating a home 
>>> directory, creating a group, a user, a home directory, a SE 
>>> Linux user, and a SE Linux login mapping entry.
>>> 
> 
> 
> Doesn't matter, semanage doesn't need any more feature creep than it has
> right now.

I don't want more stuff in semanage.  We should be able to do it from
useradd, and from one role.  Right now its a multi step operation and
we can't run useradd and semanage from the same role.  Only sysadm_r
can run useradd and only secadm_r can run semanage with the current
MLS policy.

I've also noticed that only secadm_r can change the selinux context
of a file (makes sense) but secadm_r can't change the mode bits of
the same file, only sysadm_r can.  That doesn't make sense to me.
I don't know if that's a bug, a feature or a configuration problem
on my system (and is somewhat off-topic) but its another example of
illogical behavior.  Seems like secadm_r can do SELinux things but
not other security administration unrelated to SELinux, and that
makes SELinux look like a wart rather than an integrated feature.

Ok, here's another example.  secadm_r can manage policy but can't
'touch /.autorelabel', only sysadm_r can do that.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
