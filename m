Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OCabFX026031
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 07:36:37 -0500 (EST)
Subject: Re: [patch] enhanced MLS support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <20050124034057.19326.qmail@web50204.mail.yahoo.com>
References: <20050124034057.19326.qmail@web50204.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1106569823.19246.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 07:30:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-23 at 22:40, Casey Schaufler wrote:
> I would think that you couldn't call the
> system flexible in any meaningful way if
> it couldn't accomodate an integrity policy.
> The Trix experience is that Biba integrity
> is overkill. A binary integrity policy
> distinguishing between TCB and User data and
> processes is useful, but going beyond that
> adds more complexity than anyone (sane) is
> going to want to deal with.

TE is preferable for integrity protection.  IMHO, there is no need to
introduce a Biba model to SELinux.

> Erg. Or handling caveats? Actually, the
> above comment regarding the flexibility of
> the system applies. If the system can't be
> demonstrated to handle these, it probably
> isn't very agile.

Should be expressible using the category bitmaps.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
