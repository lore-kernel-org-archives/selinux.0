Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MHBJC5008653
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 12:11:20 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MHBI29008210
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 17:11:18 GMT
Message-ID: <47BF0230.8010001@redhat.com>
Date: Fri, 22 Feb 2008 12:11:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@a61.nl
CC: selinux@tycho.nsa.gov
Subject: Re: Gen_require scoping?
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>    <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>    <1203692165.3669.910.camel@bluejay.goodinassociates.com>    <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil> <54715.80.95.164.250.1203694428.squirrel@www.a61.nl>
In-Reply-To: <54715.80.95.164.250.1203694428.squirrel@www.a61.nl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

selinux@a61.nl wrote:
> Hi all,
> 
> we're trying to setup an JBoss-module. As you probably know JBoss needs
> Java and vice versa.
> 
> For this we created an .te and if. Part of the .if is an interface to
> allow writing logfiles. Relevant part:
> 
> ########################################
> ## <summary>
> ##	Allow the specified domain to
> ##	write jboss log files
> ## </summary>
> ## <param name="domain">
> ##	<summary>
> ##	Domain allowed access.
> ##	</summary>
> ## </param>
> #
> interface(`jboss_write_log',`
> 	gen_require(`
> 		type jboss_log_t;
> 	')
> 	logging_search_logs($1)
> 	allow $1 jboss_log_t:dir list_dir_perms;
> 	allow $1 jboss_log_t:dir rw_dir_perms;
> 	allow $1 jboss_log_t:file read_file_perms;
> 	write_files_pattern($1,jboss_log_t,jboss_log_t);
> 	allow $1 jboss_log_t:dir search_dir_perms;
>         allow $1 jboss_log_t:dir getattr_dir_perms;
> ')
> 
> However, when compiling this modules, all fails at "allow $1
> jboss_log_t:dir list_dir_perms;" with this error:
> 
> Compiling targeted base module
> /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
> /usr/bin/checkmodule:  loading policy configuration from base.conf
> policy/modules/apps/java.te:22:ERROR 'unknown type jboss_log_t' at token
> ';' on line 491016:
> #line 22
>         allow java_t jboss_log_t:dir { getattr search read lock ioctl };
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/base.mod] Error 1
> 
> Just to try, we declared "type jboss_log_t;" before logging_search_logs
> and after the gen_require. After this I was able to compile the module
> (but did run into other problems)...
> 
> So, I believe I have an scoping issue; gen_require checks (and find)
> jboss_log_t. But as soon as someone is trying to use jboss_log_t in the
> interface, it breaks..
> 
> To make everything clear:
> We changed java.te and added:
> 
> #Java needs access to jboss_log_t
> jboss_write_log(java_t);
> 
> What I am doing wrong here??
> 
> Cheers,
> 
> Bart
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
No your module needs a te file that defined jboss_log_t, not just the
interface, and probably need a file context file.

cat jboss.te

type jboss_log_t;
logging_file_type(jboss_log_t)

cat jboss.fc
/var/log/jboss.*  gen_context(system_u:object_r:jboss_log_t,s0)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke/AjAACgkQrlYvE4MpobP52QCgopXRW8J10kAKL3T4XULq077o
u5QAoNcSqVRUryRI52Vo88qeZY+1V1ip
=z13R
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
