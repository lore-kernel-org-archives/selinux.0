Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4GK9XZ024209
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 11:20:11 -0500 (EST)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4GIlCH029239
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 16:18:47 GMT
Received: by rproxy.gmail.com with SMTP id i8so268628rne
        for <selinux@tycho.nsa.gov>; Thu, 04 Nov 2004 08:20:09 -0800 (PST)
Message-ID: <46ce702f041104082042e4c02a@mail.gmail.com>
Date: Thu, 4 Nov 2004 10:20:09 -0600
From: Serge Hallyn <serge.hallyn@gmail.com>
Reply-To: Serge Hallyn <serge.hallyn@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: learning about policies/transitions
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ah, running setfilecon worked.

I don't understand why, though.  The security.selinux xattr (as given by 
getxattr(2)) looked the same before and after.  What else is being changed
by setfilecon?

Thanks!
-serge

> Your policy looks sufficient for that purpose, although there are some
> oddities in it (e.g. you shouldn't be authorizing system_r for object
> types, you should be using object_r in file contexts, a file descriptor
> is not labeled with a file type).  A possible explanation would be an
> inconsistency between the on-disk xattr and the incore inode SID, e.g.
> type wasn't defined at the time that the inode was attached to a
> dentry.  Try setfilecon system_u:object_r:login_et /bin/login and then
> re-trying.  setfiles and chcon tend to not bother setting the context if
> it already appears to be correct, but they only can see the on-disk
> xattr via the xattr API, not the incore inode context.
> 
> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
