Message-ID: <48B63BAE.6030806@redhat.com>
Date: Thu, 28 Aug 2008 15:46:22 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Introduction" review
References: <48B4EAE2.302@redhat.com> <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Thank you for your feedback. I know it is frustrating having to deal 
with people on my level :) Changes inline:

Stephen Smalley wrote:
> On Wed, 2008-08-27 at 15:49 +1000, Murray McAllister wrote:
>> Hi,
>>
>> The following is a draft of the Introduction sections for the SELinux 
>> User Guide. Any comments and corrections are appreciated.
>>
>> Thanks.
>>
>>   On Linux® operating systems, files, directories, sockets, devices, and 
>> so on, are called objects, and processes, such as a user running a 
>> command, the Mozilla® Firefox® application, and the Apache HTTP Server, 
>> are called subjects. Linux operating systems use a Discretionary Access 
>> Control (DAC) system that controls how subjects interact and access 
>> objects, and how subjects interact with each other.
> 
> The first two statements are actually true of most operating systems.

On most operating systems, files, directories, sockets...

Also, most operating systems use a Discretionary Access Control (DAC) 
system that...

[snip]

>> The following is an example of permissions used on Linux operating 
>> systems that do not run Security-Enhanced Linux (SELinux). Use the ls -l 
>> command to view object (such as a file) permissions:
>>
>> -rwxrw-r-- 1 user1 group1 0 Aug 18 10:08 file1
>>
>>   The first three permission bits, rwx, control the access the Linux 
>> user1 user (in this case, the owner) has to the file1 object. The next 
>> three permission bits, rw-, control the access the Linux group1 group 
>> has to the file1 object. The last three permission bits, r--, control 
>> the access everyone else has to the file1 object. This includes all 
>> subjects (such as users and processes). By default, when a new object 
>> (such as a file) is created, everyone has read permissions.
> 
> Depends on the umask, and can be customized in /etc/profile or ~/.bashrc
> or similar files.  It isn't really the permissiveness of the default
> umask that is the key issue here, btw.

Is this correct:

On Fedora 10, if the default umask (0002) is used, when a new object 
(such as a file) is created, everyone has read permissions.

Or remove it?

[snip]

>> Benefits of running SELinux
>>
>> SELinux provides:
>>
>> * An additional layer of security: a system where subjects (processes) 
>> are separated from each other by running in their own domains, and rules 
>> define how subjects interact and access objects (such as files), as well 
>> as how subjects interact with each other. Actions, such as a subject 
>> opening an object, are only allowed if a rule exists that specifically 
>> allows it.
>>
>> * Fine-grained access control. Stepping beyond traditional UNIX® 
>> permissions that are controlled at user discretion and based on Linux 
>> user and group IDs, SELinux access decisions are based on all available 
>> information, such as an SELinux user, role, and type. SELinux policy is 
>> administratively-defined, and is not set at user discretion. SELinux 
>> allow rules (the default action is deny) are not used if DAC rules deny 
>> access first.
> 
> This bullet mixes two different concepts:  fine-grained access control
> and administratively-defined policy.  Both are important, but they are
> distinct.
>> * Type Enforcement®. All subjects and objects are labeled with a type. 
>> Rules define how types interact and access each other. Access is only 
>> allowed if a rule exists that specifically allows it.
> 
> This bullet seems redundant with the first one - it merely refines the
> general notions of subject and object to types.

* All subjects and objects are labeled with a type. Subjects (processes) 
are separated from each other by running in their own domains, and rules 
define how subjects interact and access objects (such as files), as well 
as how subjects interact with each other. Access is only allowed if a 
rule exists that specifically allows it.

* Fine-grained access control. Stepping beyond traditional UNIX® 
permissions that are controlled at user discretion and based on Linux 
user and group IDs, SELinux access decisions are based on all available 
information, such as an SELinux user, role, and type.

* SELinux policy is administratively-defined, enforced system-wide, and 
is not set at user discretion.

>> * Prevention against privilege escalation. Since subjects run in 
>> domains, and are therefore separated from each other, and rules 
>> determine how subjects access objects and other subjects, if a service 
>> is compromised, the attacker only has access to the normal functions of 
>> that service, and to files that the service has been configured to have 
>> access to. For example, if the Apache HTTP Server is compromised, an 
>> attacker is unable to read files in user home directories, unless a 
>> specific rule was added or configured to allow such access.

Reduced vulnerability to privilege escalation attacks. One example: 
since subjects run in domains...

> This is one way in which SELinux can be applied.  Other goals to which
> SELinux can be applied include enforcing data confidentiality and
> integrity, protecting privileged subjects from untrustworthy inputs, and
> ensuring the invocation of critical processing. 

Added to the end of the list:

Other goals to which SELinux can be applied include enforcing data 
confidentiality and integrity, protecting privileged subjects from 
untrustworthy inputs, and ensuring the invocation of critical processing.[1]

>> SELinux is not:
>>
>> * Antivirus software.
>>
>> * A replacement for passwords, firewalls, or other security systems.
>>
>> * An all-in-one security solution.
>>
>> SELinux is an addition to DAC rules.
> 
> This doesn't quite sound right, as it makes it sound as though SELinux
> is an extension to DAC vs. an orthogonal access control scheme (MAC).
> 
>>  It is designed to enhance existing 
>> security solutions, not replace them. Even when running SELinux, 
>> continue to follow good security practices, such as keeping software 
>> up-to-date, using hard-to-guess passwords, firewalls, and so on.

SELinux is designed to enhance existing security solutions, not replace 
them...

>>
>> Examples
>>
>> The following examples demonstrate how SELinux increases security:
>>
>> * The default action is deny. If a rule does not exist to allow a 
>> subject access to an object, or a subject access to another subject, 
>> access is denied.
>>
>> * Confining users: SELinux can confine Linux users. A number of 
>> restricted SELinux users exist. Linux users can be mapped to restricted 
>> SELinux users to take advantage of confined SELinux users. For example, 
>> mapping a Linux user account to the SELinux user_u user, results in a 
>> Linux user that is not able to run (unless configured otherwise) set 
>> user ID (setuid) applications, such as /usr/bin/sudo and su. Also, you 
>> can disable the execution of objects in user home directories for Linux 
>> users that are mapped to the SELinux user_u user. If configured, this 
>> prevents users from executing malicious files, that they may have 
>> downloaded from the Internet, from their home directories.
>>
>> * Subject (process) separation. Subjects run in their own domains. This 
>> prevents other subjects from accessing objects used by other subjects, 
>> as well as subjects accessing other subjects. For example, when running 
>> SELinux, unless otherwise configured, an attacker can not compromise a 
>> Samba server, and then use that Samba server to read and write to 
>> objects used by other subjects, such as files comprising a website that 
>> is read by the Apache HTTP server.
> 
> Here you can point specifically to past examples of flaws that would be
> mitigated by SELinux.  See for example:
> http://www.tresys.com/innovation.php (SELinux Mitigation News, on the right)
> http://www.redhatmagazine.com/2008/02/26/risk-report-three-years-of-red-hat-enterprise-linux-4/
> http://www.linuxworld.com/news/2008/022408-selinux.html?page=1
> http://james-morris.livejournal.com/25421.html

Thank you. I am adding links for these.

> 
>> * Help limit the damage done by configuration mistakes. An administrator 
>> may forget to limit zone transfers when running ISC BIND; however, the 
>> default SELinux context for zone files does not allow them to be updated 
>> by zone transfers, or written to by named, the ISC BIND daemon, and 
>> other subjects.

Someone mentioned "What is ISC BIND". I need to change this to a more 
simple example.

> 
>> SELinux Architecture and Performance
>>
>> SELinux is a Linux kernel module.
> 
> Actually, to be precise, SELinux is a Linux kernel subsystem or a Linux
> security module.  It has to be built-in; you cannot build and load it as
> a loadable kernel module due to its tight integration with core kernel
> structures and interfaces and its need to start handling kernel objects
> and operations from the beginning.
> 
>>  Part of this module is the SELinux 
>> security server. The security server contains policy rules that define 
>> what access is allowed.
> 
> I'd tend to say "is driven by loadable policy rules" or "is driven by a
> loadable policy configuration" rather than "contains policy rules" as
> the latter suggests that the rules are fixed/hardcoded.
> 
>>  When a subject attempts to interact with an 
>> object, for example, a process opening a file, a hook in the Linux 
>> kernel intercepts the system call the process makes to open the file. 
>> The hook communicates with the security server to check if access should 
>> be allowed or denied.
> 
> I'd change "communicates" to "calls" since it is a function call rather
> than an IPC in Linux.

SELinux is a Linux security module that is built into the Linux kernel. 
Part of this module is the SELinux security server. The security server 
is driven by loadable policy rules that define what access is allowed. 
When a subject attempts to interact with an object, for example, a 
process opening a file, a hook in the Linux kernel intercepts the system 
call the process makes to open the file. The hook calls the security 
server to check if access...

[snip]

[1] Smalley, Stephen. 'Re: user guide draft: "Introduction" review'. 
Email to Murray McAllister, 27 August 2008. Any edits were done by 
Murray McAllister.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
