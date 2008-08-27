Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48B4FA3E.3000602@redhat.com>
References: <48B4FA3E.3000602@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 27 Aug 2008 09:47:16 -0400
Message-Id: <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-08-27 at 16:54 +1000, Murray McAllister wrote:
> Hi,
> 
> The following is a draft of the SELinux Contexts and Attributes sections 
> for the SELinux User Guide. Any comments and corrections are appreciated.
> 
> Thanks.
> 
> As previously mentioned, on Linux operating systems, files, directories, 
> sockets, devices, and so on, are called objects, and processes, such as 
> a user running a command, the Firefox application, and the Apache HTTP 
> Server, are called subjects.

As before, this is generally true of operating systems not just Linux.

>  SELinux provides the Type Enforcement 
> security model.

SELinux provides flexible MAC that can support many different security
models, and the example security server included in SELinux provides a
combination of role-based access control (RBAC), Type Enforcement (TE),
and optionally Multi-Level Security (MLS).

>  To enforce this, subjects and objects are labeled with 
> an SELinux context that contains additional information, such as an 
> SELinux user, role, and type. When running SELinux, all of this 
> information is used to make access control decisions.
> 
> The following is an example of the additional SELinux information used 
> on Linux operating systems that use SELinux. This information is called 
> the SELinux context, and is viewed using the ls -Z command:
> 
> -rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1
> 
> SELinux contexts follow the SELinux user:role:type:category syntax:

That should be :level or :range rather than just :category, where a
level is a sensitivity followed by an optional list of categories.

> SELinux user: The SELinux user identity is an identity known to the 
> policy that is authorized for a specific set of roles and for a specific 
> MLS range. Each Linux user account is mapped to an SELinux user identity 
> when a user login session is created, and the mapped SELinux user 
> identity is used in the security context for processes in that session 
> in order to bound what roles and levels they can enter[1]. Run the 
> /usr/sbin/semanage login -l command to view a list of mappings between 
> SELinux and Linux user accounts:
> 
> Login Name                SELinux User              MLS/MCS Range
> 
> __default__               unconfined_u              s0-s0:c0.c1023
> root                      unconfined_u              s0-s0:c0.c1023
> system_u                  system_u                  s0-s0:c0.c1023
> test2user                 user_u                    s0
> xguest                    xguest_u                  s0
> 
> Output may differ from system to system. The Login Name column lists 
> Linux users, and the the SELinux User column lists which SELinux user is 
> mapped to which Linux user. The SELinux user does not restrict the 
> access subjects have to objects.

Well, it does indirectly, by limiting what roles and levels are
accessible to the subject.  It also can play a role in the constraints
portion of the policy configuration, e.g. refpolicy doesn't allow a
process to relabel a file with a different SELinux user identity unless
its domain has the can_change_object_identity attribute.

>  The last column, MLS/MCS Range, are 
> categories that are used by Multi-Level Security (MLS) and 
> Mutli-Category Security (MCS). MLS and MCS categories are discussed 
> briefly later.
> 
> role: Part of SELinux is the Role Based Access Control (RBAC) security 
> model. The role is an attribute of RBAC. Roles are associated with 
> domain types, and domain types are associated with SELinux users.

SELinux users are authorized for roles, and roles are authorized for
domain types.  Domain types are not directly associated with SELinux
users - the role serves as an intermediary.

>  Roles 
> are important when writing policies, as they restrict domain 
> transitions, but they do not restrict the access subjects have to 
> objects, and as such, they are not discussed in detail in this guide.

Not directly, but indirectly since what roles you can enter determines
what domain types you can enter and thus ultimately what object types
you can access.  The role is a coarse-grained boundary on privilege
escalation.

> type: The type is an attribute of Type Enforcement. The type defines a 
> domain type for subjects, and a type for objects. SELinux policy rules 
> define how types access each other, whether it be a domain accessing a 
> type, or a domain accessing another domain. Access is only allowed if a 
> specific rule exists that allows it.
> 
> category: The category is an attribute of Multi-Level Security (MLS) and 
> Multi-Category Security (MCS). Categories are used to categorize data, 
> and identify its sensitivity or security level. Standard SELinux policy 
> supports MCS; however, it is not heavily used. MCS allows users, at 
> their own discretion, to add a category to a piece of data, for example, 
> PatientRecord or CompanyConfidential. There is only a single security 
> level, s0. MLS labels data with both categories (CompanyConfidential) 
> and a sensitivity level. MLS enforces the Bell-LaPadula Mandatory Access 
> Model, and is used in Labeled Security Protection Profile (LSPP) 
> environments.

Again, this should be level or range rather than just category, where a
level is a sensitivity and an optional list of categories and a range is
a current/low level and a clearance/high level.  You may wish to note
that people who wish to use the MLS restrictions need to install a
separate -mls policy package and make it the default.

> Domain Transitions
> 
> On Linux operating systems that run SELinux, processes, such as a user 
> running the less command, or an Apache HTTP server, are called subjects. 

Not sure you need to keep repeating this.

> An executable object transitions to a subject, and a subject runs in a 
> domain. This transition is called a domain transition.

A process in one domain transitions to another domain by executing a new
program with the entrypoint type for the new domain.

>  The following 
> example demonstrates a domain transition:
> 
> 1. A users wants to change their password. To change their password, 
> they run the /usr/bin/passwd command. The /usr/bin/passwd file object is 
> labeled with the passwd_exec_t file type:
> 
> $ ls -Z /usr/bin/passwd
> -rwsr-xr-x  root root system_u:object_r:passwd_exec_t:s0 /usr/bin/passwd
> 
> The passwd application needs to access the /etc/shadow object, which is 
> labeled with the shadow_t file type:
> 
> $ ls -Z /etc/shadow
> -r--------  root root system_u:object_r:shadow_t:s0    /etc/shadow
> 
> 2. An SELinux policy rule states that subjects running in the passwd_t 
> domain type are allowed to read and write to objects that are labeled 
> with the shadow_t file type. The /etc/shadow object is the only object 
> that is labeled with the shadow_t file type.

Also /etc/gshadow.  And the backup copies of both files created whenever
they are updated (e.g. /etc/shadow-).  And any intermediate files
created during the update transaction that contain any shadow password
data - the point is that any file containing such data ought to be
labeled with the shadow_t type so that it can be consistently protected
throughout.

> 3. When a user runs the /usr/bin/passwd command, the application 
> transitions to a subject (a process), which is running in the passwd_t 
> domain type.

The user shell process transitions to the passwd_t domain upon executing
the /usr/bin/passwd command.

>  With SELinux, since the default action is to deny, and a 
> rule exists that allows (among other things) applications running in the 
> passwd_t domain type to access objects labeled with the shadow_t file 
> type, the passwd application is allowed to access /etc/shadow, and 
> update the user's password.
> 
> This example is not exhaustive, and is used as a basic example to 
> explain domain transition. Although there is an actual rule that allows 
> subjects running in the passwd_t domain type to access objects labeled 
> with the shadow_t file type, other rules must be met before the object 
> can successfully transition.

Not sure what you mean by "the object can successfully transition" -
processes transition from one domain to another upon executing a new
program.

In the passwd example, the guarantees we are getting from Type
Enforcement are:
- Only authorized domains (e.g. passwd_t) can write to shadow password
data (shadow_t).  Other processes, even superuser ones, cannot do so.
- The passwd_t domain can only be entered by executing a program labeled
with passwd_exec_t, can only execute from authorized shared libraries
(e.g. lib_t) and cannot execute any other programs.  Thus, we can have
some confidence that only authorized code is ever executed in passwd_t.
- Only authorized domains (e.g. user_t) can transition to passwd_t.
Thus, a daemon like sendmail_t that has no legitimate reason to ever run
passwd cannot ever reach passwd_t.
- passwd_t can only read and write authorized types (e.g. etc_t,
shadow_t).  Thus, it cannot be tricked into reading or writing arbitrary
files.

> SELinux Contexts for Subjects
> 
> On Linux operating systems the run SELinux, when an application is 
> executed, that application transitions to a subject and runs in a 
> domain.

Again, not sure you need to keep repeating this, and technically it is
"the process transitions to a new domain upon executing a program with
the entrypoint type for that domain".

>  The SELinux context for subjects is viewed using the pstree -Z 
> command.

Or just ps -eZ.

>  For example:
> 
> 1. Open a terminal, such as Applications → System Tools → Terminal.
> 
> 2. Run the /usr/bin/passwd command. Do not enter a new password.
> 
> 3. Open a new tab, or another terminal, and run the pstree -Z | grep 
> passwd command. The output is similar to the following:
> 
> |  |        `-passwd(`unconfined_u:unconfined_r:passwd_t:s0-s0:c0.c1023')
> 
> 4. In the first tab, cancel passwd application.
> 
> In this example, when the /usr/bin/passwd object, which is labeled with 
> the passwd_exec_t file type, is executed, it transitions to a subject 
> that runs in the passwd_t domain type. Remember: the type defines a 
> domain type for subjects, and a type for objects.
> 
> To view the SELinux contexts for all subjects, run the pstree -Z 
> command. The following is an example of the pstree -Z output, and may 
> differ on your system:
> 
> ├─NetworkManager(`system_u:system_r:NetworkManager_t:s0')
> │  └─{NetworkManager}(`system_u:system_r:NetworkManager_t:s0')
> ├─acpid(`system_u:system_r:apmd_t:s0')
> ├─anacron(`system_u:system_r:system_crond_t:s0')
> ├─atd(`system_u:system_r:crond_t:s0-s0:c0.c1023')
> ├─auditd(`system_u:system_r:auditd_t:s0')
> 
> 
> By default, the SELinux targeted policy is used. When using targeted 
> policy, most subjects (processes) use the system_r role. Type 
> enforcement then separates each domain.

system_r is for system processes like daemons.  Targeted policy used to
use system_r for everything and not use any user roles.  In F9, it uses
unconfined_r for unconfined users.

> Run the id command to view the SELinux context associated with your 
> Linux user:
> 
> uid=500(user) gid=500(group) groups=500(group) 
> context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> 
> On Fedora 10, Linux users run unconfined by default. This SELinux 
> context shows that the Linux user is mapped to the SELinux unconfined_u 
> user, running as the unconfined_r role, and is running in the 
> unconfined_t domain type. SELinux rules do not affect Linux users that 
> are running in the unconfined_t domain type; however, UNIX permissions 
> still apply.
> 
> 
> [1] Smalley, Stephen. "Re: SELinux User Guide: weekly report 20080822". 
> Email to Murray McAllister, 25 August 2008. Any edits were done by 
> Murray McAllister.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
