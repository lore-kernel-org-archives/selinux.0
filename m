From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: dynamic context transitions
Date: Fri, 26 Nov 2004 07:12:07 +1100
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>,
   "'Chad Hanson'" <chanson@TrustedCS.com>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com> <1099418564.31739.208.camel@moss-spartans.epoch.ncsc.mil> <1099431220.23756.129.camel@pham.columbia.tresys.com>
In-Reply-To: <1099431220.23756.129.camel@pham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411260712.14139.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 November 2004 08:33, Karl MacMillan <kmacmillan@tresys.com> 
wrote:
> > The amount of trust placed in samba is the same, but the dynamic context
> > transition allows the kernel to handle the mediation directly and
> > atomically with respect to the file access.  Otherwise, you have to
> > duplicate the checking in samba (which will still ultimately get the
> > decisions from the kernel via selinuxfs) and deal in some way with race
> > conditions.  Keep in mind that we are talking about user-writable
> > directories that are being exported by samba.
>
> This is using the dynamic context transitions as a practical
> _discretionary_ security measure then. That may have some benefit. I'm
> still concerned that the benefits don't outweigh the costs. We are,
> after all, talking about breaking some fundamental assumptions of the
> SELinux mechanism in a way that may give many people a false sense of
> security.

Currently Samba is considered to be a trusted object manager with regard to 
file system access.  Through all the discussions of SE Linux and Samba there 
has never been any consideration given to running parts of Samba with less 
priviledge with the aim of containing a Samba exploit.  The design and use of 
Samba just doesn't permit such things.

What we do need is for Samba to be able to atomically perform all necessary 
checks for creat(), open(), unlink(), stat(), etc.  There is no way to do 
this other than having a process perform such system calls while running in a 
domain that has access restricted to only the types that the user may access.  
This means either the Samba hacks I previously discussed or the ability to 
transition between domains in a similar manner to setuid().

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
