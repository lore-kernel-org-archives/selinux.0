Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Femitha Majeed" <m_femitha@hotmail.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux and kernel module compatibility
Date: Mon, 16 Sep 2002 21:27:29 +0200
References: <F3105knsCKH0D8r8e4D000074cc@hotmail.com>
In-Reply-To: <F3105knsCKH0D8r8e4D000074cc@hotmail.com>
MIME-Version: 1.0
Message-Id: <200209162127.29842.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Sep 2002 19:52, Femitha Majeed wrote:
> This is a newbie question.
>
> I have a loadable kernel module that works on linux (RH6.2), when I try to
> compile it in SELinux, it compiles (it looks like that). When I do an
> insmod module.o,I get the error saying that it was compiled for a different
> linux version, while this is an lsm version.
>
> Probably my Makefile is wrong.
>
> Could anyone tell me how to compile in SELinux?

Did you compile the module using the same kernel source tree as used to 
compile SE Linux?

The proceedure should be:
compile kernel with SE support (don't do "make clean" or anything)
compile module.

Anything else can't be expected to work.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
