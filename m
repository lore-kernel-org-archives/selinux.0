Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EqrrT012998
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:52:54 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72EqqKV013814
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:52:52 GMT
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20040802145724.GG4194@lkcl.net>
References: <20040801172751.GD20103@lkcl.net>
	 <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20040802145724.GG4194@lkcl.net>
Content-Type: text/plain
Message-Id: <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 10:52:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 10:57, Luke Kenneth Casson Leighton wrote:
>  ... one thing though: running udev, it can only generate about 4
>  device inodes per second when having to do
>  /etc/dev.d/defaults/selinux.dev (which calls restorecon $DEVICENAME).
> 
>  that's _awfully_ slow.
> 
>  especially when creating 64 /dev/ttyxx nodes, 64 /dev/ttySxx nodes,
>  and then a few /dev/ramX nodes too.
> 
>  it delays boot-time by over 30 seconds, basically.
> 
>  what, if anything, could be done about this?
> 
>  run a restorecon asynchronous service?
> 
>  yes, i realise that sounds a bit mad, but if people are going to throw
>  150 device inodes up at boot-time, it's got to be quick.

What's the objection to patching udev to directly invoke matchpathcon(3)
and setfscreatecon(3) prior to creating each device node?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
