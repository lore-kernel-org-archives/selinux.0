Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UMQsDo019822
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:26:56 -0500 (EST)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UMPeo4006773
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 22:25:40 GMT
Message-ID: <424B27BA.8060706@trustedcs.com>
Date: Wed, 30 Mar 2005 16:27:06 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: Getting the real task name in avc messages
References: <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Wed, 30 Mar 2005, James Morris wrote:
> 
> 
>>This will be looked upon dimly upstream:
>>
>>+        char name[sizeof(current->comm)];
>>
>>the kernel stack space is very limited.
> 
> 
> Actually, current->comm is only defined by default to be 16 bytes, so it's 
> ok.
> 
> 
> - James

You could also just do:

	task_lock(current);
	audit_log_format(ab, " comm=%s", current->comm);
	task_unlock(current);

This avoids an unnecessary copy since we have no use the data after the
audit_log_format call.

I really like the idea of moving this functionality to the standard
syscall audit record.  I'm sure that this would be nice info to have
for folks who do not run SELinux.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
