Subject: Re: [PATCH] [STABLE] Makefile change to disable restorecond
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47600F63.7070502@manicmethod.com>
References: <475EED72.3090607@manicmethod.com>
	 <475EEF4D.4000807@manicmethod.com>
	 <1197404396.28006.111.camel@moss-spartans.epoch.ncsc.mil>
	 <475FF9B9.20005@manicmethod.com>
	 <1197473703.1125.55.camel@moss-spartans.epoch.ncsc.mil>
	 <476005F9.2030705@manicmethod.com>
	 <1197475904.1125.75.camel@moss-spartans.epoch.ncsc.mil>
	 <47600F63.7070502@manicmethod.com>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 11:47:10 -0500
Message-Id: <1197478030.1125.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-12 at 11:42 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-12-12 at 11:02 -0500, Joshua Brindle wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> On Wed, 2007-12-12 at 10:09 -0500, Joshua Brindle wrote:
> >>>   
> >>>       
> >>>> Stephen Smalley wrote:
> >>>>     
> >>>>         
> >>>>> On Tue, 2007-12-11 at 15:13 -0500, Joshua Brindle wrote:
> >>>>>   
> >>>>>       
> >>>>>           
> >>>>>> Joshua Brindle wrote:
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>>>> This patch is necessary to build stable on RHEL4. CLIP uses the 
> >>>>>>> current stable toolchain and supports RHEL4 as a target so we are 
> >>>>>>> trying to upstream any magic that is necessary to build on that platform.
> >>>>>>>
> >>>>>>>       
> >>>>>>>           
> >>>>>>>               
> >>>>>> Ignore last patch, this one is actually against stable :)
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>> What about just checking for the presence of /usr/include/sys/inotify.h
> >>>>> and disabling restorecond in its absence, similar to handling of PAMH
> >>>>> and AUDITH in newrole's Makefile?  Then that could go into trunk too.
> >>>>>   
> >>>>>       
> >>>>>           
> >>>> The next problem is that libselinux won't build on RHEL4 without 
> >>>> building the .lo files with --ftls-model=initial-exec. Do you have an 
> >>>> opinion on how to switch this on/off for building there?
> >>>>     
> >>>>         
> >>> We already have a TLSFLAGS definition for the .o files, so I suppose we
> >>> could have two definitions, one for the .o files and one for the .lo
> >>> files, and put them in the Makefile, and then you'd just build with make
> >>> SHARED_TLSFLAGS="-ftlsmodel=initial-exec" or whatever for RHEL4.
> >>>
> >>> Or the other alternative would be to make the use of TLS completely a
> >>> build-time option, which would help for distributions where it isn't
> >>> supported at all.  That shouldn't be too difficult; Manoj posted a patch
> >>> he was using for Debian a long time ago.
> >>>   
> >>>       
> >> Ok, I see http://marc.info/?l=selinux&m=115807948020898&w=2
> >> This makes TLS unnecessary at all though, right? I have no problem with 
> >> this as TLS makes me fairly uneasy anyway. Are you comfortable with 
> >> Manoj's patch? I didn't see any discussion of it at all on list after he 
> >> sent it..
> >>     
> >
> > I wasn't sure about unconditionally removing use of TLS (after all, if
> > it is supported, why not use it?), but a patch that made its use a
> > build-time option was ok with me if it didn't turn out to be too ugly to
> > maintain.
> >   
> 
> Well, if Manoj fixed the interfaces where it is unnecessary I'd support 
> removing it, TLS seems like a horrible way to hack around thread unsafe 
> code to me. What do we gain by fixing interfaces to not need it but use 
> it anyway?

Sure - in cases where tls wasn't truly needed at all, it should be
removed.  But in cases where it was replaced by mutexes and the like,
there is an obvious tradeoff and we don't necessarily want to impose
that on systems that support tls (although I have no idea as to the real
performance tradeoffs there).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
