Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m83B43Wu014010
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 07:04:03 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m83B3P7O012186
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 11:03:27 GMT
Date: Wed, 3 Sep 2008 21:03:49 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Murray McAllister <mmcallis@redhat.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Targeted Policy" review
In-Reply-To: <48BE3FB4.8020003@redhat.com>
Message-ID: <alpine.LRH.1.10.0809032046530.20640@tundra.namei.org>
References: <48BE3FB4.8020003@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Sep 2008, Murray McAllister wrote:

> subjects that are not targeted run in the unconfined_t domain type. When a
> subject runs in the unconfined_t domain type, SELinux rules do not apply, and
> only DAC rules are used.

I think we should keep trying to reduce the amount of jargon for users.  
e.g. can "domain type" be reduced to "domain" or even "label" ?

> A large number of subjects are protected, and are therefore confined by the
> SELinux targeted policy, including the Apache HTTP Server (httpd), Samba
> (samba), FTP (vsftpd), Kerberos (krb5-server), ISC BIND (bind and
> bind-chroot), NFS (nfs-utils), and NIS (ypserv). When a subject is confined,
> it runs in its own domain type, such as the httpd subject running in the
> httpd_t domain type. When a confined subject is compromised by an attacker,
> the damage an attacker can do and the data they can access is greatly limited.

I think the above could be clarified more in terms of cause and effect, 
e.g. the extent of damage is limited because the attacker's access to 
resources is limited.

> 
> The following example demonstrates how SELinux prevents the Apache HTTP Server
> (httpd) from reading files that are not correctly labeled, such as files
> intended for use by another subject. This is an example, and should not be
> used in production. It assumes that the httpd and wget packages are installed,
> that the SELinux targeted policy is used, and that SELinux is running in
> enforcing mode:
> 
> 1. As the Linux root user, run the touch /var/www/html/testfile command.
> 
> 2. Run the ls -Z /var/www/html/testfile command to view the SELinux context:
> 
> -rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0
> /var/www/html/testfile
> 
> By default, Linux users run unconfined on Fedora 10, which is why the testfile
> file object is labeled with the SELinux unconfined_u user. The object_r role
> is a standard role, and does not affect access control. The
> httpd_sys_content_t file type allows the httpd subject to access this object.
> 
> [ What is object_r really for? ]

Roles don't have any meaning for objects (at least, in this 
implementation), so object_r is just a default value for objects.


> 3. As the Linux root user, start the Apache HTTP Server: /sbin/service httpd
> start. When the server has started, change into a directory where your Linux
> user has write access to, and run the wget http://localhost/testfile command.
> Unless there are any changes to the default configuration, this command
> succeeds.

I think it would be useful to show the sequence of commands and the 
output, e.g. what the user would see.

> file. Change into a directory where your Linux user has write access to, and
> run the wget http://localhost/testfile command. Unless there are any changes
> to the default configuration, this command fails:
> 
> HTTP request sent, awaiting response... 403 Forbidden
> 2008-08-22 03:48:40 ERROR 403: Forbidden.

Perhaps also show the httpd error log entry.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
