Subject: Re: Quick question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ioannis Aslanidis <iaslanidis@flumotion.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <483C5D33.3000800@flumotion.com>
References: <483C46FA.9030904@flumotion.com>
	 <1211911009.19360.51.camel@moss-spartans.epoch.ncsc.mil>
	 <483C4E13.2030903@flumotion.com>
	 <1211912805.19360.65.camel@moss-spartans.epoch.ncsc.mil>
	 <483C5D33.3000800@flumotion.com>
Content-Type: text/plain
Date: Tue, 27 May 2008 15:47:36 -0400
Message-Id: <1211917656.19360.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-27 at 21:12 +0200, Ioannis Aslanidis wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Understood. That changes a little the policy, but I could still create
> one mount point per user inside his own home.

I don't think so; you are limited to per-filesystem/superblock
granularity at present, not per-mount.  If you make multiple mounts from
the same filesystem on the server, they'll be labeled identically.
You'd need genuine labeled NFS support, which is yet to come (in
progress).

>  That still leaves me with
> the possibility of listing /home, which could be achieved by removing
> the read flag on the directory on normal permission mode and so on, so I
> guess SELinux wouldn't be needed in that case.
> 
> Thanks for your help. If you have any comments or proposals I am open to
> them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
