Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m897JQ0A002279
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 03:19:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m897IdRP027317
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 07:18:44 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m897JHe8029744
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 03:19:17 -0400
Received: from pobox.bne.redhat.com (pobox.bne.redhat.com [10.64.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m897JErC015245
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 03:19:16 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by pobox.bne.redhat.com (8.13.1/8.13.1) with ESMTP id m897JEd4031039
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 17:19:14 +1000
Message-ID: <48C6236D.4020408@redhat.com>
Date: Tue, 09 Sep 2008 17:19:09 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide draft: "Confined and Unconfined User Domains" review
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following is a draft of the "Confined and Unconfined User Domains" 
section for the SELinux User Guide. Any comments and corrections are 
appreciated.

This is the last part of intro text.

Thanks.


Confined and Unconfined User Domains

Each Linux user account is mapped to an SELinux user identity when a 
user login session is created, and the mapped SELinux user identity is 
used in the security context for processes in that session. By default, 
on Fedora 10, Linux users are mapped to the SELinux unconfined_u user. 
This is seen by running the id -Z and /usr/sbin/semanage login -l commands:

# id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
# /usr/sbin/semanage login -l

Login Name                SELinux User              MLS/MCS Range

__default__               unconfined_u              s0-s0:c0.c1023
root                      unconfined_u              s0-s0:c0.c1023
system_u                  system_u                  s0-s0:c0.c1023

The first row, __default__, defines that any new Linux users created 
that are not specifically mapped to an SELinux user, are mapped to the 
SELinux unconfined_u user. For a description of each column, refer to 
Chapter 3, SELinux Contexts. Unconfined Linux users are subject to 
executable and writeable memory checks, and are also restricted by MCS 
(and MLS, if the MLS policy is used). If they execute an object that the 
SELinux policy defines can transition from the unconfined_t domain to 
its own confined domain, the unconfined Linux users are still subject to 
the restrictions of that confined domain.

The following confined user domains are available in Fedora 10:

guest_t: The guest_t domain is used for minimal-privileged Linux users. 
Linux users in this domain are not allowed to use the X Window System, 
run set user ID (setuid) applications, and do not have network access. 
For example, Permission denied errors are returned when using the ping 
and ssh commands. These users are allowed a log in via a terminal 
(including ssh).

xguest_t: The xguest_t domain is also for minimal-privileged Linux 
users, but lets them use the X Window System. Linux users in this domain 
are not allowed to run setuid applications, and the only network access 
allowed is Firefox connecting to web pages. These users are allowed to 
log in via the X Window System and a terminal.

user_t: The user_t domain is for standard Linux users. Linux users in 
this domain are not allowed to run setuid applications. These users are 
allowed to log in via the X Window System and a terminal, and have full 
network access.

[I think I got this wrong. I got permission denied when trying to use 
ping as a user_u user (useradd -Z user_u test)]

staff_t: The staff_t domain is similar to user_t, except that Linux 
users in this domain are allowed to run the setuid sudo application.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
