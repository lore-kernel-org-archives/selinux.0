Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k18FSYXf009393
	for <selinux@tycho.nsa.gov>; Wed, 8 Feb 2006 10:28:34 -0500 (EST)
Received: from vms053pub.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k18FREJf014179
	for <selinux@tycho.nsa.gov>; Wed, 8 Feb 2006 15:27:14 GMT
Received: from vms134.mailsrvcs.net ([172.19.0.67])
 by vms053.mailsrvcs.net (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0IUD008T6KBLH6D0@vms053.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Wed, 08 Feb 2006 09:28:33 -0600 (CST)
Received: from [10.1.6.17] ([209.60.7.66])
 by vms134.mailsrvcs.net (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTPA id <0IUD00JUVKBK1492@vms134.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Wed, 08 Feb 2006 09:28:33 -0600 (CST)
Date: Wed, 08 Feb 2006 10:25:54 -0500
From: David Caplan <dac@tresys.com>
Subject: Re: auditctl examples?
In-reply-to: <20060208145708.49043.qmail@web51512.mail.yahoo.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: David Slater <ds@hypertechsystems.com>, selinux@tycho.nsa.gov
Message-id: <43EA0D82.3020109@tresys.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060208145708.49043.qmail@web51512.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve G wrote:
>> You said you are interested in using auditctl to do your auditing, but 
>> you can also get what you want with selinux policy.
> 
> This is true, but I wouldn't recommend that. Its too easy to make a typo and
> cause unexpected problems later. In general, people should never need to modify
> policy. It makes too many support problems when everyone has tweeked their
> policy.
> 

I suggested it because you stated in your response that auditctl does 
not support exactly what he wants to do. I agree with you that in 
general people should not have to modify their policy directly. I do 
think it is appropriate to "tweek" the policy when you have a specific 
protection/security requirement that is not addressed by the standard 
policy.

-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
