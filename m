Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02158
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:16:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA10633
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:15:09 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA10629 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:15:08 GMT
Date: Thu, 21 Mar 2002 14:15:49 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ntp policy
In-Reply-To: <20020320220040.E4147419EC@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203211402450.19336-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> #################################
> #
> # uses_shlib(domain)
> #
> # Permissions for using shared libraries.
> #
> define(`uses_shlib',`
> allow $1 { root_t usr_t var_t }:dir r_dir_perms;

Why var_t?  If you want /var/lib, then you'll need var_lib_t as well, but
it isn't clear to me that you need it.  Also, you can put lib_t here
rather than separately below.

> allow $1 ld_so_t:file rx_file_perms;
> allow $1 ld_so_t:file execute_no_trans;
> allow $1 ld_so_t:lnk_file r_file_perms;
> allow $1 shlib_t:file rx_file_perms;
> allow $1 shlib_t:lnk_file r_file_perms;
> allow $1 ld_so_cache_t:file r_file_perms;
> allow $1 lib_t:dir r_dir_perms;
> allow $1 lib_t:file rx_file_perms;

I don't think you want the last rule in uses_shlib.  If the library is a
shared library, it should be labeled with shlib_t, so why grant execute
access to lib_t here?

> #################################
> #
> # uses_base_bins(domain)
> #
> # Permissions for running basic programs
> #
> define(`uses_base_bins',`
> uses_shlib($1)
> allow $1 bin_t:dir r_dir_perms;
> allow $1 bin_t:{ file lnk_file } r_file_perms;
> ')dnl
>
> Then we can have some other macros which use uses_base_bins (which probably
> isn't a good name) and add extra functionality of executing shells or sbin_t.

Do you want a separate macro like this, or do you want to add rules to the
can_exec and can_exec_any macros to make them more standalone?

> How about the following for defining domains for daemons:
> define(`daemon_domain', `
> type $1_t, domain, privlog;
> type $1_exec_t, file_type, sysadmfile, exec_type;
>
> role system_r types $1_t;
>
> domain_auto_trans(initrc_t, $1_exec_t, $1_t)
>
> # Inherit and use descriptors from init.
> allow $1_t { init_t newrole_t }:fd inherit_fd_perms;
> allow $1_t { init_t newrole_t }:process sigchld;

Why the newrole_t permissions?

> allow $1_t self:process signal;

You might want to use signal_perms here to pick up all of the signal
permissions.

> # Create pid file.
> type var_run_$1_t, file_type, sysadmfile, pidfile;
> file_type_auto_trans($1_t, var_run_t, var_run_$1_t)

Other possible candidates for file_type_auto_trans rules include
temporary files, log files, tmpfs/shm pseudo files, and lock files.

> allow $1_t self:process fork;

You'll also want sigchld if you allow forking, which will be handled
if you use signal_perms above.

On a different note, I'm wondering if we need a better mechanism for
coordinating your contributions to the example policy.  There is the CVS
tree at the sourceforge selinux site.  To date, we've been keeping a
pristine copy of each NSA public release imported on the vendor
branch under the 'nsa' directory.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
