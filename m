Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA16962
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 10:54:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA04366
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 14:53:45 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id OAA04362
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 14:53:44 GMT
Date: Tue, 9 Oct 2001 10:53:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux versions, features, stability?
In-Reply-To: <20011008121600.071caa6e.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0110091051530.3214-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Oct 2001, forrest whitcher wrote:

> Several questions directed to the SE Linux principles
>
> Stephen, in your talk this spring at Usenix you noted that
> you had a server running SE Linux in production for a period
> of months.
>
> Can you advise what SE Linux version(s) are so used and what is
> the operational environment (Internet-exposed? services running
> in secured contexts?)

Hmm...Either I misspoke or you misunderstood me.  It is true
that I have run SELinux on my desktop and development machines
for quite some time (starting with the 2.2 SELinux kernel patch
and upgrading to the 2.4 SELinux kernel patch and the 2.4 LSM-based
SELinux module).  But I haven't run it on production servers.

> I expect that since the stable 2.2.19 kernel-patched version,
> through the 2.4 kernel-patched and into the currently recommended
> LSM-based version that you have added features and killed bugs.

Right.  And we haven't back ported improvements or bug fixes to the
older versions of SELinux, so I can't recommend them currently.  As
far as I know, no one has asked us to maintain the 2.2-based prototype.

> The NSA download site recommends that people use the most recent
> (LSM) code, which makes sense in development, as I doubt that
> the new versions maintain backward-compatibilty.
>
> Is this also the best (general) recommendation for trying to deliver
> an operational, secured system.

I don't think we have any particular recommendations for an operational,
secured system.  The SELinux functionality is useful, but it isn't a
product, and it uses the latest kernel versions, which aren't always
so stable.

> Within the caveat that I don't think NSA can (or should) take
> repsponsibility recommend SE Linux as a production system, are
> there any differences between the 3 major extant versions
> (2.2.19, 2.4, LSM) as regards deploying operational servers?

I've heard that the 2.2 Linux kernel is still preferred for stability,
but hopefully 2.4 will become just as stable soon.  As far as SELinux
goes, I don't see any reason to use the old 2.4.3 SELinux kernel patch.
Conceivably, you could back port bug fixes and improvements made to the
new software components of SELinux (the security server, access vector
cache, and persistent label mapping) to the 2.2.19 SELinux prototype.
Or you can wait for 2.4 to stabilize and use the LSM-based prototype.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
