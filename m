Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71CAjqf021232
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 08:10:45 -0400
Received: from web51507.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l71CAifE006005
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 12:10:44 GMT
Date: Wed, 1 Aug 2007 05:10:44 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: selinux rsbac and grsecurity internels
To: shahbaz khan <shazalive@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <7b740b700707311712n3c695740gb540b88412596a5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <329919.34996.qm@web51507.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>6.Is there any good logging facility apart from regular denial? I have
>heard rsbac and grsecurity has better logging facilities.

Yes, there is a complete audit system unrelated to selinux that has been in the
upstream kernel since 2.6.6. Its been through 7 CAPP evals and 2 LSPP evals. The
linux-audit mail list might be a better place to ask questions about it, though.

-Steve Grubb


      ____________________________________________________________________________________
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us. http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
