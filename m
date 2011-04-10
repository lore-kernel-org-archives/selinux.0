Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3AHC7F8002179
	for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2011 13:12:07 -0400
Received: from e24smtp01.br.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3AHC6EV014773
	for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2011 17:12:06 GMT
Received: from /spool/local
	by e24smtp01.br.ibm.com with XMail ESMTP
	for <selinux@tycho.nsa.gov> from <rcvalle@linux.vnet.ibm.com>;
	Sun, 10 Apr 2011 14:12:05 -0300
Message-ID: <4DA1E50F.4060506@linux.vnet.ibm.com>
Date: Sun, 10 Apr 2011 14:12:47 -0300
From: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: SELinux mixed/virtualisation policy
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

As this is my first message to the list, I'd like to introduce myself.
I'm a Security Engineer at IBM Linux Technology Center, Founder at RISE
Security, and I'm currently working on Common Criteria Evaluation.

During the work on developing test cases for KVM and libvirt using the
MLS policy, after several failed attempts to make KVM and libvirt work
using MLS policy out of the box, I've been informed that libvirt does
not support dynamic labeling using MLS policy, which actually makes sense.

However, I and Dan Walsh (who kindly informed me about libvirt) both
agree that dynamic labeling is more secure than manual labeling using
MLS policy, for virtual machine environments.

This made me think for several hours about the policies currently
available and the virtualised environments. Thus, I'd like to make a
proposal and hear your opinions.


SELinux mixed policy

The SELinux mixed policy can have non hierarchical sensitivities that
have the same behavior of a categorized only environment. Such
sensitivities should not be included in the default sensitivity
hierarchy (i.e. s0 to s15). Thus, all rules for these sensitivities
should be explicitly stated. This allows creating a unique sensitivity
for virtual machine environments that is not part of the default
sensitivity hierarchy.

One of the main goals of virtualisation (amongst others) is the
representation of a physical environment in a logical environment to
obtain better usage of the available resources. However, physical and
logical objects should not belong to the same hierarchy, as it is in a
non virtualised environment.

In a non virtualised environment, one physical computer can not dominate
and/or communicate with a process of another physical computer without
any sort of well defined communication protocol, which can not infer a
hierarchy between physical objects and logical objects. Thus, a physical
computer can not dominate a process of another physical computer (i.e. a
guest -a process representing a virtual machine- should never dominate a
process of the host), something that is actually possible in the
currently available policies.

The main goal of having non hierarchical sensitivities available, or, at
a minimum, a sensitivity optionally available for use by the virtual
environment (i.e. sv -which does not belongs to the default hierarchy-),
is to better represent a physical environment where a physical computer
(usually) can not be automatically subjected to another physical
computer that has been compromised.


Virtualisation policy

Considering the above policy, a police could be refined to allow a
hierarchy to be defined between the guests only (i.e. sv0 to sv15), and
rules between the host sensitivities and guest sensitivities should be
explicitly stated. The categories constrains for the virtualisation
sensitivities should behave the same way as the constrains for the
standard sensitivities. This will result in the following

Host processes (in a non virtualised environment, a process)
s0-s15:c0-c255

Host processes representing virtual machines (in a non virtualised
environment, a physical computer)
sv0-sv15:c0-c255

The communication between them should be explicitly stated, as they are
two different types of object in a non virtualised environment (and the
communication between them only would occur when explicitly stated).

Please, let me know what you think. Any comments, critics and/or
suggestions would be greatly appreciated.

Best regards,

- -- 
Ramon de Carvalho Valle
Security Engineer
IBM Linux Technology Center
rcvalle@linux.vnet.ibm.com
http://rcvalle.com/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2h5Q8ACgkQkcIYeh81wLmeoACgkabADsP+i80M3VxFMw1deXk/
V4QAn2AbkKdzlSH7xM4xLj06ftAimm5n
=egxz
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
