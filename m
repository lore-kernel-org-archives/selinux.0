Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1JEeW6s004293
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 09:40:32 -0500
Received: from pobox.globalherald.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1JEb4hN019335
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 14:37:09 GMT
Received: from [192.168.2.2] (unknown [192.168.2.2])
	by pobox.globalherald.net (Postfix) with ESMTP id 49B181FD06E
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 10:25:32 -0500 (EST)
Date: Thu, 19 Feb 2009 10:25:31 -0500 (EST)
From: Joshua Kramer <josh@globalherald.net>
To: selinux@tycho.nsa.gov
Subject: Application-level Access Management
Message-ID: <alpine.LFD.2.00.0902191020490.13287@home-av-server.home-av>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello Everyone,

I am working on adding SELinux-based ACLs to the Apache QPid project.  I 
have considered how I might accomplish this based on QPid's ACL model. 
However, I have a question.  Can I store the security context of arbitrary 
objects in SELinux itself?  In this case, an 'object' is a C++ object 
inside a qpid daemon: a queue, broker, etc.  The security contexts of 
files, for example, are usually stored in the xattrs on the filesystem. 
Can I store the security context of a qpid queue in SELinux somewhere, or 
do I need to create a file to store those contexts?  Is there a more 
secure way to store the contexts?

More detail about this endeavor is noted below.  This was a recent thread 
on the qpid-dev mailing list.

Thanks,
-Josh

>> AclModule (which is pluggable). Can that not be implemented as a call to 
>> security_compute_av? 
> 
> yea, I think we might have enough abstraction. We might need to add a map of 
> IDs to the object list for SELinux. If that is needed I can volunteer to do

That's what I was thinking, as I took a look at

/qpid/cpp/src/qpid/broker/AclModule.h

...and its friends under qpid/acl.  The data in AclModule.h looks like it's a 
good representation of the various Actions we'll have to model. We will need to 
model the security contexts pertaining to each item.  For example, you can have 
a file type for an index.htm file, of httpd_sys_content_t.  Contrast this to 
user_home_t.  We might have a queue, FinancialDataQueue, that should not be 
able to be read by the webserver.  FinancialDataQueue would have a type of 
fin_content_t.  Since the contexts are not stored in the Qpid objects 
themselves, the ACL plugin will need to map each object to its context.  If a 
user with type httpd_t attempts to read from FinancialDataQueue, then the 
authorize call would go something like this:

1. User Name = 'httpd'
2. Queue Name = 'FinancialDataQueue'
3. Lookup current context of user 'httpd' (that is a SELinux library call, to 
find the SELinux user called 'httpd') and find its type to be httpd_t
4. Lookup current context of queue FinancialDataQueue and find its type to be 
fin_content_t
5. Call security_compute_av with the contexts, and pass or fail as needed.

Number 4 is tricky.  I am not yet sure if SELinux contexts can be stored for 
arbitrary named objects.  On the filesystem the are usually stored in xattrs. 
Dan?

Thoughts?

-- 

-----
http://www.globalherald.net/jb01
GlobalHerald.NET, the Smarter Social Network! (tm)

---------------------------------------------------------------------
Apache Qpid - AMQP Messaging Implementation
Project:      http://qpid.apache.org
Use/Interact: mailto:dev-subscribe@qpid.apache.org


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
