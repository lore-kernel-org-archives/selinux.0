Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0VHdN53009282
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 12:39:24 -0500 (EST)
Subject: Re: Strange Denial
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107192394.27510.0.camel@cobra.ivg2.net>
References: <1107192394.27510.0.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107192775.24654.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 31 Jan 2005 12:32:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-31 at 12:26, Ivan Gyurdiev wrote:
> What's this?
> 
> audit(1107188820.754:0): avc:  denied  { } for  pid=6672 comm=mplayer
> path=/dev/zero dev=tmpfs ino=2055 scontext=user_u:user_r:user_mplayer_t
> tcontext=system_u:object_r:zero_device_t tclass=chr_file

Hmmm...possibly an execmod denial, e.g. mplayer is trying to make
executable a previously modified mapping of /dev/zero.  execmod
permission is only defined for the file class presently, didn't expect
to have to deal with doing this on devices...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
