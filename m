Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0O3f8FX024472
	for <selinux@tycho.nsa.gov>; Sun, 23 Jan 2005 22:41:08 -0500 (EST)
Received: from web50204.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j0O3fAQ5017617
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 03:41:10 GMT
Message-ID: <20050124034057.19326.qmail@web50204.mail.yahoo.com>
Date: Sun, 23 Jan 2005 19:40:57 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [patch] enhanced MLS support
To: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0501231333020.18710-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Morris <jmorris@redhat.com> wrote:

> On Mon, 17 Jan 2005, Darrel Goeddel wrote:
> 
> > Replaced the existing MLS logic with a flexible
> system based on the current
> > constraints language.
> 
> Do you plan to add support for integrity labels?

I would think that you couldn't call the
system flexible in any meaningful way if
it couldn't accomodate an integrity policy.
The Trix experience is that Biba integrity
is overkill. A binary integrity policy
distinguishing between TCB and User data and
processes is useful, but going beyond that
adds more complexity than anyone (sane) is
going to want to deal with.

> What about releasibility labels?

Erg. Or handling caveats? Actually, the
above comment regarding the flexibility of
the system applies. If the system can't be
demonstrated to handle these, it probably
isn't very agile.



=====
Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
