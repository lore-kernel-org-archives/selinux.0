Subject: Re: changes in ~2.6.13 break postfix policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Erich Schubert <erich@debian.org>, Chris Wright <chrisw@osdl.org>,
   Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
In-Reply-To: <20051111120511.GC9115@lkcl.net>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
	 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
	 <20051104183551.GC2837@legolas.drinsama.de>
	 <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
	 <1131148407.1355.21.camel@wintermute.xmldesign.de>
	 <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil>
	 <1131478271.17745.6.camel@wintermute.xmldesign.de>
	 <1131543371.20591.460.camel@moss-spartans.epoch.ncsc.mil>
	 <1131648624.19626.122.camel@moss-spartans.epoch.ncsc.mil>
	 <20051111120511.GC9115@lkcl.net>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 09:46:25 -0500
Message-Id: <1131979585.5415.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-11 at 12:05 +0000, Luke Kenneth Casson Leighton wrote:
> raised as 338543@bugs.debian.org.

Erich also posted the issue to the debian-kernel mailing list, and Jurij
Smakov responded that CONFIG_SECURITY_NETWORK will be enabled in the
2.6.14-3 Debian kernel.

We should likely make SELinux depend on SECURITY_NETWORK in its Kconfig
since this is now necessary, and drop the #if's from hooks.c for it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
