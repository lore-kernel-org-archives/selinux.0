Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ACYfrT001916
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 08:34:41 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ACY4ET019275
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 12:34:05 GMT
Date: Tue, 10 Aug 2004 13:45:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: different selinux file-context root
Message-ID: <20040810124547.GC4647@lkcl.net>
References: <20040809195721.GP3868@lkcl.net> <1092081142.29199.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092081142.29199.194.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 09, 2004 at 03:52:23PM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-09 at 15:57, Luke Kenneth Casson Leighton wrote:
> > i'm thinking of doing installs of selinux systems and online
> > backups/restores from an initial ramdisk.
> > 
> > e.g. modifying rsync to cope with selinux file contexts.
> > 
> > e.g. there are several backup programs that create bootable CDs, that
> > then redo the entire system.
> > 
> > what would make sense is for rsync, star etc. to have a context-"chroot"
> > under which the selinux file contexts get recreated relative to that
> > directory as the root filesystem.
> > 
> > then i don't have to mess about ensuring that the entire filesystem
> > is correctly there and then doing something like this:
> > 
> > 	chroot /mnt-point make -C /etc/selinux/src relabel
> 
> setfiles has a -r rootpath option (contributed by the Gentoo folks) that
> causes it to strip the specified rootpath prior to matching against
> file_contexts.  

 great!

> Or, if using matchpathcon() directly, you can always
> have the caller strip the rootpath itself prior to invoking
> matchpathcon().

 yukk :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
