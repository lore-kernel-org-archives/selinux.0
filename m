Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VFe7gA005856
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 11:40:07 -0400 (EDT)
Received: from web31609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4VFXppZ025116
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 15:33:51 GMT
Message-ID: <20050531153358.61421.qmail@web31609.mail.mud.yahoo.com>
Date: Tue, 31 May 2005 08:33:58 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: gentoo/hardened
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1117512454.1742.101.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Chris PeBenito <pebenito@gentoo.org> wrote:

> The complexity of policy is created by the fact
> that Linux is a general purpose OS.

Err, no. The complexity of policy is an artifact
of the ad hoc way policy is being applied to the
system. By approaching the policy one program at
a time, and putting all of ten minutes thought
into the policy for each program, you are destined
to end up with a higgeldee piggeldee hodgepodge
that grows beyond the bounds of control.

> The current policy is hard to understand,
> regardless.

And undocumented, and undesigned.

> This is something that we are working on
> improving at Tresys with our reference
> policy work.

Good. I would love to see a design for the policy.
I mean, to date it has been like you're walking
along a fence and every time you come to a post
you staple whatever happens to be lying on the
ground nearby onto it. What is the point?



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
