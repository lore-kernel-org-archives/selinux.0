Message-ID: <72222DC86846D411ABD300A0C9EB08A101524431@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>, SELinux@tycho.nsa.gov
Subject: initrd kernel panic
Date: Wed, 16 Oct 2002 09:13:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When trying to use the initrd
policy with an selinux kernel I am
getting the following panic


ss: loading policy configuration from <NULL>


in looking at the security_init from init.c


fp = fopen(policyfile, "r"); 

the policyfile is null. Is there a kernel parameter
or something I am missing.


the initrd has /etc/security/selinux/policy.11
    (build from the make initrd-policy)

and the initrd was labeled with types.fc

Mark

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
