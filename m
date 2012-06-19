Message-ID: <1340108529.18291.19.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH external/sepolicy] Add iptables script to policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        method@manicmethod.com
Date: Tue, 19 Jun 2012 08:22:09 -0400
In-Reply-To: <1523270.GXfVyoc8BM@sifl>
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
	 <1523270.GXfVyoc8BM@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-18 at 11:25 -0400, Paul Moore wrote:
> On Saturday, June 16, 2012 02:56:34 PM Joshua Brindle wrote:
> > diff --git a/iptables-selinux.sh b/iptables-selinux.sh
> > new file mode 100755
> > index 0000000..e9ac7d1
> > --- /dev/null
> > +++ b/iptables-selinux.sh
> > @@ -0,0 +1,18 @@
> > +#!/system/bin/sh
> > +
> > +IPTABLES="/system/bin/iptables"
> > +
> > +#$IPTABLES -t mangle -A INPUT -i wlan0 -j SECMARK --selctx ...
> 
> Perhaps we should use the security table instead of the mangle table?

Yes, assuming that it is supported by the Android iptables.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
