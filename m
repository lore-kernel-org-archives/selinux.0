Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIKfZIi016364
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:41:35 -0500 (EST)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIKfc3m010662
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 20:41:38 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with SMTP id iAIKfdA06578
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:41:39 -0500
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 0FB89BF00
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:41:39 -0500 (EST)
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: polgen and strace
References: <20041118191131.87032.qmail@web50601.mail.yahoo.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 18 Nov 2004 15:41:38 -0500
In-Reply-To: <20041118191131.87032.qmail@web50601.mail.yahoo.com>
Message-ID: <ogtsm76lwjh.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve G <linux_4ever@yahoo.com> writes:

> >I have made the patch available to all at 
> >
> >http://simp.mitre.org/selinux
> 

> The patch removes the guts of the COPYING file. I wouldn't touch
> that file. I'd leave it the way the authors tar'ed it up so that no
> one says the license changed due to a 3rd party patch.

Ugh.  I don't know what happened to the COPYING file in my CVS
repository, but I put it back, and I fixed the patch.

> The patch should also modify strace.1 to add the -X
> option. Otherwise looks OK to me.

Good call.  Will do.  Thanks.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
