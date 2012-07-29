Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6TKBAgQ012230
	for <selinux@tycho.nsa.gov>; Sun, 29 Jul 2012 16:11:10 -0400
Message-ID: <1343592651.8495.YahooMailClassic@web87701.mail.ir2.yahoo.com>
Date: Sun, 29 Jul 2012 21:10:51 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Is the CIL project still active
To: Joshua Brindle <method@manicmethod.com>
Cc: jwcart2@tycho.nsa.gov, Jeremy Solt <jsolt@tresys.com>,
        selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm only planning to run this in the same way as checkpolicy so not
worried about AOSP etc.

I'm using the most suitable CIL statements (block, macro etc.), but as
the policy is limited, not that many. I've converted all modules to
blocks, figured out the classmap/classmapping statements and almost
finished, although I'll probably wait for the next CIL release as I
have come across three minor problems:

1) Cannot call a macro within a booleanif block.

2) The mlsconstrain statements seem to be generated in reverse order but
   need to check manually as APOL etc doesn't handle them. Are there any
   utilities that will allow me to compare mlsconstrain statements within
   a binary policy?

3) Cannot generate a file context without at least one category (example
   always wants s0:c0-s0:c0 instead of the normal s0).

Otherwise the current CIL compiler is running well.

Richard

--- On Tue, 24/7/12, Joshua Brindle <method@manicmethod.com> wrote:

> From: Joshua Brindle <method@manicmethod.com>
> Subject: Re: Is the CIL project still active
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: jwcart2@tycho.nsa.gov, "Jeremy Solt" <jsolt@tresys.com>, selinux@tycho.nsa.gov
> Date: Tuesday, 24 July, 2012, 13:29
> Richard Haines wrote:
> > Glad to hear its still going as I started converting
> the Android
> > policy to CIL using the current compiler that works ok
> so far. However
> > I'm having problems defining 'sets of classes' for
> example with M4:
> 
> Since it is a small policy it should be possible to do a
> real, semantic 
> conversion (using blocks and ignoring legacy file types). Is
> that what 
> you are doing?
> 
> However, I'm not sure if CIL will be able to be in Android
> anytime soon. 
> It could still be used on the host side like
> checkpolicy/libsepol are 
> now but since CIL is currently statically linked against
> libsepol (GPL) 
> it would be prohibited in the AOSP userspace IIUC.
> 
> >
> > define(`dir_file_class_set (dir file lnk_file sock_file
> fifo_file
> > chr_file blk_file))
> >
> > I've tried various methods using classmap/classmapping
> etc. but failed
> > to work out how to define in CIL:
> >
> > mlsconstrain dir_file_class_set { create relabelfrom
> relabelto }
> > (l2 eq h2 and (l1 eq l2 or t1 == mlstrustedsubject));
> >
> > I can produce CIL mlsconstrain statements when I define
> them with each
> > class separately but not as a set. Is it possible with
> the current
> > release of CIL ? (if not I'll just produce an entry for
> each class so
> > I can continue).
> >
> > Thanks
> > Richard
> >
> >
> > --- On Fri, 20/7/12, James Carter<jwcart2@tycho.nsa.gov>
> wrote:
> >
> >> From: James Carter<jwcart2@tycho.nsa.gov>
> >> Subject: Re: Is the CIL project still active
> >> To: "Richard Haines"<richard_c_haines@btinternet.com>
> >> Cc: selinux@tycho.nsa.gov
> >> Date: Friday, 20 July, 2012, 20:13
> >> On Fri, 2012-07-20 at 19:39 +0100,
> >> Richard Haines wrote:
> >>> Does anyone know the status of the CIL project
> as it
> >> looked useful and would seem ideal for SEAndroid.
> >>
> >> There are still a few more bugs that need to be
> fixed so
> >> that it can
> >> correctly compile a CIL-transformed Refpolicy.
> Progress has
> >> been slow
> >> recently, but it is not going to be abandoned.
> >>
> >> --
> >> James Carter<jwcart2@tycho.nsa.gov>
> >> National Security Agency
> >>
> >>
> >
> >
> > --
> > This message was distributed to subscribers of the
> selinux mailing list.
> > If you no longer wish to subscribe, send mail to
> > majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the
> message.
> >
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the
> message.
>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
