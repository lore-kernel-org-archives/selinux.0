Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAS418Qo011514
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2008 23:01:08 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAS3x6IJ007270
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2008 03:59:06 GMT
Message-ID: <492F6CF4.3080405@redhat.com>
Date: Fri, 28 Nov 2008 14:00:52 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        Dominick Grift <domg472@gmail.com>
Subject: user guide draft: "Booleans for Users Executing Applications"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In the "Confined and Unconfined Users" section[1], the confined user 
table states that guest_u, xguest_t etc. can not execute applications in 
~/ or /tmp. I have changed the "no"'s and "yes"'s to "optional", with a 
link to the following section that appears at the end of the "Confining 
Users" chapter[2]:

Booleans for Users Executing Applications

By default, Linux users in the guest_t and xguest_t domains can not 
execute applications in their home directories or /tmp/, preventing them 
from executing applications (which inherit users' permissions) in 
directories they have write access to. This helps prevent flawed or 
malicious applications from modifying files users' own.

The setsebool command must be run as the Linux root user. The setsebool 
-P command makes persistent changes. Do not use the -P option if you do 
not want changes to persist across reboots:

guest_t

To allow Linux users in the guest_t domain to execute applications in 
their home directories and /tmp/:

/usr/sbin/setsebool allow_guest_exec_content on

xguest_t

To allow Linux users in the xguest_t domain to execute applications in 
their home directories and /tmp/:

/usr/sbin/setsebool allow_xguest_exec_content on

user_t

To prevent Linux users in the user_t domain from executing applications 
in their home directories and /tmp/:

/usr/sbin/setsebool allow_user_exec_content off

staff_t

To prevent Linux users in the staff_t domain from executing applications 
in their home directories and /tmp/:

/usr/sbin/setsebool allow_staff_exec_content off

Thanks.


[1] 
<http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/sect-Security-Enhanced_Linux-Targeted_Policy-Confined_and_Unconfined_Users.html>

[2] 
<http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/chap-Security-Enhanced_Linux-Confining_Users.html>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
