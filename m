Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OH45FX027640
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 12:04:05 -0500 (EST)
Subject: Re: [patch] enhanced MLS support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <20050124163859.71571.qmail@web50204.mail.yahoo.com>
References: <20050124163859.71571.qmail@web50204.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1106585869.19246.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 11:57:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 11:38, Casey Schaufler wrote:
> Sorry, my acronym matcher failed on "TE".

Type Enforcement.  It was originally discussed as an alternative to Biba
in "A Practical Alternative to Hierarchical Integrity Policies", in the
Proceedings of the 8th National Computer Security Conference, 1985,
pages 18-27.

> You could certainly store handling caveats in
> the category bitmaps, but expressing NOFORN
> in categories has been tried and does not work.

I'll leave it to Darrel to respond to this point.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
