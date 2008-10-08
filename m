Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m982jnuC019922
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2008 22:45:49 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m982icxi028400
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 02:44:38 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m982jmqQ020613
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2008 22:45:48 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m982jlxe020136
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2008 22:45:48 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m982jiPH011974
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2008 22:45:45 -0400
Message-ID: <48EC1ED7.8040308@redhat.com>
Date: Wed, 08 Oct 2008 12:45:43 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide drafts: Maintaining SELinux Labels 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following are the first few drafts of the "Maintaining SELinux 
Labels" sections. Any comments and corrections are appreciated.

Cheers.

Copying Files and Directories

When files and directories are copied, they inherit the SELinux context 
of the parent directory they are copied to. This helps ensure files and 
directories are labeled with the correct SELinux context after being 
moved. The following example demonstrates copying a file from a user's 
home directory to /var/www/html/, which is used by the Apache HTTP 
Server. Since the file is copied, it inherits the correct SELinux context:

1. Run the cd command without any arguments to change into your home 
directory. Once in your home directory, run the touch file1 command to 
create a file. This file is labeled with the user_home_t type:

$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1

2. Run the ls -dZ /var/www/html/ command to view the SELinux context of 
the /var/www/html/ directory:

$ ls -dZ /var/www/html/
drwxr-xr-x  root root system_u:object_r:httpd_sys_content_t:s0 
/var/www/html/

By default, the /var/www/html/ directory is labeled with the 
httpd_sys_content_t type. Files and directories created under the 
/var/www/html/ directory inherit this type, and as such, they are 
labeled with this type.

3. As the Linux root user, run the cp file1 /var/www/html command to 
copy file1 to the /var/www/html/ directory. Since this file is copied, 
it inherits the httpd_sys_content_t type from the /var/www/html/ directory:

# cp file1 /var/www/html/
# ls -Z /var/www/html/file1
-rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 
/var/www/html/file1

<important note>
Copy files and directories, rather than moving them. This helps ensure 
they are labeled with the correct SELinux contexts. Incorrect SELinux 
contexts can prevent processes from accessing such files and directories.
</important note>

Moving Files and Directories

File and directories keep their current SELinux context when they are 
moved. In many cases, this is incorrect for the location they are being 
moved to. The following example demonstrates moving a file from a user's 
home directory to /var/www/html/, which is used by the Apache HTTP 
Server. Since the file is moved, it does not inherit the correct SELinux 
context:

1. Run the cd command without any arguments to change into your home 
directory. Once in your home directory, run the touch file1 command to 
create a file. This file is labeled with the user_home_t type:

$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1

2. Run the ls -dZ /var/www/html/ command to view the SELinux context of 
the /var/www/html/ directory:

$ ls -dZ /var/www/html/
drwxr-xr-x  root root system_u:object_r:httpd_sys_content_t:s0 
/var/www/html/

By default, the /var/www/html/ directory is labeled with the 
httpd_sys_content_t type. Files and directories created under the 
/var/www/html/ directory inherit this type, and as such, they are 
labeled with this type.

3. As the Linux root user, run the mv file1 /var/www/html command to 
move file1 to the /var/www/html directory. Since this file is moved, it 
keeps its current user_home_t type:

# mv file1 /var/www/html
# ls -Z /var/www/html/file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 
/var/www/html/file1

By default, the Apache HTTP Server can not read files that are labeled 
with the user_home_t type. If all files comprising a web page are 
labeled with the user_home_t type, or another type that the Apache HTTP 
Server can not read, permission is denied when attempting to access them 
via Firefox or text-based Web browsers.

<important note>
Moving files and directories with the mv command may result in the wrong 
SELinux context, preventing processes, such as the Apache HTTP Server 
and Samba, from accessing such files and directories.
</important note>

Checking the Default SELinux Context

Use the /usr/sbin/matchpathcon command to check if files and directories 
have the correct SELinux context. From the matchpathcon(8) manual page: 
"matchpathcon queries the system policy and outputs the default security 
context associated with the file path."[1]. The following example 
demonstrates using the /usr/sbin/matchpathcon command to verify that 
files in /var/www/html/ directory are labeled correctly:

1. As the Linux root user, run the touch /var/www/html/file{1,2,3} 
command to create three files (file1, file2, and file3). These files 
inherit the httpd_sys_content_t type from the /var/www/html/ directory:

# touch /var/www/html/file{1,2,3}
# ls -Z /var/www/html/
-rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 file1
-rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 file2
-rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 file3

2. As the Linux root user, run the chcon -t samba_share_t 
/var/www/html/file1 command to change the file1 type to samba_share_t. 
Note: the Apache HTTP Server can not read files or directories labeled 
with the samba_share_t type.

3. The /usr/sbin/matchpathcon -V option compares the current SELinux 
context to the correct, default context in SELinux policy. Run the 
/usr/sbin/matchpathcon -V /var/www/html/* command to check all files in 
the /var/www/html/ directory:

$ /usr/sbin/matchpathcon -V /var/www/html/*
/var/www/html/file1 has context unconfined_u:object_r:samba_share_t:s0, 
should be system_u:object_r:httpd_sys_content_t:s0
/var/www/html/file2 verified.
/var/www/html/file3 verified.

The following output from the /usr/sbin/matchpathcon command explains 
that file1 is labeled with the samba_share_t type, but should be labeled 
with the httpd_sys_content_t type:

/var/www/html/file1 has context unconfined_u:object_r:samba_share_t:s0, 
should be system_u:object_r:httpd_sys_content_t:s0

To resolve the label problem and allow the Apache HTTP Server access to 
file1, as the Linux root user, run the /sbin/restorecon -v 
/var/www/html/file1 command:

# /sbin/restorecon -v /var/www/html/file1
restorecon reset /var/www/html/file1 context 
unconfined_u:object_r:samba_share_t:s0->system_u:object_r:httpd_sys_content_t:s0


[1] The matchpathcon(8) manual page, as shipped with the 
libselinux-utils package in Fedora, is written by Daniel Walsh. Any 
edits or changes in this version were done by Murray McAllister.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
