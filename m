Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l9MLQlY5002909
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2007 17:26:47 -0400
Message-ID: <471D1596.8070900@tycho.nsa.gov>
Date: Mon, 22 Oct 2007 17:26:46 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: trouble with ssh in today's rawhide + refpolicy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
mode, I get the following after rebooting the box and logging in over ssh:

$ id -Z
sysadm_u:sysadm_r:system_chkpwd_t:s0

After issuing a "service sshd restart" on the box and trying again, it 
changes to:

$ id -Z
sysadm_u:sysadm_r:sysadm_t:s0

I've seen this on 2 different machines, and it persists even after a 
full filesystem relabel.  Am i missing something from the refpolicy 
merge?  I haven't changed my seusers file from when I was running strict.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
