From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: More Debian bugs
Date: Mon, 10 Oct 2005 06:44:50 +1000
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
References: <20050923195227.GA21546@vnl.com> <200510092019.41106.russell@coker.com.au> <20051009145000.GU18797@lkcl.net>
In-Reply-To: <20051009145000.GU18797@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510100645.01903.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 10 October 2005 00:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > One thing to note is that udev now seems a standard part of sid.  Udev on
> > it's own seems a bit broken in Debian (for example not mounting
> > /dev/pts), and in conjunction with SE Linux there's even more fun.  I
> > don't expect udev and SE Linux to work well together on Debian for some
> > weeks or maybe months.
>
>  ah.
>
>  there are two ways this needs to be fixed.
>
>  1) initrd removed from debian
>
>  2) udev moved into initrd like you have with redhat.

3)  Bugs in udev just get fixed.  This is the one I expect to happen.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
