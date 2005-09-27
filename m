Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RGv3Ns026681
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:57:03 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RGpapk027390
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 16:51:37 GMT
Message-ID: <43397AAA.2060807@cornell.edu>
Date: Tue, 27 Sep 2005 13:00:26 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: selinux@tycho.nsa.gov, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage-functionality 11/17
References: <200509271249.j8RCnfYs026088@gotham.columbia.tresys.com>
In-Reply-To: <200509271249.j8RCnfYs026088@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:

>Makefile changes to build a shared libsemanage library.
>  
>
I am not clear on how exporting symbols is done, but it would be better 
if the things I'm currently working on are _not_ exported, because they 
are in flux. What changes (if any) should I make to disable this 
functionality?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
