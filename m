Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom <tom@lemuria.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <20050328182020.A29887@lemuria.org>
References: <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
	 <1112012129.1514.187.camel@cobra.ivg2.net>
	 <20050328151126.B28232@lemuria.org>
	 <1112017584.1514.239.camel@cobra.ivg2.net>
	 <20050328160935.B28563@lemuria.org>
	 <1112022358.5811.47.camel@cobra.ivg2.net>
	 <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328174753.D29441@lemuria.org>
	 <1112025866.2914.88.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328182020.A29887@lemuria.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 11:39:33 -0500
Message-Id: <1112027973.2914.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 18:20 +0200, Tom wrote:
> I think you are right. I did forget about programs launching other
> programs. On the other hand, doesn't that give us another option within
> SELinux? Can't we make mplayer-launched-by-firefox run in a different
> domain than mplayer-run-by-user? In that domain, it would have access
> to the downloaded files, but not to the remainder of the user data.

Yes, that would make sense to me.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
