Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85DnvnQ020178
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:49:57 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m85Dnu0F029252
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 13:49:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m85DnuiL008965
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:49:56 -0400
Message-ID: <48C13900.8050401@redhat.com>
Date: Fri, 05 Sep 2008 09:49:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Targeted Policy" review
References: <48BE3FB4.8020003@redhat.com> <48BE9106.6050703@redhat.com> <48C0D4CD.5090908@redhat.com>
In-Reply-To: <48C0D4CD.5090908@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Daniel J Walsh wrote:
> Murray McAllister wrote:
>>>> Hi,
>>>>
>>>> The following is a draft of the "Targeted Policy" sections for the
>>>> SELinux User Guide. Any comments and corrections are appreciated.
>>>>
>>>> Thanks.
>>>>
>>>> Targeted Policy
>>>>
>>>> Targeted policy is the default SELinux policy used in Fedora 10. When
>>>> using targeted policy, subjects that are targeted run in their own
>>>> domain type, and subjects that are not targeted run in the unconfined_t
> confined domain, and subjects that are not targeted run in an unconfined
> domain,  For example logged in users by default log in as unconfined_t
> while system processes started by init run in initrc_t.  Both of these
> domains are unconfined.
> 
> NOTE:
> 
> Even unconfined domains are subject to executable/writable memory
> checks.  execmem, execstack, execheap.  By default processes run as an
> unconfined domain can not allocate writeable memory and execute it.
> This is a common attack vector call buffer overflow attacks.  Some
> applications require this type of access (java, wine, mono and a few
> others). 
> 
>> Does this mean applications running in a Java Virtual Machine, and in Wine?
> 
>> I'll change my response below based on the answer to this.
Yes
> 
>> These applications need to be labeled correctly to allow the
> access.  There are booleans that can turn off this protection for the
> unconfined user unconfined_t.  allow_execmem, allow_execstack,
> allow_execheap.
> 
> You can turn the booleans on using setsebool
> 
> setsebool -P allow_execmem 1
> 
>> I will use these examples later on.
> 
> 
>> How about:
> 
>> Targeted policy is the default SELinux policy used in Fedora 10. When
>> using targeted policy, subjects that are targeted run in a confined
>> domain, and subjects that are not targeted run in an unconfined domain.
>> For example, by default, logged in users run in the unconfined_t domain,
>> and system processes started by init run in the initrc_t domain - both
>> of these domains are unconfined.
> 
>> Unconfined domains (as well as confined domains) are subject to
>> executable and writeable memory checks. By default, subjects running in
>> an unconfined domain can not allocate writeable memory and execute it.
> 
>> [I think I changed the meaning. Is it still correct? ]
Looks good
> 
>> This reduces vulnerability to buffer overflow attacks. Some subjects
>> require this access, including but not limited to Java", Wine and Mono.
>> To allow this access, these subjects must be labeled correctly.

For example, if you had a java application /usr/local/bin/myjavaapp,
that was not working because it needed the execmem access, you could
change the system labeling.
# semanage fcontext -a -t java_exec_t /usr/local/bin/myjavaapp
Then you fix the context on the actual file
# restorecon /usr/local/bin/myjavaapp

myjavaapp will now be allowed to run with execmem and execstack.

If you do not want to deal with any of the memory checks for users, you
can disable them with by setting the allow_exec* booleans.

# setsebool -P allow_execmem=1 allow_execstack=1 allow_execheap=1
You can check if the booleans current state by executing

getsebool -a | grep allow_exec

You system is most protected if these booleans are turned off.

# setsebool -P allow_execmem=0 allow_execstack=0 allow_execheap=0

>> memory checks need to be disabled for the users running in the
>> unconfined_t domain. 
No this sentence is wrong.
These memory checks are disable by setting
>> booleans, which allow the SELinux policy to be modified during runtime.
>> Configuring booleans is discussed later.
> 
> 


>>>> domain type. When a subject runs in the unconfined_t domain type,
> 
>>>> SELinux rules do not apply, and only DAC rules are used.
>>>>
>>>> Confined Subjects
>>>>
>>>> large number of subjects are protected, and are therefore confined by
> Greater then 200, subjects are not protected they are confined.  IE A
> subject could still be compromized but other processes on the system are
> protected from the confined process.
>>>> the SELinux targeted policy, including the Apache HTTP Server (httpd),
>>>> Samba (samba), FTP (vsftpd), Kerberos (krb5-server), ISC BIND (bind and
>>>> bind-chroot), NFS (nfs-utils), and NIS (ypserv). 
> This is an old RHEL4 list.  Almost every domain that listens to the
> internet is now confined.  And most processes that run as root and do
> stuff for users are confined.
> When a subject is
>>>> confined, it runs in its own domain type, such as the httpd subject
>>>> running in the httpd_t domain type. When a confined subject is
>>>> compromised by an attacker, the damage an attacker can do and the data
>>>> they can access is greatly limited.
> 
>> How about:
> 
>> Almost every subject that has network access is confined in Fedora 10.
>> Most subjects that run as the Linux root user and perform tasks for
>> users, such as the passwd application, are confined. 
DBUS/Hal are good examples also.
When a subject is
>> confined, it runs in its own domain, such as the httpd subject running
>> in the httpd_t domain. When a confined subject is compromised by an
>> attacker, depending on SELinux policy configuration, the attacker's
>> access is to resources and the possible damage they can do is limited.
> 
Good
>>>>
>>>> The following example demonstrates how SELinux prevents the Apache HTTP
>>>> Server (httpd) from reading files that are not correctly labeled, such
>>>> as files intended for use by another subject. This is an example, and
>>>> should not be used in production. It assumes that the httpd and wget
>>>> packages are installed, that the SELinux targeted policy is used, and
>>>> that SELinux is running in enforcing mode:
>>>>
>>>> 1. As the Linux root user, run the touch /var/www/html/testfile command.
>>>>
>>>> 2. Run the ls -Z /var/www/html/testfile command to view the SELinux
>>>> context:
>>>>
>>>> -rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0
>>>> /var/www/html/testfile
>>>>
> Make sure the machine is in enforcing mode, setenforce 1.
> 
>> I am adding more steps and example output.
> 
>>>> By default, Linux users run unconfined on Fedora 10, which is why the
>>>> testfile file object is labeled with the SELinux unconfined_u user. The
>>>> object_r role is a standard role, and does not affect access control.
>>>> The httpd_sys_content_t file type allows the httpd subject to access
>>>> this object.
>>>>
>>>> [ What is object_r really for? ]
> Not used on objects so it is just the default.
>>>> 3. As the Linux root user, start the Apache HTTP Server: /sbin/service
>>>> httpd start. When the server has started, change into a directory where
>>>> your Linux user has write access to, and run the wget
>>>> http://localhost/testfile command. Unless there are any changes to the
>>>> default configuration, this command succeeds.
>>>>
>>>> 4. The /usr/bin/chcon command relabels files; however, such label
>>>> changes do not survive when the file system is relabeled. For permanent
>>>> changes that survive a file system relabel, use the /usr/sbin/semanage
>>>> command, which is discussed later. As the Linux root user, run the
>>>> /usr/bin/chcon -t samba_share_t /var/www/html/testfile command to change
>>>> the file type, to a file type that is used by Samba. Run the ls -Z
>>>> /var/www/html/testfile command to verify the changes:
>>>>
>>>> [ If a file has an entry in file_contexts, and is relabeled with
>>>> semanage fcontext, does that update
>>>> /etc/selinux/targeted/contexts/files/file_contexts with the change? I
>>>> was going to try, but forgot how to change the file type with semanage]
>>>>
> Yes it will update /etc/selinux/targeted/contexts/files/file_contexts
>>>> -rw-r--r--  root root unconfined_u:object_r:samba_share_t:s0
>>>> /var/www/html/testfile
>>>>
>>>> 5. Note: the current DAC permissions allow the httpd subject access to
>>>> this file. Change into a directory where your Linux user has write
>>>> access to, and run the wget http://localhost/testfile command. Unless
>>>> there are any changes to the default configuration, this command fails:
>>>>
>>>> HTTP request sent, awaiting response... 403 Forbidden
>>>> 2008-08-22 03:48:40 ERROR 403: Forbidden.
>>>>
>>>> This example demonstrates the additional security added by SELinux.
>>>> Although the httpd subject had access to the object in step 5, because
>>>> the object was labeled with a file type that httpd subject does not have
>>>> access to, SELinux denied access. After step 5, an error such as the
>>>> following is logged to /var/log/messages:
>>>>
>>>> Aug 22 03:48:40 localhost setroubleshoot: SELinux is preventing httpd
>>>> (httpd_t) "getattr"
>>>> to /var/www/html/testfile (samba_share_t). For complete SELinux
>>>> messages.
>>>> run sealert -l c05911d3-e680-4e42-8e36-fe2ab9f8e654
>>>>
> setroubleshoot requires audit subsystem to be running.
>>>> Also, if the audit package is installed and the auditd subject is
>>>> running, a more detailed denial is logged to /var/log/audit/audit.log.
>>>> These denials are discussed later.
>>>>
>>>> Unconfined Subjects
>>>>
>>>> Unconfined subjects run in the unconfined_t domain type. This means that
> Unconfined subjects run in the unconfined domain. This means that
>>>> SELinux policy rules do not apply, and only DAC permissions are used.
>>>> When an unconfined subject is comprised, an attacker may gain access to
>>>> a large number of system resources and data.
>>>>
> I think this would be better stated:
> 
> If an unconfined subject is compromized, SELinux will not prevent the
> attacker from gaining access to system resources and data, the system
> will still have DAC protection.
> 
>> How about:
> 
>> When an unconfined subject is comprised, SELinux does not prevent the
>> attacker from gaining access to system resources and data, and DAC rules
>> are used.
> 
>> (I should probably change these to "If an...")
> 
If an unconfined subject is comprised, SELinux does not prevent the
attacker from gaining access to system resources and data, of course DAC
rules are used.

Note: A common misconception about SELinux is that it replaces DAC
Controls, when it really just augments them.
> 
>>>> The following example demonstrates how the Apache HTTP Server (httpd)
>>>> can access data intended for use by another subject, when running
>>>> unconfined. Note: on Fedora 10, the httpd subject runs in the confined
>>>> httpd_t domain type by default. This is an example, and should not be
>>>> used in production. It assumes that the httpd and wget packages are
>>>> installed, that the SELinux targeted policy is used, and that SELinux is
>>>> running in enforcing mode:
>>>>
>>>> 1. As the Linux root user, run the touch /var/www/html/test2file
>>>> command.
>>>>
>>>> 2. Run the ls -Z /var/www/html/test2file command to view the SELinux
>>>> context:
>>>>
>>>> -rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0
>>>> /var/www/html/test2file
>>>>
>>>> By default, Linux users run unconfined on Fedora 10, which is why the
>>>> test2file file object is labeled with the SELinux unconfined_u user. The
>>>> object_r role is a standard role, and does not affect access control.
>>>> The httpd_sys_content_t file type allows the httpd subject to access
>>>> this object.
>>>>
>>>> 3. The /usr/bin/chcon command relabels files; however, such label
>>>> changes do not survive when the file system is relabeled. For permanent
>>>> changes that survive a file system relabel, use the /usr/sbin/semanage
>>>> command, which is discussed later. As the Linux root user, run the
>>>> /usr/bin/chcon -t samba_share_t /var/www/html/test2file command to
>>>> change the file type, to a file type that is used by Samba. Run the ls
>>>> -Z /var/www/html/test2file command to verify the changes:
>>>>
>>>> -rw-r--r--  root root unconfined_u:object_r:samba_share_t:s0
>>>> /var/www/html/test2file
>>>>
>>>> 4. To simulate the httpd subject running unconfined, run the
>>>> /usr/sbin/setenforce 0 command as the Linux root user to temporarily
>>>> disable SELinux. Confirm SELinux is disabled by running the
>>>> /usr/sbin/getenforce command. When SELinux is disabled,
>>>> /usr/sbin/getenforce returns Permissive:
>>>>
>>>> $ getenforce
>>>> Permissive
>>>>
>>>> 5. As the Linux root user, start the Apache HTTP Server: /sbin/service
>>>> httpd start. Change into a directory where your Linux user has write
>>>> access to, and run the wget http://localhost/test2file command. Unless
>>>> there are any changes to the default configuration, this command
>>>> succeeds.
>>>>
>>>> 6. Enable SELinux by running /usr/sbin/setenforce 1 command. When
>>>> SELinux is enabled, /usr/sbin/getenforce returns Enforcing:
>>>>
>>>> $ getenforce
>>>> Enforcing
>>>>
>>>> The examples in these sections demonstrate how data can be protected
>>>> from a compromised confined-subject (protected by SELinux), as well as
>>>> how data is more accessible to an attacker from a compromised
>>>> unconfined-subject (not protected by SELinux).
>>>>
>>>> Confined and Unconfined User Domains
>>>>
>>>> In progress. Introduction to restrictions on certain domains (user_t,
>>>> guest_t etc).
>>>>
>>>> Are there any SELinux restrictions on what users can do when they run
>>>> unconfined?
>>>>
> See above,  Also there are booleans available to allow the transition to
>  a confined domain from the unconfined_t.  The one I would like to
> encourage is.
> 
> allow_unconfined_nsplugin_transition
> 
> Which will transition firefox plugins to a confined domain.
>>>> -- 
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
> 

> Thanks for your help.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
