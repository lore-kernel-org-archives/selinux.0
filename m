Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom <tom@lemuria.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <20050328174753.D29441@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
	 <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
	 <1112012129.1514.187.camel@cobra.ivg2.net>
	 <20050328151126.B28232@lemuria.org>
	 <1112017584.1514.239.camel@cobra.ivg2.net>
	 <20050328160935.B28563@lemuria.org>
	 <1112022358.5811.47.camel@cobra.ivg2.net>
	 <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328174753.D29441@lemuria.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 11:04:26 -0500
Message-Id: <1112025866.2914.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 17:47 +0200, Tom wrote:
> Not so sure about the pointlessness here. The point is that it makes it
> more difficult to leverage exploits. Maybe I can break into Firefox,
> but with that in place I can't jump from there to mplayer by forcing it
> to play something I know will break it.

I'm not sure I understand your intent.  There are two scenarios:
1) mplayer directly launched by firefox.  As the attacker already has
control of the firefox process, the only possible benefit of
compromising a mplayer process launched by firefox is if it has further
permissions needed to achieve his end goal.  And how you prevent such
abuse of a directly launched mplayer is unclear, e.g. do you intend
firefox to engage in an IPC interaction with a process in the desktop
session to ask for the downloaded file to be relabeled prior to
launching mplayer on it?
2) mplayer launched by something other than firefox, e.g. user shell,
nautilus, after prior download of content via firefox.  At this point,
the user has explicitly selected the downloaded file, thus expressing
his intent (modulo any subversion of the user process itself, which is a
separate issue), and can hopefully be trusted not to open files that he
didn't download explicitly (if not, then how can he be trusted to make
decisions about relabeling)?  Hence, in this scenario, the relabeling
doesn't express the user intent any better than the selection by the
user of the downloaded file.  Naturally, what you really want there is a
trusted path mechanism.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
