From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, openafs-info@openafs.org
Subject: Re: [OpenAFS] selinux afs domain v 0.2
Date: Mon, 17 Mar 2003 23:05:26 +0100
Cc: tino.schwarze@informatik.tu-chemnitz.de, <SELinux@tycho.nsa.gov>
References: <20030120200718.57f30b5f.fw@fwsystems.com> <20030121094847.A6403@informatik.tu-chemnitz.de> <20030317154153.4155f8e5.fw@fwsystems.com>
In-Reply-To: <20030317154153.4155f8e5.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303172305.26687.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Mar 2003 21:41, forrest whitcher wrote:
> I've run across a problem on an SEL-based filserver that I've not seen or
> been able to replicate elsewhere.
>
> dmesg gives:
> Mar 16 23:25:24 thing kernel: attempt to access beyond end of device
> Mar 16 23:25:24 thing kernel: 09:01: rw=0, want=9630852, limit=9630848
> Mar 16 23:25:24 thing kernel: attempt to access beyond end of device
> Mar 16 23:25:24 thing kernel: 09:01: rw=0, want=9630856, limit=9630848

Those errors usually indicate file system corruption.  They were reported 
regularly during the early days of ReiserFS development, and they are still 
reported occasionally.

> I can't think what would be particular to this instance .. SELinux does
> maintain the 'PSID' cache noted below and that is going to have the
> following affects:

SE Linux however uses higher level apis to access that (IE it doesn't do any 
of the disk access itself, it merely calls file system functions).  This is 
why it can operate on Ext2, Ext3, ReiserFS, and JFS without any problems.

Naturally a kernel bug in any module can (in theory at least) corrupt kernel 
memory and cause a symptom in any other module.  However I doubt that this is 
the case here.

I suggest really seriously examining the file system and what it's doing, try 
running fsck even if it doesn't seem necessary.  Also try
"tar cf - . > /dev/null" on the file system to see if that can cause the error 
to re-appear.

I believe that AFS servers run a regular file system such as Ext2 or Ext3 to 
store the data.  I suggest running the fsck program for that file system to 
look for errors.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
