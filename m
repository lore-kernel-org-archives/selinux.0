Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JJTID8010357
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 15:29:18 -0400
Received: from web51509.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JJTHRc018056
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 19:29:17 GMT
Date: Mon, 19 Mar 2007 12:29:17 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] libselinux lazy init
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1174327038.22565.151.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <166300.17002.qm@web51509.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>So possibly it is always an integer in Linux, but the spec and the API
>don't guarantee that, and I did notice that Roland avoided that
>assumption in his code snip

Nor does it guarantee stdbool.h is on every platform. I also wanted to avoid the
overhead of making it into a function rather than a macro. I can code it up like
Roland's code if that's what you want.

-Steve


 
____________________________________________________________________________________
Be a PS3 game guru.
Get your game face on with the latest PS3 news and previews at Yahoo! Games.
http://videogames.yahoo.com/platform?platform=120121

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
