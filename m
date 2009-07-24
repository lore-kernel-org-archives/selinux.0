Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6O8Ismv018004
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 04:18:54 -0400
Received: from mail-bw0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6O8IUgi025449
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 08:18:30 GMT
Received: by bwz7 with SMTP id 7so1232332bwz.18
        for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 01:18:53 -0700 (PDT)
Message-Id: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: what is an object manager?!
Date: Fri, 24 Jul 2009 10:18:50 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

"Object managers are responsible for enforcing the policy decisions of  
the security server for the set
of resources they manage. For the kernel, you can think of object  
managers as kernel subsystems that
create and manage kernel-level objects. Examples of kernel object  
managers include the filesystem,
process management, and System V interprocess communication (IPC). In  
the LSM architecture, the
object managers are represented by the LSM hooks (!!!); these hooks  
are scattered throughout the kernel
subsystems and call the SELinux LSM module for access decisions. The  
LSM hooks then enforce
those decisions by allowing or denying access to the kernel  
resource." [1]

this basically says we have dozens of object managers, since every LSM  
hook is one!

but here stephen smalley wrote:

An object manager gets access decisions from its AVC, which consults  
the security server when the decision isn't already cached. Meanwhile,  
if a policy change occurs, the security server needs to notify the  
AVCs of all object managers of the change so that their state can be  
updated (in simplest form, by flushing the caches). There can be any  
number of object managers. In Linux, the entire kernel is really a  
single object manager, but in earlier microkernel-based systems, there  
were separate object managers for process management, filesystems, and  
networking.

http://marc.info/?l=selinux&m=115955074232032&w=2


What is an object manager and who says the truth? ;)

"Every LSM hook object manager" vs "1 single Object Manager"

--
Sebastian Pfaff

[1] SELinux by Example: Using Security Enhanced Linux, 1st Edition.  
(Prentice Hall International, 2006).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
