Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA26577
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 02:51:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA26316
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 06:49:26 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id GAA26312 for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 06:49:24 GMT
Date: Mon, 12 Aug 2002 16:50:57 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Swollen su_macros.te file
Message-ID: <20020812065057.GP2149@snoopy.apana.org.au>
References: <20020811185607.42370.qmail@web40006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020811185607.42370.qmail@web40006.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 11, 2002 at 11:56:07AM -0700, Brad Chapman wrote:
>       Lately I have noticed that my su_macros.te file is becoming unmanageable
> due to the enormous amount of stuff that I use su for. Could you (and the list)
> please review my su_macros.te file and tell me how to make it smaller?

Assuming Russell does not help you with his line of questioning (which I
won't duplicate here), how do you use su to get root access?

What is the output of "id"[1] before and after the su command?

Note:
[1] I am assuming your version of su has been modified to display
the SE-Linux label here.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
