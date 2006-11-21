Subject: Re: Compiling libsepol with -fPIC instead of -fpic
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
In-Reply-To: <4561E044.6050006@mentalrootkit.com>
References: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>
	 <4561E044.6050006@mentalrootkit.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 16:05:56 -0500
Message-Id: <1164143156.13758.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-20 at 12:05 -0500, Karl MacMillan wrote:
> Manoj Srivastava wrote:
> > Hi,
> > 
> >         I've had reports of packages filing to compile on SPARC
> >  hardware when linked with  libsepol1 which was compiled with
> >  -fpic. We seem to be hitting the global offset table size limit;
> > ,----[ GCC manual ]
> > | `-fpic'
> > |      Generate position-independent code (PIC) suitable for use in a
> > |      shared library, if supported for the target machine.  Such code
> > |      accesses all constant addresses through a global offset table
> > |      (GOT).  The dynamic loader resolves the GOT entries when the
> > |      program starts (the dynamic loader is not part of GCC; it is part
> > |      of the operating system).  If the GOT size for the linked
> > |      executable exceeds a machine-specific maximum size, you get an
> > |      error message from the linker indicating that `-fpic' does not
> > |      work; in that case, recompile with `-fPIC' instead.  (These
> > |      maximums are 8k on the SPARC and 32k on the m68k and RS/6000.  The
> > |      386 has no such limit.)
> > `----
> > 
> >         Simply recompiling with -fPIC corrects the problem.
> > 
> >         manoj
> > 
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > --- orig/src/Makefile
> > +++ mod/src/Makefile
> > @@ -24,10 +24,10 @@
> >  	ln -sf $@ $(TARGET) 
> >  
> >  %.o:  %.c 
> > -	$(CC) $(CFLAGS) -fpic -c -o $@ $<
> > +	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
> >  
> >  %.lo:  %.c
> > -	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
> > +	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> >  
> >  install: all
> >  	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
> > 
> > 
> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Is the problem truly limited to libsepol, or is it also an issue with
libsemanage and/or libselinux?

Possibly we could define it as a variable in the Makefile (e.g. PIC ?=
-fpic) with a default of -fpic and allow you to build them with make
PIC=-fPIC on SPARC to avoid any effect on x86.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
