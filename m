Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7R6tAYV011868
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 02:55:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7R6sbUc009682
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 06:54:41 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7R6t2D4009880
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 02:55:02 -0400
Received: from pobox.bne.redhat.com (pobox.bne.redhat.com [10.64.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7R6sxKn028022
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 02:55:00 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by pobox.bne.redhat.com (8.13.1/8.13.1) with ESMTP id m7R6sx7D018127
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 16:54:59 +1000
Message-ID: <48B4FA3E.3000602@redhat.com>
Date: Wed, 27 Aug 2008 16:54:54 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide draft: "SELinux Contexts and Attributes" review
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following is a draft of the SELinux Contexts and Attributes sections 
for the SELinux User Guide. Any comments and corrections are appreciated.

Thanks.

As previously mentioned, on Linux operating systems, files, directories, 
sockets, devices, and so on, are called objects, and processes, such as 
a user running a command, the Firefox application, and the Apache HTTP 
Server, are called subjects. SELinux provides the Type Enforcement 
security model. To enforce this, subjects and objects are labeled with 
an SELinux context that contains additional information, such as an 
SELinux user, role, and type. When running SELinux, all of this 
information is used to make access control decisions.

The following is an example of the additional SELinux information used 
on Linux operating systems that use SELinux. This information is called 
the SELinux context, and is viewed using the ls -Z command:

-rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1

SELinux contexts follow the SELinux user:role:type:category syntax:

SELinux user: The SELinux user identity is an identity known to the 
policy that is authorized for a specific set of roles and for a specific 
MLS range. Each Linux user account is mapped to an SELinux user identity 
when a user login session is created, and the mapped SELinux user 
identity is used in the security context for processes in that session 
in order to bound what roles and levels they can enter[1]. Run the 
/usr/sbin/semanage login -l command to view a list of mappings between 
SELinux and Linux user accounts:

Login Name                SELinux User              MLS/MCS Range

__default__               unconfined_u              s0-s0:c0.c1023
root                      unconfined_u              s0-s0:c0.c1023
system_u                  system_u                  s0-s0:c0.c1023
test2user                 user_u                    s0
xguest                    xguest_u                  s0

Output may differ from system to system. The Login Name column lists 
Linux users, and the the SELinux User column lists which SELinux user is 
mapped to which Linux user. The SELinux user does not restrict the 
access subjects have to objects. The last column, MLS/MCS Range, are 
categories that are used by Multi-Level Security (MLS) and 
Mutli-Category Security (MCS). MLS and MCS categories are discussed 
briefly later.

role: Part of SELinux is the Role Based Access Control (RBAC) security 
model. The role is an attribute of RBAC. Roles are associated with 
domain types, and domain types are associated with SELinux users. Roles 
are important when writing policies, as they restrict domain 
transitions, but they do not restrict the access subjects have to 
objects, and as such, they are not discussed in detail in this guide.

type: The type is an attribute of Type Enforcement. The type defines a 
domain type for subjects, and a type for objects. SELinux policy rules 
define how types access each other, whether it be a domain accessing a 
type, or a domain accessing another domain. Access is only allowed if a 
specific rule exists that allows it.

category: The category is an attribute of Multi-Level Security (MLS) and 
Multi-Category Security (MCS). Categories are used to categorize data, 
and identify its sensitivity or security level. Standard SELinux policy 
supports MCS; however, it is not heavily used. MCS allows users, at 
their own discretion, to add a category to a piece of data, for example, 
PatientRecord or CompanyConfidential. There is only a single security 
level, s0. MLS labels data with both categories (CompanyConfidential) 
and a sensitivity level. MLS enforces the Bell-LaPadula Mandatory Access 
Model, and is used in Labeled Security Protection Profile (LSPP) 
environments.

Domain Transitions

On Linux operating systems that run SELinux, processes, such as a user 
running the less command, or an Apache HTTP server, are called subjects. 
An executable object transitions to a subject, and a subject runs in a 
domain. This transition is called a domain transition. The following 
example demonstrates a domain transition:

1. A users wants to change their password. To change their password, 
they run the /usr/bin/passwd command. The /usr/bin/passwd file object is 
labeled with the passwd_exec_t file type:

$ ls -Z /usr/bin/passwd
-rwsr-xr-x  root root system_u:object_r:passwd_exec_t:s0 /usr/bin/passwd

The passwd application needs to access the /etc/shadow object, which is 
labeled with the shadow_t file type:

$ ls -Z /etc/shadow
-r--------  root root system_u:object_r:shadow_t:s0    /etc/shadow

2. An SELinux policy rule states that subjects running in the passwd_t 
domain type are allowed to read and write to objects that are labeled 
with the shadow_t file type. The /etc/shadow object is the only object 
that is labeled with the shadow_t file type.

3. When a user runs the /usr/bin/passwd command, the application 
transitions to a subject (a process), which is running in the passwd_t 
domain type. With SELinux, since the default action is to deny, and a 
rule exists that allows (among other things) applications running in the 
passwd_t domain type to access objects labeled with the shadow_t file 
type, the passwd application is allowed to access /etc/shadow, and 
update the user's password.

This example is not exhaustive, and is used as a basic example to 
explain domain transition. Although there is an actual rule that allows 
subjects running in the passwd_t domain type to access objects labeled 
with the shadow_t file type, other rules must be met before the object 
can successfully transition.

SELinux Contexts for Subjects

On Linux operating systems the run SELinux, when an application is 
executed, that application transitions to a subject and runs in a 
domain. The SELinux context for subjects is viewed using the pstree -Z 
command. For example:

1. Open a terminal, such as Applications → System Tools → Terminal.

2. Run the /usr/bin/passwd command. Do not enter a new password.

3. Open a new tab, or another terminal, and run the pstree -Z | grep 
passwd command. The output is similar to the following:

|  |        `-passwd(`unconfined_u:unconfined_r:passwd_t:s0-s0:c0.c1023')

4. In the first tab, cancel passwd application.

In this example, when the /usr/bin/passwd object, which is labeled with 
the passwd_exec_t file type, is executed, it transitions to a subject 
that runs in the passwd_t domain type. Remember: the type defines a 
domain type for subjects, and a type for objects.

To view the SELinux contexts for all subjects, run the pstree -Z 
command. The following is an example of the pstree -Z output, and may 
differ on your system:

├─NetworkManager(`system_u:system_r:NetworkManager_t:s0')
│  └─{NetworkManager}(`system_u:system_r:NetworkManager_t:s0')
├─acpid(`system_u:system_r:apmd_t:s0')
├─anacron(`system_u:system_r:system_crond_t:s0')
├─atd(`system_u:system_r:crond_t:s0-s0:c0.c1023')
├─auditd(`system_u:system_r:auditd_t:s0')


By default, the SELinux targeted policy is used. When using targeted 
policy, most subjects (processes) use the system_r role. Type 
enforcement then separates each domain.

Run the id command to view the SELinux context associated with your 
Linux user:

uid=500(user) gid=500(group) groups=500(group) 
context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

On Fedora 10, Linux users run unconfined by default. This SELinux 
context shows that the Linux user is mapped to the SELinux unconfined_u 
user, running as the unconfined_r role, and is running in the 
unconfined_t domain type. SELinux rules do not affect Linux users that 
are running in the unconfined_t domain type; however, UNIX permissions 
still apply.


[1] Smalley, Stephen. "Re: SELinux User Guide: weekly report 20080822". 
Email to Murray McAllister, 25 August 2008. Any edits were done by 
Murray McAllister.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
