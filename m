Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAK3mCRb021764
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 22:48:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAK3lfp5028353
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 03:47:41 GMT
Received: from smtp01.net-yan.com (smtp01.net-yan.com [210.0.255.210])
	by jazzswing.ncsc.mil  with ESMTP id hAK3lZt0028345
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 03:47:40 GMT
From: "samwun" <samwun@hgcbroadband.com>
To: <russell@coker.com.au>, "'SELinux ML'" <selinux@tycho.nsa.gov>
Subject: RE: where to download LSM-patched 2.4
Date: Thu, 20 Nov 2003 11:49:30 +0800
Message-ID: <029a01c3af19$4d549d60$5801a8c0@samgpj2wzuimme>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200311200040.43270.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found that command "make install" failed in selinux 2.6 kernel source:

# make install
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /usr/local/linux-2.6/arch/i386/boot/install.sh 2.6.0-test6-selinux1
arch/i386/boot/bzImage System.map ""
No module advansys found for kernel 2.6.0-test6-selinux1
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2
#

After finished make install, I also found the new kernel 2
.6.0-test6-selinux1 is populated in the /boot directory. I changed
/etc/lilo.conf to as follow:

prompt
timeout=50
default=linux
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
message=/boot/message
linear
 
image=/boot/vmlinuz-2.6.0-test6-selinux1
        label=selinux2.6
        initrd=/boot/initrd-2.4.20-8.img
        read-only
        append="root=/dev/hda7"
Note, hda7 is my / partition.

Then I did a lilo -v, and reboot.
But new kernel caused panic.

What should I do to fix this problem? 


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Russell Coker
Sent: Wednesday, November 19, 2003 9:41 PM
To: samwun; 'SELinux ML'
Subject: Re: where to download LSM-patched 2.4

On Wed, 19 Nov 2003 23:23, "samwun" <samwun@hgcbroadband.com> wrote:
> Before I used LSM 2.4 selinux source, I encountered problem when I was
> trying to install SELinux.
> The problem is the SELinux kernel is able to loaded up after a reboot,
> but
> whenever issuing a command
> "ls --context" or whatever other SELinx related command options, it
> always
> said that the command ooptions needs SELinux kernel to support,  but I
> have

The most likely explanation for this is that the version of the SE Linux

kernel code and the version of the user-space code does not match.
There are 
two major versions of SE Linux in use, the old SE Linux has 52 system
calls 
multiplexed over the LSM system call.  The new SE Linux uses XATTR's and
file 
read/write operations on selinuxfs and /proc/pid/attr/*.  As the
operation of 
these versions of SE Linux is very different there are no programs that
can 
support both (it would be possible to write a program that supports
both, but 
no-one has done so).

Does /proc/filesystems have an entry for "selinuxfs"?  If so you are
running 
the kernel for the new SE Linux, if not then you are running the old SE 
Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
