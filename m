Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78Gktj2010055
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 12:46:55 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m78GkgvJ011890
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 16:46:46 GMT
Message-ID: <489C7879.1030905@manicmethod.com>
Date: Fri, 08 Aug 2008 12:46:49 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Can we make libsemanage default to expand-check=0
References: <489864B4.1090605@redhat.com>
In-Reply-To: <489864B4.1090605@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

I'd rather we not do this. We are already losing the vast majority of testers for those codepaths by Fedora turning it off, if it becomes off by default I'm afraid that code will rot like crazy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
