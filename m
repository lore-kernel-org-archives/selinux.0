From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: file(1)
Date: Sat, 29 Mar 2008 14:17:47 +1100
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200803272349.32854.russell@coker.com.au> <200803291249.25936.russell@coker.com.au> <6FE441CD9F0C0C479F2D88F959B0158801CD1E91@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801CD1E91@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803291417.50126.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 29 March 2008 12:55, "Joshua Brindle" <jbrindle@tresys.com> wrote:
> > <jbrindle@tresys.com> wrote:
> > > Which is fine, but it just won't be useful for future modules.
> >
> > Would it be possible to try and make things work well with
> > file(1) when designing future module formats?  Little things
> > like zero terminating strings really help.
>
> We want modules to be user editable using standard editors so no binary
> data will be used..

So we are back to editing source?  That's fine by me.

> Unless file will be able to find the first non-comment line I'm not sure
> how it'll work.

It seems to work fine for many other text files.  Also there is nothing 
preventing the creator of a text file format from specifying that the first 
line must contain some specific text indicating the format.  It probably 
would be good if the compiler (loader, linker, semanage, whatever you call 
it) could recognise something that might be suitable input.  If it could give 
a specific error that it's operating on something it considers not to be a 
suitable source file it would help cover some common error cases.

$ file src/*
src/Makefile:      ASCII make commands text
src/dso.h:         ASCII C program text
src/mcstrans.c:    ASCII C program text
src/mcstrans.init: Bourne-Again shell script text executable
src/mcstransd.c:   ASCII C program text

The above is the file(1) output for some common file types.  It seems to work 
quite well for them.

Below are some quick magic entries I hacked up for SE Linux policy source.  
I'm not sure at this stage whether I should submit them for inclusion.  But 
they do demonstrate what can be done with recognising text files.

0       string  policy_module(  SE Linux policy module source
1       string  policy_module(  SE Linux policy module source
2       string  policy_module(  SE Linux policy module source

0       string ##\ <summary>    SE Linux policy interface source

0       search  gen_context(    SE Linux policy file contexts

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
