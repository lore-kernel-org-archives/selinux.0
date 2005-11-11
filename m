Date: Fri, 11 Nov 2005 12:05:11 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Erich Schubert <erich@debian.org>, Chris Wright <chrisw@osdl.org>,
   Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
Subject: Re: changes in ~2.6.13 break postfix policy?
Message-ID: <20051111120511.GC9115@lkcl.net>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de> <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil> <20051104183551.GC2837@legolas.drinsama.de> <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil> <1131148407.1355.21.camel@wintermute.xmldesign.de> <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil> <1131478271.17745.6.camel@wintermute.xmldesign.de> <1131543371.20591.460.camel@moss-spartans.epoch.ncsc.mil> <1131648624.19626.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131648624.19626.122.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

raised as 338543@bugs.debian.org.

On Thu, Nov 10, 2005 at 01:50:24PM -0500, Stephen Smalley wrote:

> On Wed, 2005-11-09 at 08:36 -0500, Stephen Smalley wrote:

> > On Tue, 2005-11-08 at 20:31 +0100, Erich Schubert wrote:
> > > Hi,
> > > > Hmmm...can you supply any more info to help reproduce the bug?
> > > 
> > > I've upgraded a box of mine running a self-compiled 2.6.14-rc3 to
> > > debians 2.6.14 - and the error has appeared on it, too.
> > > [...]
 
> Ok, I've tracked down the cause of this problem in the Debian kernels:
> they are disabling CONFIG_SECURITY_NETWORK, which disables all of the
> LSM socket hooks.  Thus, SELinux never gets a chance to classify the

> [...]

> I'd suggest asking the Debian kernel maintainers to entertain the notion
> of enabling CONFIG_SECURITY_NETWORK.  If they are being driven by


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
