Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAEB4jIi018717
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 06:04:45 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAEB3Icp021169
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 11:03:18 GMT
Date: Sun, 14 Nov 2004 11:15:27 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Andrew Bartlett <abartlet@samba.org>
Cc: russell@coker.com.au, Stephen Smalley <sds@epoch.ncsc.mil>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   Chad Hanson <chanson@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Multiple recipients of list SAMBA-TECHNICAL <samba-technical@samba.org>
Subject: Re: dynamic context transitions
Message-ID: <20041114111527.GK5031@lkcl.net>
References: <418662EE.5090001@trustedcs.com> <20041101203524.GJ9643@lkcl.net> <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil> <200411090142.16657.russell@coker.com.au> <1100395104.13794.12.camel@piglett.bartlett.house>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100395104.13794.12.camel@piglett.bartlett.house>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Nov 14, 2004 at 12:18:24PM +1100, Andrew Bartlett wrote:

> On Tue, 2004-11-09 at 01:42, Russell Coker wrote:

> On the other hand, adding an extra #ifdef to become_user() and friends
> is a small, maintainable solution.  It just may not fit with the SELinux
> world view.

andrew,

your comments are appreciated - esp. the ones about ensuring
maintainability.

i should point out [because you may not be on the selinux ml]
that about 10 days ago stephen smalley said that, all things
being considered, he was happy for a "seteuid"-like extension
to selinux to be added, and urged the discussion to move from
"if" to "how".

a seteuid-like function, which allows a single process to
transition to a new domain - yes, it would be called in become_user,
become_root and the corresponding "un"s.

i've said it before (and won't mention it again, i promise!) but
personally i believe it far more sensible [and this is a
practical solution that i believe could be done _now_ without
any samba or selinux code modifications, just some time writing
up the config files and policies] to run a samba-4 server with
an smb client vfs redirector going to a samba-3 back-end smbd
server on the same machine.

there are many ways in which such a scheme could be improved
to give performance gains, but to "get something working and
secure" they are not necessary.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
