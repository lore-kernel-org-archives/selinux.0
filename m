Subject: Re: Question concerning building policy modules
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <46CC64FB.7010902@redhat.com>
References: <1187203804.26375.69.camel@moss-lions.epoch.ncsc.mil>
	 <46CB51E8.5020603@redhat.com>
	 <1187799601.20340.24.camel@moss-lions.epoch.ncsc.mil>
	 <46CC64FB.7010902@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 12:41:27 -0400
Message-Id: <1187800887.20340.39.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 12:31 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> James Carter wrote:
> > On Tue, 2007-08-21 at 16:58 -0400, Daniel J Walsh wrote:
> >> James Carter wrote:
> >>> Why isn't the Makefile and other information needed to build a module
> >>> separately in the appropriate /usr/share/selinux/<policy name>
> >>> directory?  This seems like the logical place for that information.  The
> >>> (not very well documented) "install-headers" make target in the
> >>> refpolicy Makefile does this.
> >>>
> >>> Instead, the information to build a module for Fedora is in
> >>> the /usr/share/selinux/devel directory.  This directory would seem to be
> >>> independent of the policy type, even though it is only for building
> >>> Fedora policies.  This seems confusing.  The devel directory should have
> >>> stuff that all policies need or could use.
> >>>
> >>> Wouldn't it make sense that if I wanted to build a module for the
> >>> current policy, I would use the Makefile in devel which would look
> >>> at /etc/selinux/config and include the Makefile for the current policy,
> >>> but if I wanted to compile for a particular policy, I would just use the
> >>> Makefile in its /usr/share directory?
> >>>
> >>>   
> >> This is an old argument, between strict and targeted policy.   I did not 
> >> like the idea of building
> >> policy modules different for each type of policy,  Since almost everyone 
> >> is exactly the same or would not work on different policies.  This seems 
> >> to be proven to be correct as we move to strict/targeted policy merge. 
> >>
> >> So you add a level of complexity with very little value.  
> > I don't think my scheme is very complex and it is certainly less
> > confusing.  I will, however, concede that it does cause difficulties to
> > the poor person trying to package Fedora policy.  I suppose that
> > selinux-policy-devel would have to create strict/include,
> > targeted/include, and mls/include.
> > 
> >> Just imagine a 
> >> third party shipping multiple policies for the
> >> same package depending on an infinite number of policy packages.
> >>
> >> targeted, strict, mls, olpc, CDS-ABC.
> >>
> >> And almost guaranteed the same policy package would work for all or the 
> >> package will only really work on one (MLS).  So I went with the least 
> >> common denominator and only ship one devel package.  
> > Which is certainly easier.
> > 
> > This patch would at least make it possible to use the devel/Makefile
> > with refpolicy.  How about a compromise?
> > 
> > --- Makefile.old	2007-08-22 06:06:48.000000000 -0400
> > +++ Makefile	2007-08-22 07:51:27.000000000 -0400
> > @@ -16,9 +16,20 @@
> >  ifeq ($(NAME), mls)
> >  	NAME = strict
> >  	MCSFLAG = -mls
> > +	TYPE ?= $(NAME)${MCSFLAG}
> > +	HEADERDIR = $(SHAREDIR)/devel/include
> >  endif
> >  
> > -TYPE ?= $(NAME)${MCSFLAG}
> > -HEADERDIR := $(SHAREDIR)/devel/include
> > +ifeq ($(NAME), strict)
> > +	TYPE ?= $(NAME)${MCSFLAG}
> > +	HEADERDIR = $(SHAREDIR)/devel/include
> > +endif
> > +
> > +ifeq ($(NAME), targeted)
> > +	TYPE ?= $(NAME)${MCSFLAG}
> > +	HEADERDIR = $(SHAREDIR)/devel/include
> > +endif
> > +
> > +HEADERDIR ?= $(SHAREDIR)/$(NAME)/include
> >  include $(HEADERDIR)/Makefile
> >  
> > 
> You want this change in F-7 and RHEL5?  This file has changed with the
> merging of strict/targeted

Sorry.  I am usually running refpolicy, which is probably why I have
problems.  Things work until refpolicy is not in sync with the policy
headers.

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFGzGT6rlYvE4MpobMRAsbdAJ0dvcs88uTp66brdQkdBMZHeyBvWQCfX1Cv
> 9XqoxwuEGqhQni3J9fs1Uzo=
> =fgH+
> -----END PGP SIGNATURE-----
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
