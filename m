Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FHG0Ha018571
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 13:16:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FHFxH5026741
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:15:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6FHFwRX026738 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:15:58 GMT
Subject: Re: enforcement and initrds
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058214662.19392.31.camel@columbia>
References: <1058151822.9620.25.camel@columbia>
	 <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil>
	 <1058214662.19392.31.camel@columbia>
Content-Type: text/plain
Message-Id: <1058289355.13738.705.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 13:15:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-14 at 16:31, Colin Walters wrote:
> That's a good point, but then again we could just make DEVELOP=n instead
> mean that once enforcing mode was switched on, it couldn't be switched
> off.

I'd prefer to be able to compile out the permissive mode support
entirely for production kernels.

> I tried this, but there appears to be a bootstrapping problem; the
> policy says that romfs uses genfs; but the policy has to be loaded from
> the initrd, which isn't labeled until we know what the policy is.

romfs or ramfs?  It isn't an issue whether it is labeled before the
policy is loaded; all permission checks are allowed until the policy is
loaded and the security server is initialized.  At some point, we'd like
to generate an initial bootstrapping policy that is built into the
security server, but there isn't any point in doing that until things
stabilize a bit more, and that initial policy could be dependent on your
particular kernel configuration and your initrd setup.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
