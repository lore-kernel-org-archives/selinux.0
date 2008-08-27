Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7R5ncL1000320
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 01:49:38 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7R5n8Uc021203
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 05:49:08 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7R5nXSb017969
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 01:49:33 -0400
Received: from pobox.bne.redhat.com (pobox.bne.redhat.com [10.64.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7R5nVDG007682
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 01:49:32 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by pobox.bne.redhat.com (8.13.1/8.13.1) with ESMTP id m7R5nRXC008759
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 15:49:31 +1000
Message-ID: <48B4EAE2.302@redhat.com>
Date: Wed, 27 Aug 2008 15:49:22 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide draft: "Introduction" review
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following is a draft of the Introduction sections for the SELinux 
User Guide. Any comments and corrections are appreciated.

Thanks.

  On Linux® operating systems, files, directories, sockets, devices, and 
so on, are called objects, and processes, such as a user running a 
command, the Mozilla® Firefox® application, and the Apache HTTP Server, 
are called subjects. Linux operating systems use a Discretionary Access 
Control (DAC) system that controls how subjects interact and access 
objects, and how subjects interact with each other. On systems using 
DAC, users control the permissions of objects (files and directories) 
that they own. They could, for example, make their home directories 
world-readable, giving users and subjects (processes) access to 
potentially sensitive information.

DAC mechanisms are fundamentally inadequate for strong system security. 
DAC access decisions are only based on user identity and ownership, 
ignoring other security-relevant information such as the role of the 
user, the function and trustworthiness of the program, and the 
sensitivity and integrity of the data. Each user has complete discretion 
over his objects, making it impossible to enforce a system-wide security 
policy. Furthermore, every program run by a user inherits all of the 
permissions granted to the user and is free to change access to the 
user's objects, so no protection is provided against malicious software. 
Typically, only two major categories of users are supported by DAC 
mechanisms: completely trusted administrators and completely untrusted 
ordinary users. Many system services and privileged programs must run 
with coarse-grained privileges that far exceed their requirements, so 
that a flaw in any one of these programs can be exploited to obtain 
complete system access[1].

The following is an example of permissions used on Linux operating 
systems that do not run Security-Enhanced Linux (SELinux). Use the ls -l 
command to view object (such as a file) permissions:

-rwxrw-r-- 1 user1 group1 0 Aug 18 10:08 file1

  The first three permission bits, rwx, control the access the Linux 
user1 user (in this case, the owner) has to the file1 object. The next 
three permission bits, rw-, control the access the Linux group1 group 
has to the file1 object. The last three permission bits, r--, control 
the access everyone else has to the file1 object. This includes all 
subjects (such as users and processes). By default, when a new object 
(such as a file) is created, everyone has read permissions. If objects 
have read permissions, and their parent folder allows everyone read and 
execute permissions, all subjects (users and processes) have read and 
execute access to these objects. This is not desirable. Note: on Fedora 
10, by default, home directories only allow read, write, and execute 
permissions to the owner. Other subjects, excluding the Linux root user, 
do not have access. Also, the permissions in these examples may differ 
from your system. These examples purposely change the permissions to 
differentiate between the permissions of the owner, group, and everyone 
else.

Security-Enhanced Linux (SELinux) adds Mandatory Access Control (MAC) to 
the Linux kernel, and is enabled by default in Fedora. A general purpose 
MAC architecture needs the ability to enforce an administratively-set 
security policy over all subjects and objects in the system, basing 
decisions on labels containing a variety of security-relevant 
information. When properly implemented, it enables a system to 
adequately defend itself and offers critical support for application 
security by protecting against the tampering with, and bypassing of, 
secured applications. It allows critical processing pipelines to be 
established and guaranteed. MAC provides strong separation of 
applications that permits the safe execution of untrustworthy 
applications. Its ability to limit the privileges associated with 
executing processes limits the scope of potential damage that can result 
from the exploitation of vulnerabilities in applications and system 
services. MAC enables information to be protected from legitimate users 
with limited authorization as well as from authorized users who have 
unwittingly executed malicious applications. The ability for the system 
to do these types of things is necessary before the construction of 
secure systems will be possible[2].

The following is an example of the labels containing security-relevant 
information that are used on subjects and objects on Linux operating 
systems that run SELinux. This information is called the SELinux 
context, and is viewed using the ls -Z command:

-rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1

In this example, SELinux provides a user (unconfined_u), a role 
(object_r), a type (user_home_t), and a category (s0). This information 
is used to make access control decisions. On DAC systems, access is 
controlled based on Linux user and group IDs. SELinux allow rules are 
checked after DAC rules. SELinux allow rules are not used if DAC rules 
deny access first.

Linux and SELinux users

On Linux operating systems that run SELinux, there are Linux users as 
well as SELinux users. SELinux users are part of SELinux policy. Linux 
users are mapped to SElinux users. To avoid confusion, this guide uses 
"Linux user" and "SELinux user" to differentiate between the two.

Benefits of running SELinux

SELinux provides:

* An additional layer of security: a system where subjects (processes) 
are separated from each other by running in their own domains, and rules 
define how subjects interact and access objects (such as files), as well 
as how subjects interact with each other. Actions, such as a subject 
opening an object, are only allowed if a rule exists that specifically 
allows it.

* Fine-grained access control. Stepping beyond traditional UNIX® 
permissions that are controlled at user discretion and based on Linux 
user and group IDs, SELinux access decisions are based on all available 
information, such as an SELinux user, role, and type. SELinux policy is 
administratively-defined, and is not set at user discretion. SELinux 
allow rules (the default action is deny) are not used if DAC rules deny 
access first.

* Type Enforcement®. All subjects and objects are labeled with a type. 
Rules define how types interact and access each other. Access is only 
allowed if a rule exists that specifically allows it.

* Prevention against privilege escalation. Since subjects run in 
domains, and are therefore separated from each other, and rules 
determine how subjects access objects and other subjects, if a service 
is compromised, the attacker only has access to the normal functions of 
that service, and to files that the service has been configured to have 
access to. For example, if the Apache HTTP Server is compromised, an 
attacker is unable to read files in user home directories, unless a 
specific rule was added or configured to allow such access.

SELinux is not:

* Antivirus software.

* A replacement for passwords, firewalls, or other security systems.

* An all-in-one security solution.

SELinux is an addition to DAC rules. It is designed to enhance existing 
security solutions, not replace them. Even when running SELinux, 
continue to follow good security practices, such as keeping software 
up-to-date, using hard-to-guess passwords, firewalls, and so on.

Examples

The following examples demonstrate how SELinux increases security:

* The default action is deny. If a rule does not exist to allow a 
subject access to an object, or a subject access to another subject, 
access is denied.

* Confining users: SELinux can confine Linux users. A number of 
restricted SELinux users exist. Linux users can be mapped to restricted 
SELinux users to take advantage of confined SELinux users. For example, 
mapping a Linux user account to the SELinux user_u user, results in a 
Linux user that is not able to run (unless configured otherwise) set 
user ID (setuid) applications, such as /usr/bin/sudo and su. Also, you 
can disable the execution of objects in user home directories for Linux 
users that are mapped to the SELinux user_u user. If configured, this 
prevents users from executing malicious files, that they may have 
downloaded from the Internet, from their home directories.

* Subject (process) separation. Subjects run in their own domains. This 
prevents other subjects from accessing objects used by other subjects, 
as well as subjects accessing other subjects. For example, when running 
SELinux, unless otherwise configured, an attacker can not compromise a 
Samba server, and then use that Samba server to read and write to 
objects used by other subjects, such as files comprising a website that 
is read by the Apache HTTP server.

* Help limit the damage done by configuration mistakes. An administrator 
may forget to limit zone transfers when running ISC BIND; however, the 
default SELinux context for zone files does not allow them to be updated 
by zone transfers, or written to by named, the ISC BIND daemon, and 
other subjects.

SELinux Architecture and Performance

SELinux is a Linux kernel module. Part of this module is the SELinux 
security server. The security server contains policy rules that define 
what access is allowed. When a subject attempts to interact with an 
object, for example, a process opening a file, a hook in the Linux 
kernel intercepts the system call the process makes to open the file. 
The hook communicates with the security server to check if access should 
be allowed or denied. Decisions made by the security server are cached 
by an Access Vector Cache (AVC). This decreases how often SELinux rules 
in the security server need to be checked, which increases performance. 
SELinux has no effect if DAC rules deny access first.

[performance details to be added later]



[1] "Integrating Flexible Support for Security Policies into the Linux 
Operating System", by Peter Loscocco and Stephen Smalley. This paper was 
originally prepared for the National Security Agency and is, 
consequently, in the public domain. Refer to the 
[http://www.nsa.gov/selinux/papers/freenix01/freenix01.html original 
paper] for details and the document as it was first released. Any edits 
and changes were done by Murray McAllister.

[2] "Meeting Critical Security Objectives with Security-Enhanced Linux", 
by Peter Loscocco and Stephen Smalley. This paper was originally 
prepared for the National Security Agency and is, consequently, in the 
public domain. Refer to the 
[http://www.nsa.gov/selinux/papers/ottawa01/index.html original paper] 
for details and the document as it was first released. Any edits and 
changes were done by Murray McAllister.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
