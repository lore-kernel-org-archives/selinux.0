Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKH5ECE001762
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 12:05:14 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAKH3XEc021185
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 17:03:34 GMT
Message-ID: <4561E044.6050006@mentalrootkit.com>
Date: Mon, 20 Nov 2006 12:05:08 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Manoj Srivastava <manoj.srivastava@stdc.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Compiling libsepol with -fPIC instead of -fpic
References: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>
In-Reply-To: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava wrote:
> Hi,
> 
>         I've had reports of packages filing to compile on SPARC
>  hardware when linked with  libsepol1 which was compiled with
>  -fpic. We seem to be hitting the global offset table size limit;
> ,----[ GCC manual ]
> | `-fpic'
> |      Generate position-independent code (PIC) suitable for use in a
> |      shared library, if supported for the target machine.  Such code
> |      accesses all constant addresses through a global offset table
> |      (GOT).  The dynamic loader resolves the GOT entries when the
> |      program starts (the dynamic loader is not part of GCC; it is part
> |      of the operating system).  If the GOT size for the linked
> |      executable exceeds a machine-specific maximum size, you get an
> |      error message from the linker indicating that `-fpic' does not
> |      work; in that case, recompile with `-fPIC' instead.  (These
> |      maximums are 8k on the SPARC and 32k on the m68k and RS/6000.  The
> |      386 has no such limit.)
> `----
> 
>         Simply recompiling with -fPIC corrects the problem.
> 
>         manoj
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- orig/src/Makefile
> +++ mod/src/Makefile
> @@ -24,10 +24,10 @@
>  	ln -sf $@ $(TARGET) 
>  
>  %.o:  %.c 
> -	$(CC) $(CFLAGS) -fpic -c -o $@ $<
> +	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
>  
>  %.lo:  %.c
> -	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
> +	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>  
>  install: all
>  	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
> 
> 
Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
