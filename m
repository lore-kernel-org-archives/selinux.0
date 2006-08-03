Subject: [PATCH] SELinux: 0/3-v3 clean up locking and semaphore usage
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:07:36 -0400
Message-Id: <1154639256.8428.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch set attempts to do a little cleanup in SELinux code
concerning the usage of semaphores which we init to 1.  First off there
is nothing wrong with semaphores but with the introduction of simple
mutexes a slightly faster interface is available (see
Documentation/mutex-design.txt)  Since mutexes save time and space I'm
going to deal with both of the semaphores I see in the selinux
code. (isec->sem and sbsec->sem)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
