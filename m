Subject: Re: user guide draft: "Targeted Policy" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BE3FB4.8020003@redhat.com>
References: <48BE3FB4.8020003@redhat.com>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 09:19:21 -0400
Message-Id: <1220447961.6034.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-09-03 at 17:41 +1000, Murray McAllister wrote:
> Hi,
> 
> The following is a draft of the "Targeted Policy" sections for the 
> SELinux User Guide. Any comments and corrections are appreciated.
> 
> Thanks.
> 
> Targeted Policy
> 
> Targeted policy is the default SELinux policy used in Fedora 10. When 
> using targeted policy, subjects that are targeted run in their own 
> domain type, and subjects that are not targeted run in the unconfined_t 
> domain type. When a subject runs in the unconfined_t domain type, 
> SELinux rules do not apply, and only DAC rules are used.

Not exactly true.  SELinux rules are always applied, but the
unconfined_t domain is allowed (almost) all permissions in the SELinux
policy/rules.

> Confined Subjects
> 
> A large number of subjects are protected, and are therefore confined by 
> the SELinux targeted policy, including the Apache HTTP Server (httpd), 
> Samba (samba), FTP (vsftpd), Kerberos (krb5-server), ISC BIND (bind and 
> bind-chroot), NFS (nfs-utils), and NIS (ypserv). When a subject is 
> confined, it runs in its own domain type, such as the httpd subject 
> running in the httpd_t domain type. When a confined subject is 
> compromised by an attacker, the damage an attacker can do and the data 
> they can access is greatly limited.

Greatly limited might be too strong as a general statement - it is
limited in accordance with the policy, and thus depends on how the
policy is configured.

> The following example demonstrates how SELinux prevents the Apache HTTP 
> Server (httpd) from reading files that are not correctly labeled, such 
> as files intended for use by another subject. This is an example, and 
> should not be used in production. It assumes that the httpd and wget 
> packages are installed, that the SELinux targeted policy is used, and 
> that SELinux is running in enforcing mode:
> 
> 1. As the Linux root user, run the touch /var/www/html/testfile command.
> 
> 2. Run the ls -Z /var/www/html/testfile command to view the SELinux 
> context:
> 
> -rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 
> /var/www/html/testfile
> 
> By default, Linux users run unconfined on Fedora 10, which is why the 
> testfile file object is labeled with the SELinux unconfined_u user. The 
> object_r role is a standard role, and does not affect access control. 
> The httpd_sys_content_t file type allows the httpd subject to access 
> this object.
> 
> [ What is object_r really for? ]

The default role value for objects, and one that avoids any restrictions
on the user, type, and level combination in the object context.

> 3. As the Linux root user, start the Apache HTTP Server: /sbin/service 
> httpd start. When the server has started, change into a directory where 
> your Linux user has write access to, and run the wget 
> http://localhost/testfile command. Unless there are any changes to the 
> default configuration, this command succeeds.
> 
> 4. The /usr/bin/chcon command relabels files; however, such label 
> changes do not survive when the file system is relabeled. For permanent 
> changes that survive a file system relabel, use the /usr/sbin/semanage 
> command, which is discussed later. As the Linux root user, run the 
> /usr/bin/chcon -t samba_share_t /var/www/html/testfile command to change 
> the file type, to a file type that is used by Samba. Run the ls -Z 
> /var/www/html/testfile command to verify the changes:
> 
> [ If a file has an entry in file_contexts, and is relabeled with 
> semanage fcontext, does that update 
> /etc/selinux/targeted/contexts/files/file_contexts with the change? I 
> was going to try, but forgot how to change the file type with semanage]

See the EXAMPLES section of the semanage man page.
semanage fcontext -a -t samba_share_t /var/www/html/testfile
The semanage command will update the file_contexts file with the change,
but does not immediately apply the label to any affected files - you
need to run restorecon on the files in order to apply it.

> 
> -rw-r--r--  root root unconfined_u:object_r:samba_share_t:s0 
> /var/www/html/testfile
> 
> 5. Note: the current DAC permissions allow the httpd subject access to 
> this file. Change into a directory where your Linux user has write 
> access to, and run the wget http://localhost/testfile command. Unless 
> there are any changes to the default configuration, this command fails:
> 
> HTTP request sent, awaiting response... 403 Forbidden
> 2008-08-22 03:48:40 ERROR 403: Forbidden.
> 
> This example demonstrates the additional security added by SELinux. 
> Although the httpd subject had access to the object in step 5, because 
> the object was labeled with a file type that httpd subject does not have 
> access to, SELinux denied access. After step 5, an error such as the 
> following is logged to /var/log/messages:
> 
> Aug 22 03:48:40 localhost setroubleshoot: SELinux is preventing httpd 
> (httpd_t) "getattr"
> to /var/www/html/testfile (samba_share_t). For complete SELinux messages.
> run sealert -l c05911d3-e680-4e42-8e36-fe2ab9f8e654
> 
> Also, if the audit package is installed and the auditd subject is 
> running, a more detailed denial is logged to /var/log/audit/audit.log. 
> These denials are discussed later.
> 
> Unconfined Subjects
> 
> Unconfined subjects run in the unconfined_t domain type. This means that 
> SELinux policy rules do not apply, and only DAC permissions are used.

To be precise, the SELinux policy rules grant most permissions to the
unconfined_t domain, making it _effectively_ unconstrained by SELinux
even though the rules _are_ still applied.

> When an unconfined subject is comprised, an attacker may gain access to 
> a large number of system resources and data.
> 
> The following example demonstrates how the Apache HTTP Server (httpd) 
> can access data intended for use by another subject, when running 
> unconfined. Note: on Fedora 10, the httpd subject runs in the confined 
> httpd_t domain type by default. This is an example, and should not be 
> used in production. It assumes that the httpd and wget packages are 
> installed, that the SELinux targeted policy is used, and that SELinux is 
> running in enforcing mode:
> 
> 1. As the Linux root user, run the touch /var/www/html/test2file command.
> 
> 2. Run the ls -Z /var/www/html/test2file command to view the SELinux 
> context:
> 
> -rw-r--r--  root root unconfined_u:object_r:httpd_sys_content_t:s0 
> /var/www/html/test2file
> 
> By default, Linux users run unconfined on Fedora 10, which is why the 
> test2file file object is labeled with the SELinux unconfined_u user. The 
> object_r role is a standard role, and does not affect access control. 
> The httpd_sys_content_t file type allows the httpd subject to access 
> this object.
> 
> 3. The /usr/bin/chcon command relabels files; however, such label 
> changes do not survive when the file system is relabeled. For permanent 
> changes that survive a file system relabel, use the /usr/sbin/semanage 
> command, which is discussed later. As the Linux root user, run the 
> /usr/bin/chcon -t samba_share_t /var/www/html/test2file command to 
> change the file type, to a file type that is used by Samba. Run the ls 
> -Z /var/www/html/test2file command to verify the changes:
> 
> -rw-r--r--  root root unconfined_u:object_r:samba_share_t:s0 
> /var/www/html/test2file
> 
> 4. To simulate the httpd subject running unconfined, run the 
> /usr/sbin/setenforce 0 command as the Linux root user to temporarily 
> disable SELinux. Confirm SELinux is disabled by running the 
> /usr/sbin/getenforce command. When SELinux is disabled, 
> /usr/sbin/getenforce returns Permissive:
> 
> $ getenforce
> Permissive

There are more precise ways to make httpd unconfined w/o making the
entire system permissive, e.g.:
1) Label the httpd binary with unconfined_exec_t and re-start it, or
2) Making the httpd_t domain permissive (in F10 and later):
semanage permissive -a httpd_t

> 5. As the Linux root user, start the Apache HTTP Server: /sbin/service 
> httpd start. Change into a directory where your Linux user has write 
> access to, and run the wget http://localhost/test2file command. Unless 
> there are any changes to the default configuration, this command succeeds.
> 
> 6. Enable SELinux by running /usr/sbin/setenforce 1 command. When 
> SELinux is enabled, /usr/sbin/getenforce returns Enforcing:
> 
> $ getenforce
> Enforcing
> 
> The examples in these sections demonstrate how data can be protected 
> from a compromised confined-subject (protected by SELinux), as well as 
> how data is more accessible to an attacker from a compromised 
> unconfined-subject (not protected by SELinux).
> 
> Confined and Unconfined User Domains
> 
> In progress. Introduction to restrictions on certain domains (user_t, 
> guest_t etc).
> 
> Are there any SELinux restrictions on what users can do when they run 
> unconfined?

Yes.  They are still restricted by MCS.  There are certain booleans that
can apply certain restrictions like execmem, execstack.  And if they run
any program with its own domain and a domain transition is defined from
unconfined_t to the program's domain then they are still subject to the
restrictions on that domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
