Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48MexQD000557
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 18:40:59 -0400
Received: from authusersmtp.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48MewEL029713
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 22:40:58 GMT
Message-ID: <445FC8F8.3090809@cornell.edu>
Date: Mon, 08 May 2006 18:40:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: selinux <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
Subject: Re: [PATCH] fix warnings in selinux-usr
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>	 <445CF147.1000300@cornell.edu> <1147091194.32719.4.camel@jackjack.columbia.tresys.com>
In-Reply-To: <1147091194.32719.4.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Sure, conversions would solve the problem, though removing some of this
> duplication would be even better. Any chance you will have a chance to
> take care of this?
>   
I've stopped working on these things for the moment...
How are you suggesting we should get rid of the duplication - use sepol 
structures directly?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
