Date: Mon, 28 Mar 2005 18:20:20 +0200
From: Tom <tom@lemuria.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050328182020.A29887@lemuria.org>
References: <1111987652.1514.97.camel@cobra.ivg2.net> <20050328132653.F27857@lemuria.org> <1112012129.1514.187.camel@cobra.ivg2.net> <20050328151126.B28232@lemuria.org> <1112017584.1514.239.camel@cobra.ivg2.net> <20050328160935.B28563@lemuria.org> <1112022358.5811.47.camel@cobra.ivg2.net> <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil> <20050328174753.D29441@lemuria.org> <1112025866.2914.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112025866.2914.88.camel@moss-spartans.epoch.ncsc.mil>; from sds@tycho.nsa.gov on Mon, Mar 28, 2005 at 11:04:26AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 11:04:26AM -0500, Stephen Smalley wrote:
> I'm not sure I understand your intent.  There are two scenarios:
> 1) mplayer directly launched by firefox.  As the attacker already has
[...]
> 2) mplayer launched by something other than firefox, e.g. user shell,
[...]
> user of the downloaded file.  Naturally, what you really want there is a
> trusted path mechanism.

Hmm.
I think you are right. I did forget about programs launching other
programs. On the other hand, doesn't that give us another option within
SELinux? Can't we make mplayer-launched-by-firefox run in a different
domain than mplayer-run-by-user? In that domain, it would have access
to the downloaded files, but not to the remainder of the user data.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
