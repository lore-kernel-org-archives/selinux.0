Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QKucBR022055
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 15:56:38 -0500
Received: from web51510.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QKvwW2017224
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 20:57:58 GMT
Date: Mon, 26 Feb 2007 12:57:43 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Lazy config init in libselinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1172517022.19041.280.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <388819.82266.qm@web51510.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>The problem with doing it on first use is it isn't thread-safe; the code
>is initializing globals for the library's subsequent use.  And making
>those variables per-thread would be wasteful as they truly are global
>state to the library.  So initializing them in the library constructor
>is the right thing to do.

How do you feel about __libc_once  ?

-Steve


 
____________________________________________________________________________________
Need a quick answer? Get one in minutes from people who know.
Ask your question on www.Answers.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
