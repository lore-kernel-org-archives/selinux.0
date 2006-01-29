Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0TN3OXf027416
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 18:03:24 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0TN3J0a000253
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 23:03:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Lorenzo =?utf-8?q?Hern=C3=A1ndez_Garc=C3=ADa-Hierro?= <lorenzo@gnu.org>
Subject: Re: labeling of compilers etc
Date: Mon, 30 Jan 2006 10:03:08 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <1138572517.9012.27.camel@estila>
In-Reply-To: <1138572517.9012.27.camel@estila>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601301003.17498.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 30 January 2006 09:08, Lorenzo Hernández García-Hierro 
<lorenzo@gnu.org> wrote:
> It's definitely a good idea to keep daemon-related users away of using
> compilers and debuggers. Current behavior of web application worms is
> related to the usage of 'wget' or other tools to get either a binary or
> a source file.
>
> Access to those resources should be limited as well.

Limiting access to wget would also imply doing the same to lynx, links, ftp, 
ncftp, netcat, and many others.  I hadn't been planning to do that, but it 
makes sense (certainly provides a much greater benefit than ls_exec_t or the 
bin_t vs sbin_t distinction).

> > Also interpreters could be modified to provide similar benefits. 
> > Currently many (most?) shell interpreters try to detect and prevent
> > setuid operation with code roughly equivalent to if(getuid() !=
> > geteuid()) seteuid(getuid). Bash currently has such code (just done a
> > quick test) and other shells had such cost in place last time I tested
> > them.  I believe that this establishes a precedent for shell interpreters
> > to check for and prevent insecure modes of operation.
>
> That's TPE after all. Interpreters shouldn't load files from untrusted
> sources: user home directories (although this would need exceptions),
> world writable directories, etc.

If Alice can write to data that user Bob executes then that's a definite 
instance of files loaded from an untrusted source.  But if Alice writes files 
in her own context then that's usually considered regular use of the system.

Unix systems are more designed for regular users where you need to write to 
your .bashrc etc than for daemon users where writing to such files is at best 
unnecessary and at worst a major security problem.

> I would like to help with this, although the scope is a bit more complex
> than it seems. The operations that can be done by the interpreters
> should be limited, not only the instructions that can be loaded from a
> file. In other words, flawed interpreters can be forced to perform
> potentially harmful operations.

If the interpreter refuses to read instructions from stdin, from a pipe, or 
from a file of a type that can be written then shouldn't it be safe?

Of course there will be a bit of coding involved in checking the "." or 
"source" operator, the .login type files, and every other situation where an 
interpreter may read instructions.

> For example, binary format parsers: archive format related tools: RAR,
> tar, bzip2; binary load related tools: binutils and readelf (the kernel
> itself...), image processing related tools (there has been work on this
> from someone else here, Colin's IMSEP?), etc.

binutils would be devel_exec_t under the scheme I outlined previously.

What do you consider to be the issues relating to tar etc?

> > Also it should be noted that if the perl interpreter is setuid then it'll
> > happily do things as the EUID, this means that we have no good precedent
> > to rely on in this case.  This doesn't stop us, just means that the
> > chance of getting code accepted upstream is dramatically reduced.
>
> I think that getting code accepted by upstream maintainers isn't
> mandatory. Things could get worked out later, and changes shouldn't be
> made available by default (ie. we can either compile it with support for
> the measures or not).

Sure we can do things without support from upstream.  But it's a lot easier if 
we do have such support.  They can often suggest better ways to achieve our 
goals, and if they merge our patches into the main tree then it'll save us a 
lot of maintenance work in the long term.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
