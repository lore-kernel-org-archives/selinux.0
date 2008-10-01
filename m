Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m917JccJ019542
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 03:19:38 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m917ITF1013438
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 07:18:34 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m917JTbn007357
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 03:19:29 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m917JRVc024380
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 03:19:28 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m917JPB5029951
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 03:19:26 -0400
Message-ID: <48E3247C.7070000@redhat.com>
Date: Wed, 01 Oct 2008 17:19:24 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide drafts: SELinux Modes, Booleans, SELinux Contexts - Labeling
 Files
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following are drafts for the "SELinux Modes", "Booleans", and 
"SELinux Contexts - Labeling Files" sections. These follow on after the 
enabling and disabling sections. Any comments and corrections are 
appreciated.

I have not read through these properly yet, so please excuse the 
spelling mistakes - I wanted to make sure it technically accurate...

Thanks.

SELinux Modes

SELinux has three modes:

* Enforcing: SELinux policy is enforced. SELinux denies access based on 
SELinux policy rules.

* Permissive: SELinux policy is not enforced. SELinux does not deny 
access, but denials are logged for actions that would have been denied 
if running SELinux in enforcing mode.

* Disabled: SELinux is disabled. Only DAC rules are used.

Use the setenforce command to change between enforcing and permissive 
mode. Changes made with setenforce do not persist across reboots. To 
change to enforcing mode, as the Linux root user, run the setenforce 1 
command. To change to permissive mode, run the setenforce 0 command. Use 
the getenforce command to view the current SELinux mode.

Persistent mode changes were covered in Section 5.3, “Enabling and 
Disabling SELinux”.

Booleans

Booleans allow parts of SELinux policy to be changed at runtime, without 
any knowledge of SELinux policy writing. This allows changes, such as 
allowing daemons to access user home directories, without reloading or 
recompiling SELinux policy.

Listing Booleans

For a list of Booleans, an explanation of what each one is, and whether 
it is on or off, as the Linux root user, run the semanage boolean -l 
command. The following example does not list all Booleans:

[example output]

The SELinux boolean column lists Boolean names. The Description column 
lists whether the Booleans are on or off, and what they do.

ftp_home_dir                   -> off   Allow ftp to read and write 
files in the user home directories

In this example, the ftp_home_dir Boolean is off, preventing vsftpd from 
reading and writing to files in user home directories.

The getsebool -a command lists Booleans, whether they are on or off, but 
does not give a description of each one. The following example does not 
list all Booleans:

[example output]

Run the getsebool boolean-name command to only list the status of the 
boolean-name Boolean:

$ getsebool allow_console_login
allow_console_login --> off

Use a space-separated list to list multiple Booleans:

$ getsebool allow_console_login allow_cvs_read_shadow 
allow_daemons_dump_core
allow_console_login --> off
allow_cvs_read_shadow --> off
allow_daemons_dump_core --> on

Configuring Booleans

The setsebool boolean-name=x command turns Booleans on or off, where 
boolean-name is a Boolean name, and x is either on to turn the Boolean 
on, or off to turn it off.

The following example demonstrates configuring the 
httpd_can_network_connect_db Boolean:

1. By default, the httpd_can_network_connect_db Boolean is off, 
preventing Apache HTTP Server scripts and modules from connecting to 
database servers:

$ getsebool httpd_can_network_connect_db
httpd_can_network_connect_db --> off

2. To temporarily enable scripts and modules to connect to database 
servers, as the Linux root user, run the setsebool 
httpd_can_network_connect_db=on command.

3. Use the getsebool command to verify that the Boolean is turned on:

$ getsebool httpd_can_network_connect_db
httpd_can_network_connect_db --> on

This allows Apache HTTP Server scripts and modules to connect to 
database servers.

4. This change is not persistent across reboots. To make changes 
persistent across reboots, as the Linux root user, run the setsebool -P 
boolean-name=on command. For example:

# setsebool -P httpd_can_network_connect_db=on

5. To temporarily revert to the default behavior, as the Linux root 
user, run the setsebool httpd_can_network_connect_db=off command. For 
changes that persist across reboots, run the setsebool -P 
httpd_can_network_connect_db=off command (which prevents scripts and 
modules from connecting to database servers).

SELinux Contexts - Labeling Files

On systems running SELinux, all processes and files are labeled with a 
label that contains security-relevant information. This information is 
called the SELinux context. For files, this is viewed using the ls -Z 
command:

$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1

In this example, SELinux provides a user (unconfined_u), a role 
(object_r), a type (user_home_t), and a level (s0). This information is 
used to make access control decisions. On DAC systems, access is 
controlled based on Linux user and group IDs. SELinux policy rules are 
checked after DAC rules. SELinux policy rules are not used if DAC rules 
deny access first.

There are multiple commands for managing the SELinux context for files, 
such as chcon, semanage fcontext, and restorecon.

Temporary Changes: chcon

The chcon command changes the SELinux context for files. These changes, 
however, are removed if the file system is relabeled. SELinux policy 
controls whether users are able to modify the SELinux context for any 
given file. When using chcon, users provide all or part of the SELinux 
context to change. An incorrect file type is a common cause for SELinux 
denying access.

Quick Reference

* Run the chcon -t type file-name command to change the file type, where 
type is a type, such as httpd_sys_content_t, and file-name is a file or 
directory name.

* Run the chcon -R -t type directory-name command to change the type of 
the directory and its contents, where type is a type, such as 
httpd_sys_content_t, and directory-name is a directory name.

Changing a File's or Directory's Type

The following example demonstrates changing the type, and no other 
attributes of the SELinux context:

1. Run the cd command without arguments to change into your home directory.

2. Run the touch file1 command to create a new file. Use the ls -Z file1 
command to view the SELinux context for file1:

$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1

In this example, the SELinux context for file1 includes the SELinux 
unconfined_u user, object_r role, user_home_t type, and the s0 level. 
For a description of each part of the SELinux context, refer to Chapter 
3, SELinux Contexts.

3. Run the chcon -t samba_share_t file1 command to change the type to 
samba_share_t. The -t option only changes the type. View the change with 
ls -Z file1:

$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:samba_share_t:s0 file1

4. Use the restorecon command to restore the SELinux context for the 
file1 file. Use the -v option to view what changes:

$ restorecon -v file1
restorecon reset file1 context 
system_u:object_r:samba_share_t:s0->system_u:object_r:user_home_t:s0

In this example, the previous type, samba_share_t, is restored to the 
correct, user_home_t type. When using targeted policy (the default 
SELinux policy in Fedora 10), the restorecon command reads the files in 
the /etc/selinux/targeted/contexts/files/ directory, to see which 
SELinux context files should have.

The example in this section works the same for directories, for example, 
if file1 was a directory.

Changing a Directory and its Contents Types

The same as above but using the chcon -R option.

For information about other chcon options, such as -u to change the 
SELinux user, and -r to change the role, refer to the chcon(1) manual page.

Persistent Changes: semanage fcontext

The semanage fcontext command changes the SELinux context for files. 
When using targeted policy, changes made with this command are added to 
the /etc/selinux/targeted/contexts/files/file_contexts file if the 
changes are to files that exists in file_contexts, or are added to 
file_contexts.local for new files and directories, such as creating a 
/web/ directory. setfiles, which is used when a file system is 
relabeled, and restorecon, which restores the default SELinux contexts, 
read these files. This means that changes made by semanage fcontext are 
persistent, even if the file system is relabeled. SELinux policy 
controls whether users are able to modify the SELinux context for any 
given file.

Quick Reference

To make SELinux context changes that survive a file system relabel:

1. Run the semanage fcontext -a options file-name|directory-name 
command, remembering to use the full path to the file or directory.

2. Run the restorecon file-name|directory-name command to apply the 
context changes.

Changing a File's Context

The following example demonstrates changing a file's type, and no other 
attributes of the SELinux context:

1. As the Linux root user, run the touch /etc/file1 command to create a 
new file. By default, newly-created files in the /etc/ directory are 
labeled with the etc_t type:

# ls -Z /etc/file1
-rw-r--r--  root root system_u:object_r:etc_t:s0       /etc/file1

2. As the Linux root user, run the semanage fcontext -a -t samba_share_t 
/etc/file1 command to change the file1 type to samba_share_t. The -a 
option adds a new record, and the -t option defines the type 
(samba_share_t). Note: running this command does not directly change the 
type - file1 is still labeled with the etc_t type:

# semanage fcontext -a -t samba_share_t /etc/file1
# ls -Z /etc/file1
-rw-r--r--  root root system_u:object_r:etc_t:s0       /etc/file1

The semanage fcontext -a -t samba_share_t /etc/file1 command adds the 
following entry to 
/etc/selinux/targeted/contexts/files/file_contexts.local:

/etc/file1    system_u:object_r:samba_share_t:s0

3. As the Linux root user, run the restorecon -v /etc/file1 command to 
change the type. Since the semanage command added an entry to 
file.contexts.local for /etc/file1, the restorecon command changes the 
type to samba_share_t:

# restorecon -v /etc/file1
restorecon reset /etc/file1 context 
system_u:object_r:etc_t:s0->system_u:object_r:samba_share_t:s0

Changing a Directory's Context

same as above

Changing a Directory and its Contents Contexts

example using /web instead of /var/www/ for Apache (similar to above).

Deleting an added Context

The following example demonstrates adding an SELinux context and then 
removing it:

1. As the Linux root user, run the semanage fcontext -a -t 
httpd_sys_content_t /test command. The /test/ directory does not have to 
exist. This command adds the following context to 
/etc/selinux/targeted/contexts/files/file_contexts.local:

/test    system_u:object_r:httpd_sys_content_t:s0

2. To remove the context, as the Linux root user, run the semanage 
fcontext -d file-name|directory-name command, where 
file-name|directory-name is the first part in file_contexts.local. The 
following is an example of a context in file_contexts.local:

/test    system_u:object_r:httpd_sys_content_t:s0

To prevent the /test/ directory from being labeled with the 
httpd_sys_content_t after running restorecon, or after a file system 
relabel, run the following command as the Linux root user to delete the 
context from file_contexts.local:

semanage fcontext -d /web

If the context is part of a regular expression, for example, /web(/.*)?, 
use quotation marks around the regular expression:

semanage fcontext -d "/web(/.*)?"

For information about other semanage fcontext options, such as -s to 
change the SELinux user, refer to the semanage(8) manual page.

<note>
When changing the SELinux context with semanage fcontext -a, use the 
full path to the file or directory to avoid files being mislabeled after 
a file system relabel, or after the restorecon command is run.
</note>

Cheers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
