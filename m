Subject: Re: your mail
To: "frenzy@frenzy.org" <mcclellr@OIT.EDU>
Cc: SELinux@tycho.nsa.gov
Message-ID: <OF73C8A883.7BE9BE45-ON85256A19.00676A3B@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Sat, 24 Mar 2001 13:51:12 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


That's not what the website said. I actually downloaded
(a) the full version
(b) the full 2.4.2 patched kernel
(c) and the patch itself.

All have the same problem. The trick with dobule compile didn't work for
me.
I do run on Redhat 7.0.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



"frenzy@frenzy.org" <mcclellr@OIT.EDU>@tycho.nsa.gov on 03/24/2001 02:26:49
AM

Sent by:  owner-selinux@tycho.nsa.gov


To:
cc:   SELinux@tycho.nsa.gov
Subject:  Re: your mail



It was my understanding that the kernel patch was only made for the
supplied kernel that comes with RH6.1
I could be completely wrong here however. The last one I tried it with was
2.2.17-14smp, which also failed to compile.
Sincerely,

Randy McCleland-Bane
http://www.frenzy.org -- Administrator
MSN: drekbot@hotmail.com ICQ: 32276169
EM: frenzy@frenzy.org,mcclellr@oit.edu
"We must be the change we wish to see
in the world." - Mahatma Gandhi
PGP key: http://www.frenzy.org/frenzy/
frenzy_at_frenzy.org.asc.txt

On Fri, 23 Mar 2001, Hubertus Franke wrote:

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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
