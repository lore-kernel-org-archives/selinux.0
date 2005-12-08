Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB8LaBMA013838
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 16:36:11 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB8LTF5Y014204
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 21:29:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jB8LTGn5013024
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 16:29:16 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jB8LTGV21315
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 16:29:16 -0500
Message-ID: <4398A5AD.2010701@redhat.com>
Date: Thu, 08 Dec 2005 16:29:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: Interesting reading on exec* access checks.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://people.redhat.com/drepper/selinux-mem.html

We are planning on turning off allow_execmem, allow_execmod, 
allow_execheap for unconfined_t in targeted policy.  We are working to 
clean up any problems this might cause.  This will add additional 
security features to Userspace, but might cause headaches.

If you have the latest policy installed on Rawhide

selinux-policy-targeted-2.1.0-3 or later you can try it out by running

setsebool -P allow_execmem=0 allow_execmod=0 allow_execheap=0

You might need to relabel /usr/lib and /lib.

Any help would be appreciated.  :^)

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
