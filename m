Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k18E5JXf008353
	for <selinux@tycho.nsa.gov>; Wed, 8 Feb 2006 09:05:19 -0500 (EST)
Received: from vms053pub.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k18E5HjH022904
	for <selinux@tycho.nsa.gov>; Wed, 8 Feb 2006 14:05:17 GMT
Received: from vms122.mailsrvcs.net ([172.19.0.67])
 by vms053.mailsrvcs.net (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0IUD007X6GGURF70@vms053.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Wed, 08 Feb 2006 08:05:18 -0600 (CST)
Received: from [10.1.6.17] ([209.60.7.66])
 by vms122.mailsrvcs.net (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTPA id <0IUD00A3OGGT8FWW@vms122.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Wed, 08 Feb 2006 08:05:18 -0600 (CST)
Date: Wed, 08 Feb 2006 09:02:40 -0500
From: David Caplan <dac@tresys.com>
Subject: Re: auditctl examples?
In-reply-to: <43E9024D.9030304@hypertechsystems.com>
To: David Slater <ds@hypertechsystems.com>
Cc: selinux@tycho.nsa.gov
Message-id: <43E9FA00.4070304@tresys.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <43E9024D.9030304@hypertechsystems.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

You said you are interested in using auditctl to do your auditing, but 
you can also get what you want with selinux policy. It's relatively more 
involved because you actually have to add the auditing to the policy 
(i.e., you have to edit the policy source, build it, and load it) versus 
the command-line ease of auditctl. The benefit is that you can audit the 
exact access you care about.  For example you can audit any access just 
to the directory (assuming it was labeled with restrict_t):

auditallow * restrict_t:dir *;

The above line audits any access granted to directories labeled as 
restrict_t (note that it does not *grant* any access and all denied 
access attempts are automatically audited). Or you can specify exactly 
who gets audited and for exactly which permissions (i.e., replace the 
'*'s with actual types and permissions). You could also wrap the audit 
statement(s) in a conditional expression so you could turn it on and off 
without reloading/rebuilding the policy.

Another difference with using policy to do this is that you can easily 
audit access to all directories labeled a particular way instead of 
having to specify every path. You can also audit access to particular 
files in the directory the same way.

David

David Slater wrote:
> I am interested in using auditctl, but am having trouble understanding 
> how to do so using the man page.  I apologize if this is not the 
> appropriate forum for this question, but it appears to be the logical 
> path thus far.  Specifically, I would like to understand the concept of 
> adding a watch to a filesystem
> object.  I would like to generate an audit entry in 
> /var/log/audit/audit.log each time a restricted directory is accessed.  
> It would be greatly appreciated if anyone could forward examples of 
> doing so.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.


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
