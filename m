Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02193
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:20:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA10915
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:19:09 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA10907 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:19:09 GMT
Date: Thu, 21 Mar 2002 14:19:37 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: uses_shlib
In-Reply-To: <20020320225257.C7CB12EC7E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203211418050.19336-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> On Wed, 20 Mar 2002 21:51, Stephen Smalley wrote:
> > On Wed, 20 Mar 2002, Russell Coker wrote:
> > > The libc on my system uses a file named /etc/ld.so.preload.
> > > I have added the following line to my file_contexts:
> > > /etc/ld.so.preload              system_u:object_r:ld_so_t
> >
> > You mean ld_so_cache_t not ld_so_t, right?
>
> Both actually, I need the /etc/ld.so.preload as well.

I'll try again.  I think that the line in your file_contexts should be:
/etc/ld.so.preload              system_u:object_r:ld_so_cache_t

The ld_so_t type should only be applied to system dynamic linker programs,
not configuration files.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
