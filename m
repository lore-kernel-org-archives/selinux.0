Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFGCaIi024070
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 11:12:36 -0500 (EST)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFGB9vq029739
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 16:11:09 GMT
Received: by rproxy.gmail.com with SMTP id i8so709334rne
        for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 08:12:38 -0800 (PST)
Message-ID: <46ce702f041115081242f9f8e7@mail.gmail.com>
Date: Mon, 15 Nov 2004 10:12:38 -0600
From: Serge Hallyn <serge.hallyn@gmail.com>
Reply-To: Serge Hallyn <serge.hallyn@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: learning about policies/transitions
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
	 <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104182352cbcd1@mail.gmail.com>
	 <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your help, Stephen.  I've *briefly* looked around at the
inird and /bin/init sources, and can't find an initiial policy that
would be loaded before the root filesystem pivot_root.  I expect to
have more time at the end of this week to figure it out, though.

thanks,
-serge

On Fri, 05 Nov 2004 07:26:15 -0500, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Thu, 2004-11-04 at 21:23, Serge Hallyn wrote:
> > Addendum:  running setfilecon works once.  After each reboot, I must again run
> > setfilecon.before /bin/login will cause the transition to login_d.
> > Again, running
> > /bin/ls -Z /bin/login shows no difference before and after the
> > setifilecon - it is always
> > of type login_et.
> 
> Two scenarios:
> 1) At boot time (e.g. usual policy load by /sbin/init), you are loading
> a policy that does not define login_et, /bin/login inode is brought
> incore and mapped to the unlabeled SID, and you then load a policy that
> does define login_et, but this doesn't automatically fix the incore
> inode SID.
> 2) At boot time, you are loading a policy that does define login_et,
> /bin/login inode is brought incore and mapped to the correct SID, you
> then load a policy that does not define login_et (e.g. Fedora policy),
> invalidating that SID, and you later reload a policy that does define
> login_et, but this doesn't automatically fix the incore inode SID.
> 
> While it would be possible to walk the inode lists upon a policy reload
> and retry mapping of the on-disk xattr for any inode with the unlabeled
> SID, I'm not sure it is worthwhile to do so.
> 
> --
> 
> 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
