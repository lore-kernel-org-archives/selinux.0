Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OGcwFX027417
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 11:38:58 -0500 (EST)
Received: from web50204.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j0OGcx8I004152
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 16:39:00 GMT
Message-ID: <20050124163859.71571.qmail@web50204.mail.yahoo.com>
Date: Mon, 24 Jan 2005 08:38:59 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [patch] enhanced MLS support
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <1106569823.19246.11.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> TE is preferable for integrity protection.

Sorry, my acronym matcher failed on "TE".

> IMHO, there is no need to
> introduce a Biba model to SELinux.

It is probably more trouble than it's worth.

> > Erg. Or handling caveats? Actually, the
> > above comment regarding the flexibility of
> > the system applies. If the system can't be
> > demonstrated to handle these, it probably
> > isn't very agile.
> 
> Should be expressible using the category bitmaps.

You could certainly store handling caveats in
the category bitmaps, but expressing NOFORN
in categories has been tried and does not work.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
