Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA28vJXZ003958
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 03:57:19 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA28vIAw004011
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 08:57:18 GMT
Date: Tue, 2 Nov 2004 09:08:08 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
Subject: Re: dynamic context transitions
Message-ID: <20041102090808.GT9643@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil> <20041101141025.GZ8897@lkcl.net> <418662EE.5090001@trustedcs.com> <1099361880.3998.4.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099361880.3998.4.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 09:18:00PM -0500, Colin Walters wrote:

> Also, why would it be useful to drop the privileges to read
> configuration files?
 
 it might not - i was looking for something (anything) that would help
 differentiate the two.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
