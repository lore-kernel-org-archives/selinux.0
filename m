Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16800
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 08:41:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA06137
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 13:40:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA06133
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 13:40:54 GMT
Date: Mon, 26 Nov 2001 08:40:40 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Configure.help
In-Reply-To: <20011125135537.72F96B75@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0111260827140.9982-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 25 Nov 2001, Russell Coker wrote:

> Here's a little snippet for Configure.help.  Could it (or something more
> detailed) be included in the next release?

We used to have Configure.help text for the SELinux kernel options (and
default option settings in arch/i386/defconfig) in the original SELinux
kernel patch (prior to migrating to LSM).  I've deferred adding these
changes to our patch to the LSM-patched kernel so far, since it often
requires updating that patch for every new kernel version (currently, that
patch only modifies the security/{Config.in,Makefile} files added by LSM,
which rarely change).  But I can transfer this text from the original
SELinux kernel patch (with minor updates) for future releases.

As a side note on your actual text, the Development Module option is
recommended for new users of SELinux, as noted in the README.  In fact,
some users of SELinux may chose to always build with the Development
Module option and may simply use avc_toggle in an rc script to switch
into enforcing mode during startup, always leaving them with the option
of switching back to permissive mode as an administrator if desired.
Or they can build without the Development Module option after verifying
that the security policy configuration works for their needs if they want
stricter security.  That's up to the user.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
