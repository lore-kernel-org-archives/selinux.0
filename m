Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25040
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 15:04:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA26440
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 20:04:10 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id UAA26436
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 20:04:09 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152428B@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: selinux@tycho.nsa.gov
Subject: Re: General Users
Date: Tue, 15 Jan 2002 14:03:24 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am not worried about user Profile Management or any type 
of group management.

The issues is the actual SELinux policy management.
When you create the policy from the policy
rules the binary file is store in /ss_policy. To add a 
user to the system now you must:
	1. Add the user to the system
	2. Add the user to the file SELinux/policy/users
		user xxxx roles { user_r };
	3. Rebuild the policy file.
		make install
	4. Load the new policy into the kernel or reboot.
		load_policy /ss_policy
	5. Add the user to the /etc/security/default_context
	6. Add the user to the /etc/security/cron_context


Some of the problems I will have with this type of implementation is
	1. I do not believe that the load_policy will be allowed on the 
         general workstation (security reasons) . That leaves only reboot. 
	2. Rebuild the policy file for hundred workstation is not a feasible

	   implementation. 
	3. The policy files will the same for each workstations so a push of
         the policy files is ok. (this will be performed via encryption)
	4. As stated early password will be distributed via NIS (legacy
reasons
         not an option to change).

Any more Ideas or suggestions would be greatly appreciated

Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
