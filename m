Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FIWPL9009943
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 13:32:25 -0500 (EST)
Subject: Re: Setting loginuid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
In-Reply-To: <20050215170139.79356.qmail@web50206.mail.yahoo.com>
References: <20050215170139.79356.qmail@web50206.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1108491857.17854.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 13:24:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 12:01, Casey Schaufler wrote:
> You're correct. It would be possible to do su
> correctly using the PAM scheme. It would also be
> simple^H^H^H^H^H^H possible to configure the system
> incorrectly. There is never a case where you want
> the wrong behavior. It is better to hard code
> correctness that to make correct behavior a
> configuration option.

That seems like an argument against PAM in general, not just for this
purpose.  And somehow I doubt that PAM is going away any time soon...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
