Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA24783
	for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2003 12:35:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h21HZAI29159
	for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2003 17:35:10 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
        by jazzband.ncsc.mil  with ESMTP id h21HZ9f29155 for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2003 17:35:09 GMT
Date: Sat, 1 Mar 2003 12:34:58 -0500
From: forrest whitcher <fw@fwsystems.com>
To: <selinux@tycho.nsa.gov>
Cc: "Sherman Boyd" <ShermanB@clh.com>
Subject: Re: SELinux and ReiserFS
Message-Id: <20030301123458.5ff03d00.fw@fwsystems.com>
In-Reply-To: <200303011015.35871.russell@coker.com.au>
References: <D17BA970DE186447AD8A5A2A117C2C1503E00E@bulbasaur.internal.clh.com>
	<200303011015.35871.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Generally SElinux PSID's should work with any filestore which retains
'standard' inode semantics.

Presently, as russell indicates ext[23] and reiserfs are coded into the
policy and scripts. I have done test installations using JFS and found
that PSID's seem to work fine, JFS developers assert that there are no
plans to change the inode semantics.


See a thread on this email list dated Dec 2001,
--quoting Stephen Smalley
SS> if [a filesystem] doesn't have unique and persistent inode numbers
SS> for files, then SELinux will have problems with it.

I checked with Hans Reiser on his statement:

HR> until we
HR> someday write a repacker that will optimize key assignments for
HR> better layout),

Suggesting that if such a change were implemented, keeping backward
compatibility as an option would be important, he indicated they would
do so.


BTW, as JFS is now incorporated into the mainline kernel it'd be
great to see that incorporated into the SEL patches (maybe it already
is, I'm still working with the 2.4.19 SEL kernel).

forrest



On Sat, 1 Mar 2003 10:15:35 +0100 
Russell Coker <russell@coker.com.au> did inscribe thusly:

> On Fri, 28 Feb 2003 23:40, Sherman Boyd wrote:
> > > Is SELinux compatable with ReiserFS?
> 
> It is working fine for me on many machines.  The default SE Linux
> policy has the following file system support for persistant labelling:
> fs_use_psid ext2;
> fs_use_psid ext3;
> fs_use_psid reiserfs;
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
> packages http://www.coker.com.au/bonnie++/  Bonnie++ hard drive
> benchmark http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
