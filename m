Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBL0CKIi018759
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 19:12:20 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBL0AZkB016994
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 00:10:35 GMT
Date: Tue, 21 Dec 2004 00:23:00 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: David Caplan <dac@tresys.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
Subject: Re: paranoid FC3 setup: banning all login access (!)
Message-ID: <20041221002300.GA7333@lkcl.net>
References: <20041220160039.GE24188@lkcl.net> <41C727B1.4080709@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41C727B1.4080709@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 20, 2004 at 02:27:45PM -0500, David Caplan wrote:

> Luke Kenneth Casson Leighton wrote:
> >hi,
> >
> >i have a requirement for setting up a server that might even ban
> >logins - even admin logins.

> How about using a conditional expression (aka "boolean")?  That way you can 
> have a whole chunk of plicy that gets turned on only when you need it 
> (maintenance mode).  

 that's a bleeding good idea.  thanks.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
