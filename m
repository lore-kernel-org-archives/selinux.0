Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AE0MgA018701
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 10:00:22 -0400 (EDT)
Received: from web51508.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5ADqkfM022343
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 13:52:46 GMT
Message-ID: <20050610135235.35540.qmail@web51508.mail.yahoo.com>
Date: Fri, 10 Jun 2005 06:52:35 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Restorecon script
To: gyurdiev@redhat.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118370767.30464.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>Creating folders ahead of time is the most acceptable solution so far.

What if the machine doesn't have X installed? (Such as a server.)

>I'm not sure how exactly this should be done, but some sort of simple 
>script like this is one possibility. 

How about walking the list of dirs and if they exist, do a restorecon? I'm
assuming this script is going to be called via /etc/bashrc?

-Steve Grubb


		
__________________________________ 
Discover Yahoo! 
Stay in touch with email, IM, photo sharing and more. Check it out! 
http://discover.yahoo.com/stayintouch.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
