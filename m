Message-ID: <72222DC86846D411ABD300A0C9EB08A10152434B@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: SELinux@tycho.nsa.gov
Cc: "'russell@coker.com.au'" <russell@coker.com.au>,
        "'sds@tislabs.com'"
	 <sds@tislabs.com>,
        "'hdholm@epoch.ncsc.mil'" <hdholm@epoch.ncsc.mil>
Subject: Generic SELinux Package
Date: Thu, 18 Apr 2002 11:32:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In building a generic SELinux package, I have come across a small 
Problem. 

In the generic kernel I built the SCSI drivers as modules.
The problem is I am using a machine with a SCSI disk. 
Unless I build the kernel with the Drivers built in I could
not boot,  I created an initrd (initial Ram Disk). Now the
problem. In order to boot with the ram disk I had to copy
the policy file over to the ram disk. This leaves with the
following options.
	1. Do not support SCSI in the generic package.
	2. Modify the policy Makefile to look and see
         if we are using a initrd and rebuild the
         ram disk with the new policy.
	3. Insert into the init scripts to reload the /ss_policy.


Any Suggestions or comments ?

Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
