MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: file(1)
Date: Sat, 29 Mar 2008 12:33:45 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801CD1E96@exchange.columbia.tresys.com>
In-Reply-To: <200803291417.50126.russell@coker.com.au>
References: <200803272349.32854.russell@coker.com.au> <200803291249.25936.russell@coker.com.au> <6FE441CD9F0C0C479F2D88F959B0158801CD1E91@exchange.columbia.tresys.com> <200803291417.50126.russell@coker.com.au>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <russell@coker.com.au>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au] 
> Sent: Friday, March 28, 2008 11:18 PM
> To: Joshua Brindle
> Cc: Stephen Smalley; SE-Linux
> Subject: Re: file(1)
> 
> On Saturday 29 March 2008 12:55, "Joshua Brindle" 
> <jbrindle@tresys.com> wrote:
> > > <jbrindle@tresys.com> wrote:
> > > > Which is fine, but it just won't be useful for future modules.
> > >
> > > Would it be possible to try and make things work well with
> > > file(1) when designing future module formats?  Little things like 
> > > zero terminating strings really help.
> >
> > We want modules to be user editable using standard editors so no 
> > binary data will be used..
> 
> So we are back to editing source?  That's fine by me.
> 

Yes, but with the infrastructure to link in modules, etc. Source just
makes it much easier to manage the modules from the user perspective.

> > Unless file will be able to find the first non-comment line I'm not 
> > sure how it'll work.
> 
> It seems to work fine for many other text files.  Also there 
> is nothing preventing the creator of a text file format from 
> specifying that the first line must contain some specific 
> text indicating the format.  It probably would be good if the 
> compiler (loader, linker, semanage, whatever you call
> it) could recognise something that might be suitable input.  
> If it could give a specific error that it's operating on 
> something it considers not to be a suitable source file it 
> would help cover some common error cases.
> 
> $ file src/*
> src/Makefile:      ASCII make commands text
> src/dso.h:         ASCII C program text
> src/mcstrans.c:    ASCII C program text
> src/mcstrans.init: Bourne-Again shell script text executable
> src/mcstransd.c:   ASCII C program text
> 
> The above is the file(1) output for some common file types.  
> It seems to work quite well for them.
> 
> Below are some quick magic entries I hacked up for SE Linux 
> policy source.  
> I'm not sure at this stage whether I should submit them for 
> inclusion.  But they do demonstrate what can be done with 
> recognising text files.
> 
> 0       string  policy_module(  SE Linux policy module source
> 1       string  policy_module(  SE Linux policy module source
> 2       string  policy_module(  SE Linux policy module source
> 
> 0       string ##\ <summary>    SE Linux policy interface source
> 
> 0       search  gen_context(    SE Linux policy file contexts
> 

One thing, there won't be separate files for interfaces, modules, and
file contexts anymore (at least from the toolchain perspective,
refpolicy might keep them separate internally)

So modules will be self contained source files with everything
necessary.

I wouldn't submit anything yet, a lot of the refpolicy things are slated
to become parts of the proper language and the way modules are going to
look haven't been completely hammered down.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
