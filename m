Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m837fq2p002854
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 03:41:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m837fqcS012472
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 07:41:52 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m837fp5v022033
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 03:41:51 -0400
Received: from pobox.bne.redhat.com (pobox.bne.redhat.com [10.64.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m837fkr1023537
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 03:41:48 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by pobox.bne.redhat.com (8.13.1/8.13.1) with ESMTP id m837fjJd002706
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 17:41:45 +1000
Message-ID: <48BE3FB4.8020003@redhat.com>
Date: Wed, 03 Sep 2008 17:41:40 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide draft: "Targeted Policy" review
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following is a draft of the "Targeted Policy" sections for the 
SELinux User Guide. Any comments and corrections are appreciated.

Thanks.

Targeted Policy

Targeted policy is the default SELinux policy used in Fedora 10. When 
using targeted policy, subjects that are targeted run in their own 
domain type, and subjects that are not targeted run in the unconfined_t 
domain type. When a subject runs in the unconfined_t domain type, 
SELinux rules do not apply, and only DAC rules are used.

Confined Subjects

A large number of subjects are protected, and are therefore confined by 
the SELinux targeted policy, including the Apache HTTP Server (httpd), 
Samba (samba), FTP (vsftpd), Kerberos (krb5-server), ISC BIND (bind and 
bind-chroot), NFS (nfs-utils), and NIS (ypserv). When a subject is 
confined, it runs in its own domain type, such as the httpd subject 
running in the httpd_t domain type. When a confined subject is 
compromised by an attacker, the damage an attacker can do and the data 
they can access is greatly limited.

The following example demonstrates how SELinux prevents the Apache HTTP 
Server (httpd) from reading files that are not correctly labeled, such 
as files intended for use by another subject. This is an example, and 
should not be used in production. It assumes that the httpd and wget 
packages are installed, that the SELinux targeted policy is used, and 
that SELinux is running in enforcing mode:

1. As the Linux root user, run the touch /var/www/html/testfile command.

2. Run the ls -Z /var/www/html/testfile command to view the SELinux 
context:

-rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 
/var/www/html/testfile

By default, Linux users run unconfined on Fedora 10, which is why the 
testfile file object is labeled with the SELinux unconfined_u user. The 
object_r role is a standard role, and does not affect access control. 
The httpd_sys_content_t file type allows the httpd subject to access 
this object.

[ What is object_r really for? ]

3. As the Linux root user, start the Apache HTTP Server: /sbin/service 
httpd start. When the server has started, change into a directory where 
your Linux user has write access to, and run the wget 
http://localhost/testfile command. Unless there are any changes to the 
default configuration, this command succeeds.

4. The /usr/bin/chcon command relabels files; however, such label 
changes do not survive when the file system is relabeled. For permanent 
changes that survive a file system relabel, use the /usr/sbin/semanage 
command, which is discussed later. As the Linux root user, run the 
/usr/bin/chcon -t samba_share_t /var/www/html/testfile command to change 
the file type, to a file type that is used by Samba. Run the ls -Z 
/var/www/html/testfile command to verify the changes:

[ If a file has an entry in file_contexts, and is relabeled with 
semanage fcontext, does that update 
/etc/selinux/targeted/contexts/files/file_contexts with the change? I 
was going to try, but forgot how to change the file type with semanage]

-rw-r--r--  root root unconfined_u:object_r:samba_share_t:s0 
/var/www/html/testfile

5. Note: the current DAC permissions allow the httpd subject access to 
this file. Change into a directory where your Linux user has write 
access to, and run the wget http://localhost/testfile command. Unless 
there are any changes to the default configuration, this command fails:

HTTP request sent, awaiting response... 403 Forbidden
2008-08-22 03:48:40 ERROR 403: Forbidden.

This example demonstrates the additional security added by SELinux. 
Although the httpd subject had access to the object in step 5, because 
the object was labeled with a file type that httpd subject does not have 
access to, SELinux denied access. After step 5, an error such as the 
following is logged to /var/log/messages:

Aug 22 03:48:40 localhost setroubleshoot: SELinux is preventing httpd 
(httpd_t) "getattr"
to /var/www/html/testfile (samba_share_t). For complete SELinux messages.
run sealert -l c05911d3-e680-4e42-8e36-fe2ab9f8e654

Also, if the audit package is installed and the auditd subject is 
running, a more detailed denial is logged to /var/log/audit/audit.log. 
These denials are discussed later.

Unconfined Subjects

Unconfined subjects run in the unconfined_t domain type. This means that 
SELinux policy rules do not apply, and only DAC permissions are used. 
When an unconfined subject is comprised, an attacker may gain access to 
a large number of system resources and data.

The following example demonstrates how the Apache HTTP Server (httpd) 
can access data intended for use by another subject, when running 
unconfined. Note: on Fedora 10, the httpd subject runs in the confined 
httpd_t domain type by default. This is an example, and should not be 
used in production. It assumes that the httpd and wget packages are 
installed, that the SELinux targeted policy is used, and that SELinux is 
running in enforcing mode:

1. As the Linux root user, run the touch /var/www/html/test2file command.

2. Run the ls -Z /var/www/html/test2file command to view the SELinux 
context:

-rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 
/var/www/html/test2file

By default, Linux users run unconfined on Fedora 10, which is why the 
test2file file object is labeled with the SELinux unconfined_u user. The 
object_r role is a standard role, and does not affect access control. 
The httpd_sys_content_t file type allows the httpd subject to access 
this object.

3. The /usr/bin/chcon command relabels files; however, such label 
changes do not survive when the file system is relabeled. For permanent 
changes that survive a file system relabel, use the /usr/sbin/semanage 
command, which is discussed later. As the Linux root user, run the 
/usr/bin/chcon -t samba_share_t /var/www/html/test2file command to 
change the file type, to a file type that is used by Samba. Run the ls 
-Z /var/www/html/test2file command to verify the changes:

-rw-r--r--  root root unconfined_u:object_r:samba_share_t:s0 
/var/www/html/test2file

4. To simulate the httpd subject running unconfined, run the 
/usr/sbin/setenforce 0 command as the Linux root user to temporarily 
disable SELinux. Confirm SELinux is disabled by running the 
/usr/sbin/getenforce command. When SELinux is disabled, 
/usr/sbin/getenforce returns Permissive:

$ getenforce
Permissive

5. As the Linux root user, start the Apache HTTP Server: /sbin/service 
httpd start. Change into a directory where your Linux user has write 
access to, and run the wget http://localhost/test2file command. Unless 
there are any changes to the default configuration, this command succeeds.

6. Enable SELinux by running /usr/sbin/setenforce 1 command. When 
SELinux is enabled, /usr/sbin/getenforce returns Enforcing:

$ getenforce
Enforcing

The examples in these sections demonstrate how data can be protected 
from a compromised confined-subject (protected by SELinux), as well as 
how data is more accessible to an attacker from a compromised 
unconfined-subject (not protected by SELinux).

Confined and Unconfined User Domains

In progress. Introduction to restrictions on certain domains (user_t, 
guest_t etc).

Are there any SELinux restrictions on what users can do when they run 
unconfined?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
