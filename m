Subject: Re: Threaded applications and "execmem" privilege
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1132672653.28079.10.camel@wintermute.xmldesign.de>
References: <1132504528.12651.21.camel@wintermute.xmldesign.de>
	 <1132672653.28079.10.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 09:31:17 -0500
Message-Id: <1133188277.348.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-22 at 16:17 +0100, Erich Schubert wrote:
> Hello,
> I've built debian stable libc6 package which do not use PROT_EXEC for
> the stack, meaning they do not require the execmem privilege. executable
> stacks are a bad idea anyway, aren't they?
> This is not heavily tested... I've just installed it on one machine, and
> can now run "dig" in enforcing mode. ;-)
> I'm trying to upload them to alioth right now.
> 
> Here's the patch I used:
> --- nptl/allocatestack.c.orig   2005-11-21 01:18:07.000000000 +0100
> +++ nptl/allocatestack.c        2005-11-21 01:18:17.000000000 +0100
> @@ -392,7 +392,7 @@
>             size += pagesize_m1 + 1;
>  #endif
> 
> -         mem = mmap (NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +         mem = mmap (NULL, size, PROT_READ | PROT_WRITE,
>                       MAP_PRIVATE | MAP_ANONYMOUS | ARCH_MAP_FLAGS, -1,
> 0);
> 
>           if (__builtin_expect (mem == MAP_FAILED, 0))
> 
> >From a quick scan of the "Debian unstable" source I'd expect a similar
> patch is needed there, too... but maybe one of the debian-patches
> already does a similar change.

Hmm...take a look at:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/nptl/allocatestack.c.diff?r1=1.37&r2=1.38&cvsroot=glibc

That alters the mmap call to only apply PROT_EXEC when the binary is
marked as requiring an executable stack or the binary lacks marking (I
assume that execstack -q `which host` shows - /usr/bin/host). That
change is dated Sep 24 2003, and further changes have occurred since
that time.  How old is the Debian libc?

On Fedora, I do not encounter such execmem denials on host, dig, etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
