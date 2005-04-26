Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3QKI6gA012175
	for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2005 16:18:06 -0400 (EDT)
Received: from web51501.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j3QKI3rP015757
	for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2005 20:18:03 GMT
Message-ID: <20050426201806.58515.qmail@web51501.mail.yahoo.com>
Date: Tue, 26 Apr 2005 13:18:05 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Signal problem
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Isn't this unreliable anyway, e.g. your hook might queue up the audit
>message for processing by auditd, but auditd gets the signal before it
>handles the message and exits without emptying the queue?

The message would be in syslog in that scenario. It isn't there either.

-Steve


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
