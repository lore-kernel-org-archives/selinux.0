Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01376
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:25:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA03016
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 17:24:41 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA03010 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 17:24:40 GMT
Date: Wed, 6 Mar 2002 12:24:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>, <miquels@cistron.nl>
Subject: Re: Squid policy for SE Linux
In-Reply-To: <20020306162726.12F7E1EEA2@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203061158000.24985-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 6 Mar 2002, Russell Coker wrote:

> I have attached my squid.te file.

Thanks.  I'm not familiar with squid, but I'll provide some comments on
the policy below.

> Here's the relevant parts of my file_contexts file:
> /var/cache/squid(|/.*)          system_u:object_r:httpd_cache_t

I'm unclear as to whether it is a good idea to use the same type here as
for /var/cache/httpd.  Do you really want to grant squid and httpd the
same set of accesses to both /var/cache/httpd and /var/cache/squid?

> /usr/lib/squid                  system_u:object_r:squid_t

In a TE policy, you typically keep the domain space and the object type
space separate - i.e. you never use a domain as a file type.  In SELinux,
there is a special case for the /proc/PID entries of a process, which are
labeled with the SID of the process (and hence its domain).  If you use
the domain for other files, the policy won't be able to distinguish
between the /proc/PID entries and these other files.  So I would recommend
using a different type here, possibly just leaving it in lib_t unless you
truly need to separate it.

> I also added squid_t to system_r in the rbac file.

I've partitioned the role declarations up among the various .te files in
our internal copy of the policy, so this will actually be moved into
squid.te.

My comments on your squid.te file are below:

># squid_t is the domain the squid process runs in, and is also the SID
>for
># files in /usr/lib/squid
>type squid_t, domain, privlog;

As I mentioned above, I wouldn't recommend using this domain as a file
type.  Also, since you didn't include the file_type attribute, the kernel
should have denied your attempt to relabel the file to this domain, unless
you were running in permissive mode at the time.  In contrast, the kernel
is free to apply the domain to pseudo files that it generates like
/proc/PID.

># httpd_cache_t is for /var/cache/squid
>allow squid_t httpd_cache_t:dir create_dir_perms;
>allow squid_t httpd_cache_t:file rw_file_perms;
>file_type_auto_trans(squid_t, httpd_cache_t, httpd_cache_t)

As I also mentioned above, I'm not sure if you want to use the same type
that is being used for /var/cache/httpd.  Make sure that there aren't any
implications of granting both squid and httpd the same set of permissions
to both sets of files.

>allow squid_t var_log_squid_t:dir rw_dir_perms;
>allow squid_t var_log_squid_t:file rw_file_perms;
>file_type_auto_trans(squid_t, var_log_squid_t, var_log_squid_t)

You only need a file_type_auto_trans rule if you want the new file to
inherit a type other than the type of the parent directory.  If
/var/log/squid were a file or directory that was created (or recreated) at
runtime by squid, then you would need a rule like
	file_type_auto_trans(squid_t, var_log_t, var_log_squid_t)
to ensure that it was created with the right type.  But if /var/log/squid
is always created during installation and you initially label it with
the type, then all files created within it will inherit that type
automatically without needing the file_type_auto_trans rule.

However, if you remove the file_type_auto_trans rule, you will need to
expand the allow statements to allow creation of files within the
directory, e.g.:
	allow squid_t var_log_squid_t:dir rw_dir_perms;
	allow squid_t var_log_squid_t:file create_file_perms;
You might need create_dir_perms in the first rule if squid needs to create
subdirectories within /var/log/squid.

># for /usr/lib/squid
>allow squid_t squid_t:dir r_dir_perms;
>allow squid_t squid_t:file r_file_perms;
>allow squid_t squid_t:file { execute_no_trans execute };

As mentioned above, I'd suggest using a different type for /usr/lib/squid,
possibly leaving it in lib_t.  For the execute-related permissions, I'd
suggest using can_exec(squid_t, lib_t) or whatever your type is.

>allow squid_t squid_exec_t:file execute_no_trans;

I'm not clear as to why this is needed, unless squid re-executes itself at
times.  The domain_auto_trans rule handles giving permissions to initially
enter the domain via this executable.  In any case, I'd suggest using the
can_exec macro, e.g.
	can_exec(squid_t, squid_exec_t)

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com









--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
