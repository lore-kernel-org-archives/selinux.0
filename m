Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NKLFHa027695
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 16:21:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6NKK9FB017414
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 20:20:09 GMT
Received: from chaos.tigeraudits.com (host158.mobiltek.pl [212.160.95.158] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h6NKK8GD017404
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 20:20:08 GMT
Date: Wed, 23 Jul 2003 22:26:42 +0200 (CEST)
From: Lukasz Luzar <lluzar@tigeraudits.com>
To: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
In-Reply-To: <5.1.1.6.2.20030723080629.0a198680@Shire>
Message-ID: <Pine.LNX.4.44.0307232139200.9324-100000@chaos.tigeraudits.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

> Is this true of the GNU C compiler suite as well?  And if so, would it not 
> be possible to remove it from the compiler?  How does it work?  Does it 
> look at the code, or is anything called login.c susceptible?  Why has this 
> not been removed in the open-source code?  How can I check to see if this 
> backdoor exists?

I suppose there's a "simple" way to avoid backdoors in gcc-like compilers ;-)

Assuming the BIOS is not backdoored, the simplified steps are:

1). Perform a security audit of a simplest public-available C compiler [1]
    written in ANSI C
2). Convert the C compiler's _source_code_ (written in ANSI C) 
    into x86 assembler _source_code_ by yourself, replacing all 
    OS-depended interrupts etc.
3). Write a simplest (low-efficient, but trusted) assembler compiler 
    (~a x86 assembler source code converter into x86 machine-code ;-) 
    preferably targeted on a less popular processor (even a 8051...)
4). Compile the audited C compiler, converted into x86 assembler source code, 
    by using the above tool, so the final trusted compiler to be OS-independent
    and floopy-bootable and has a simple built-in shell etc. ;-)
5). Do some tricks to copy the trusted C compiler on a floppy and make it 
    bootable
6). Launch the trusted & independent compiler from the bootable floppy
7). Compile the compiler [1], a shell, libs and all tools needed to compile  
    Linux kernel by using your own trusted compiler booted from the floppy
8). Compile a simplest Linux kernel using these tools
9). Put the kernel on a prepared bootable partition
10). Copy the compiled tools on the partition
11). Boot the Linux from this partition
12). Recompile all required packages needed for your distribution 
     according to LFS documentation.

Cheers,

-- 
Lukasz Luzar
http://Developers.of.PL/
Crede quod habes, et habes

[[ http://galeria.luzar.pl/ ]]

/* paran01a 1s a v1rtu3 */






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
