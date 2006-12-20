Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBKMON8e032695
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 17:24:23 -0500
Received: from web51513.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kBKMOwY5007160
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 22:24:59 GMT
Message-ID: <20061220222443.14268.qmail@web51513.mail.yahoo.com>
Date: Wed, 20 Dec 2006 14:24:43 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
        Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1166645324.20187.100.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> > ss/services.c: printk(KERN_INFO <- missing class definitions in policy
>> > ss/services.c: printk(KERN_INFO <- missing permission definitions in policy
>> > ss/services.c: printk(KERN_INFO <- missing inherit definitions in policy
>> 
>> Possibly an audit message?
>
>Maybe it should be an audit as well.  Any opinions?

Not sure this should be audited. Does this mean that policy will malfunction? Or
that labels will not be properly attributed to subj/obj? What is the effect?

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
