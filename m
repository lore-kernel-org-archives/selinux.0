Date: Fri, 23 Mar 2001 23:26:49 -0800 (PST)
From: "frenzy@frenzy.org" <mcclellr@OIT.EDU>
cc: SELinux@tycho.nsa.gov
Subject: Re: your mail
In-Reply-To: <OFC8827216.E70119F9-ON85256A18.007CF1F0@pok.ibm.com>
Message-ID: <Pine.OSF.4.02.10103232325100.16137-100000@internet.oit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
