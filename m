Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5KIZVrp022012
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 14:35:31 -0400
Received: from wr-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5KIZVAr009768
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 18:35:31 GMT
Received: by wr-out-0506.google.com with SMTP id c37so1072585wra.26
        for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 11:35:31 -0700 (PDT)
Cc: Chad Hanson <chanson@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <924BE11D-328B-49B1-B793-59D96D5FA4A0@nall.com>
From: Joe Nall <joe@nall.com>
To: Joshua Brindle <method@manicmethod.com>
In-Reply-To: <485BF64E.9060905@manicmethod.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: releasibility in mcstransd
Date: Fri, 20 Jun 2008 13:34:56 -0500
References: <484D91BB.3080904@manicmethod.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F23@HAVOC.tcs-sec.com> <0D76DBC9-5AF4-43C4-8F38-3B7BAD9F2A1F@nall.com> <485BCED3.9020903@manicmethod.com> <FBDB910C-1B8E-4DCD-A427-6EF0B161F329@nall.com> <485BF64E.9060905@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 20, 2008, at 1:26 PM, Joshua Brindle wrote:

> What about semanage? Is it doing translations without calling the  
> translation interfaces that talk to the server?

semanage translation munges the setrans.conf in an incompatible way.

It assumes a 1 to 1 translation model. It could possibly be made to  
work with some file name conventions.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
