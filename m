From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: More Debian bugs
Date: Mon, 10 Oct 2005 09:09:24 +1000
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
References: <20050923195227.GA21546@vnl.com> <200510100645.01903.russell@coker.com.au> <20051009220838.GZ18797@lkcl.net>
In-Reply-To: <20051009220838.GZ18797@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510100909.35276.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 10 October 2005 08:08, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > 3)  Bugs in udev just get fixed.  This is the one I expect to happen.
>
>  until 2) happens, debian/selinux is vulnerable to the "/dev
>  being moved to /.dev and getting relabelled inappropriately or
>  accidentally having selinux filecontexts removed by fsck and
>  there being nothing to put them back" problem because no-one
>  wants to or will acknowledge whether it's appropriate to add
>  /.dev/* to the file contexts source alongside /dev and /udev
>  *grumble, rhubarb* :)

I've already added the minimal entries for /dev/.static/dev to the 
file_contexts in the recent Debian policy packages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
