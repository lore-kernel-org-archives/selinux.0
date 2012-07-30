Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6UIaQ6j008575
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2012 14:36:26 -0400
Message-ID: <1343673383.28025.YahooMailClassic@web87701.mail.ir2.yahoo.com>
Date: Mon, 30 Jul 2012 19:36:23 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Is the CIL project still active
To: jwcart2@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>, Jeremy Solt <jsolt@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1343657120.1722.11.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Regarding the mlsconstrain reverse order problem:

I've taken one example from the sepolicy and my corresponding entry
in CIL format. As you can see the generated output is different but
I'm not sure what is actually generated in the binary policy file.

sepolicy from seandroid repository - mls file entry:
mlsconstrain process { transition dyntransition }
	     ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);

The entry generated in the policy.conf file:
mlsconstrain process { transition dyntransition }
	     ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);

I generated this entry in the mls CIL file using the CIL format:
(mlsconstrain (kernel.process (transition dyntransition))
    (and (or (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject)))

The entry generated in the policy.conf file is:
mlsconstrain kernel.process { transition dyntransition };
	(((h2 eq h1) or (l2 eq l1)) and (mlstrustedsubject eq t1));

As you can see the (xx eq yy) entries are reversed and the 'or' is
first with the 'and' second. It could be that I've mis-understood the
CIL format.

Richard


--- On Mon, 30/7/12, James Carter <jwcart2@tycho.nsa.gov> wrote:

> From: James Carter <jwcart2@tycho.nsa.gov>
> Subject: Re: Is the CIL project still active
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: "Joshua Brindle" <method@manicmethod.com>, "Jeremy Solt" <jsolt@tresys.com>, selinux@tycho.nsa.gov
> Date: Monday, 30 July, 2012, 15:05
> On Sun, 2012-07-29 at 21:10 +0100,
> Richard Haines wrote:
> > I'm only planning to run this in the same way as
> checkpolicy so not
> > worried about AOSP etc.
> > 
> > I'm using the most suitable CIL statements (block,
> macro etc.), but as
> > the policy is limited, not that many. I've converted
> all modules to
> > blocks, figured out the classmap/classmapping
> statements and almost
> > finished, although I'll probably wait for the next CIL
> release as I
> > have come across three minor problems:
> > 
> > 1) Cannot call a macro within a booleanif block.
> > 
> 
> That has been fixed at some point since the last release.
> 
> > 2) The mlsconstrain statements seem to be generated in
> reverse order but
> >    need to check manually as APOL etc doesn't
> handle them.
> 
> Generated in the binary in reverse order? I don't understand
> what you
> are referring to here.
> 
> >  Are there any
> >    utilities that will allow me to compare
> mlsconstrain statements within
> >    a binary policy?
> > 
> 
> sediff doesn't handle constraints and I don't know of a tool
> that will
> do that comparison.
> 
> > 3) Cannot generate a file context without at least one
> category (example
> >    always wants s0:c0-s0:c0 instead of the
> normal s0).
> > 
> 
> This does need to be fixed.
> 
> > Otherwise the current CIL compiler is running well.
> > 
> 
> Thanks for your feedback.
> Jim
> 
> > Richard
> > 
> > --- On Tue, 24/7/12, Joshua Brindle <method@manicmethod.com>
> wrote:
> > 
> > > From: Joshua Brindle <method@manicmethod.com>
> > > Subject: Re: Is the CIL project still active
> > > To: "Richard Haines" <richard_c_haines@btinternet.com>
> > > Cc: jwcart2@tycho.nsa.gov,
> "Jeremy Solt" <jsolt@tresys.com>,
> selinux@tycho.nsa.gov
> > > Date: Tuesday, 24 July, 2012, 13:29
> > > Richard Haines wrote:
> > > > Glad to hear its still going as I started
> converting
> > > the Android
> > > > policy to CIL using the current compiler that
> works ok
> > > so far. However
> > > > I'm having problems defining 'sets of
> classes' for
> > > example with M4:
> > > 
> > > Since it is a small policy it should be possible
> to do a
> > > real, semantic 
> > > conversion (using blocks and ignoring legacy file
> types). Is
> > > that what 
> > > you are doing?
> > > 
> > > However, I'm not sure if CIL will be able to be in
> Android
> > > anytime soon. 
> > > It could still be used on the host side like
> > > checkpolicy/libsepol are 
> > > now but since CIL is currently statically linked
> against
> > > libsepol (GPL) 
> > > it would be prohibited in the AOSP userspace
> IIUC.
> > > 
> > > >
> > > > define(`dir_file_class_set (dir file lnk_file
> sock_file
> > > fifo_file
> > > > chr_file blk_file))
> > > >
> > > > I've tried various methods using
> classmap/classmapping
> > > etc. but failed
> > > > to work out how to define in CIL:
> > > >
> > > > mlsconstrain dir_file_class_set { create
> relabelfrom
> > > relabelto }
> > > > (l2 eq h2 and (l1 eq l2 or t1 ==
> mlstrustedsubject));
> > > >
> > > > I can produce CIL mlsconstrain statements
> when I define
> > > them with each
> > > > class separately but not as a set. Is it
> possible with
> > > the current
> > > > release of CIL ? (if not I'll just produce an
> entry for
> > > each class so
> > > > I can continue).
> > > >
> > > > Thanks
> > > > Richard
> > > >
> > > >
> > > > --- On Fri, 20/7/12, James Carter<jwcart2@tycho.nsa.gov>
> > > wrote:
> > > >
> > > >> From: James Carter<jwcart2@tycho.nsa.gov>
> > > >> Subject: Re: Is the CIL project still
> active
> > > >> To: "Richard Haines"<richard_c_haines@btinternet.com>
> > > >> Cc: selinux@tycho.nsa.gov
> > > >> Date: Friday, 20 July, 2012, 20:13
> > > >> On Fri, 2012-07-20 at 19:39 +0100,
> > > >> Richard Haines wrote:
> > > >>> Does anyone know the status of the
> CIL project
> > > as it
> > > >> looked useful and would seem ideal for
> SEAndroid.
> > > >>
> > > >> There are still a few more bugs that need
> to be
> > > fixed so
> > > >> that it can
> > > >> correctly compile a CIL-transformed
> Refpolicy.
> > > Progress has
> > > >> been slow
> > > >> recently, but it is not going to be
> abandoned.
> > > >>
> > > >> --
> > > >> James Carter<jwcart2@tycho.nsa.gov>
> > > >> National Security Agency
> > > >>
> > > >>
> > > >
> > > >
> > > > --
> > > > This message was distributed to subscribers
> of the
> > > selinux mailing list.
> > > > If you no longer wish to subscribe, send mail
> to
> > > > majordomo@tycho.nsa.gov
> > > with
> > > > the words "unsubscribe selinux" without
> quotes as the
> > > message.
> > > >
> > > 
> > > --
> > > This message was distributed to subscribers of the
> selinux
> > > mailing list.
> > > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov
> > > with
> > > the words "unsubscribe selinux" without quotes as
> the
> > > message.
> > >
> > 
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the
> selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the
> message.
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
