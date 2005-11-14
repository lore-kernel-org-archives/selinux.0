Date: Mon, 14 Nov 2005 18:07:13 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Erich Schubert <erich@debian.org>, Chris Wright <chrisw@osdl.org>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
Subject: Re: changes in ~2.6.13 break postfix policy?
In-Reply-To: <1131979585.5415.86.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0511141806340.30284@excalibur.intercode>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
 <20051104183551.GC2837@legolas.drinsama.de>  <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
  <1131148407.1355.21.camel@wintermute.xmldesign.de>
 <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil>
 <1131478271.17745.6.camel@wintermute.xmldesign.de>
 <1131543371.20591.460.camel@moss-spartans.epoch.ncsc.mil>
 <1131648624.19626.122.camel@moss-spartans.epoch.ncsc.mil>
 <20051111120511.GC9115@lkcl.net> <1131979585.5415.86.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Nov 2005, Stephen Smalley wrote:

> We should likely make SELinux depend on SECURITY_NETWORK in its Kconfig
> since this is now necessary, and drop the #if's from hooks.c for it.

Ok.  I also wonder how whether we still need CONFIG_SECURITY_NETWORK at 
all.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
