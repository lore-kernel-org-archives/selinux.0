Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA20850
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 10:07:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA05376
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 14:05:50 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA05372
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 14:05:36 GMT
Date: Thu, 9 May 2002 10:06:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kmod.te
In-Reply-To: <20020509054938.BC169310F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205091000120.1046-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 9 May 2002, Russell Coker wrote:

> In that case I think that we should have a macro for the majority of the
> insmod policy instead of duplicating policy code.  I suggest that the macro
> be in the start of modutil.te and be used twice from there.  I think that
> such policy belongs in modutil.te because the modules utilities are optional
> (you can compile a kernel without module support), but kmod.te will always be
> required.

I'm not sure I follow you.  If you want a shared macro between kmod.te and
modutils.te, then we should create a new macros file, e.g.
macros/program/modutils_macros.te.

> Also is there any system using a version of modutils that has separate
> programs for insmod, rmmod, and modprobe but which runs the required versions
> of all other software for running SE Linux?  If not then I suggest that we
> remove all references to having separate programs from the policy.

That's fine with me as long as it doesn't break compatibility for any
SELinux users.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
