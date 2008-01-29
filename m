Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TIeGLV005404
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 13:40:17 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0TIeGUK006385
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 18:40:16 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: genhomedircon is broken in libsemanage
Date: Tue, 29 Jan 2008 13:40:15 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588016EF6CA@exchange.columbia.tresys.com>
In-Reply-To: <479F4051.7030101@redhat.com>
References: <479F4051.7030101@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Adding
> 
> mythtv:x:1004:1004::/var/lib/mythtv:/bin/bash
> 
> To /etc/passwd causes the labeling to get all screwed up.  This would
> report an error when we used the python version of genhomedircon and
> not foul up the labeling by checking if there was a label for /var/lib
> already in the file_context file. (Boy do I love python.  :^))
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=430195
> 
> Dan

That shouldn't be hard to add to genhomedircon.c.  I'll take a look.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
