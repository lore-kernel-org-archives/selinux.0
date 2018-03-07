Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w278JdtP007312
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 03:19:39 -0500
Received: by mail-pl0-f51.google.com with SMTP id y8-v6so898879pll.13
 for <selinux@tycho.nsa.gov>; Wed, 07 Mar 2018 00:19:36 -0800 (PST)
Date: Wed, 7 Mar 2018 16:19:33 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
Message-ID: <20180307081932.GA48369@baraddur.perfinion.com>
References: <36517f76-3d9b-63e3-a259-90ebfd0271e3@ieee.org>
 <7f95f7a5-4d25-7a2f-39fa-f34fac50d81e@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7f95f7a5-4d25-7a2f-39fa-f34fac50d81e@tycho.nsa.gov>
Subject: Re: libsepol policycap names
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 05, 2018 at 09:03:10AM -0500, Stephen Smalley wrote:
> On 03/02/2018 01:49 PM, Chris PeBenito wrote:
> > I've been able to make SETools dynamically link to libsepol.  However,
> > one challenge is with policycap names.  They're static libsepol, with
> > nothing that exports them.  Can we either:
> > 
> > * export the sepol_polcap_getname() function, or
> > * move the polcap_names[] in polcaps.c into <sepol/policydb/polcaps.h> ?
> > 
> > Then I can avoid having to manually keep a polcap name list inside SETools.
> 
> Let's do the former (and also export sepol_polcap_getnum for
> consistency).  Did you want to spin up a patch or were you asking us to
> do so?

If we put polcap_names[] in the .h file, would it mean that setools and
any other programs need to be re-compiled to see any changes? if thats
the case then only sepol_polcap_getname() would be easier for
maintenance.

-- Jason
