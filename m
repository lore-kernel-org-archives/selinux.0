Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EKdX7C021139
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 16:39:33 -0400 (EDT)
Received: from web51510.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j3EKX1IT001707
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 20:33:01 GMT
Message-ID: <20050414203549.46129.qmail@web51510.mail.yahoo.com>
Date: Thu, 14 Apr 2005 13:35:49 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: RE: dcache_lock deadlock due to auditing
To: Daniel H Jones <danjones@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I'm guessing the security context obtained from the SELinux hooks are 
>is represented by a sid. Is this true? 

Yes. This patch is already part of the audit subsystem code and on its way
upstream.

>If that's the case, can it be readily converted to the string representation 
>for display at audit_log_exit time?

The patch does that.

-Steve Grubb


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
