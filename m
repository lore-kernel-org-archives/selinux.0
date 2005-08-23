Subject: Re: libselinux category patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
References: <430A33E5.1030100@redhat.com>
	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 14:03:20 -0400
Message-Id: <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 13:21 -0400, Stephen Smalley wrote:
> On Tue, 2005-08-23 at 12:52 -0400, Stephen Smalley wrote:
> > This appears to reflect both a problem in the patch and a problem in ls.
> > As far as the patch goes, when there is no libsetrans, the wrapper
> > functions (e.g. getfilecon) are always setting *context to rcontext even
> > if the raw function returned an error.  I think we need to qualify the
> > else clauses in the wrapper functions with if (ret > 0) as well so that
> > we do not set *context to garbage when an error is encountered by the
> > raw function.  I can make that change.
> 
> This patch relative to the translation patch fixes the wrapper functions
> to not set the context pointers when the raw functions return an error.
> This fixes the problem with ls -Z displaying garbage when it encounters
> a file or directory with no extended attribute value.

I've committed the libselinux translation support (including my fix
patch).  This is only the libselinux support; there is no libsetrans in
our tree presently (and likely shouldn't be).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
