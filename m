Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2E3qXZ005452
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:03:52 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2E3lAw019419
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:03:52 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <1099361880.3998.4.camel@nexus.verbum.private>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
	 <1099361880.3998.4.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1099403997.31739.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 08:59:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 21:18, Colin Walters wrote:
> I can see some specialized uses for this with e.g. the Samba example,
> but I'm having trouble seeing how it would be broadly useful, although I
> haven't thought about the MLS case much.  But in your examples above,
> the policy can already restrict which ports a domain can bind; it
> doesn't seem useful to drop the privileges to bind to those ports.
> Also, why would it be useful to drop the privileges to read
> configuration files?

Classic example that shows up often in Fedora is allowing the daemon to
access the tty during startup for error reporting and user interaction
(e.g. ssl), then removing its ability to access the tty subsequently. 
In the past, you've talked about doing that via conditional policy
support, but I get the impression that is problematic, e.g. dealing with
daemon restart cleanly.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
