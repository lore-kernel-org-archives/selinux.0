MIME-Version: 1.0
To: <SELinux@tycho.nsa.gov>
Message-ID: <OFC8827216.E70119F9-ON85256A18.007CF1F0@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 23 Mar 2001 18:02:08 -0500
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

just downloaded the SELinux for 2.4.

I did the ./tools/build-kernel  and get the following errors.


/home/frankeh/slinux/kernel/include/linux/flask/avc.h:13:31:
linux/flask/flask.h: No such file or directory


/home/frankeh/slinux/kernel/include/linux/flask/security.h:49:32:
config/flask/audit.h: No such file or directory

Looks like various files are missing in the distribution.
Any ideas ?


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
