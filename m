Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIK26Ii015969
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:02:06 -0500 (EST)
Received: from web50601.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id iAIK0diM026435
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 20:00:39 GMT
Message-ID: <20041118191131.87032.qmail@web50601.mail.yahoo.com>
Date: Thu, 18 Nov 2004 11:11:31 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: polgen and strace
To: "John D. Ramsdell" <ramsdell@mitre.org>, selinux@tycho.nsa.gov
In-Reply-To: <ogtwtwjxpct.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I have made the patch available to all at 
>
>http://simp.mitre.org/selinux

The patch removes the guts of the COPYING file. I wouldn't touch that file. I'd
leave it the way the authors tar'ed it up so that no one says the license changed
due to a 3rd party patch.

The patch should also modify strace.1 to add the -X option. Otherwise looks OK to
me.

-Steve Grubb


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
