Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03546
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 17:05:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA29649
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 22:04:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA29637
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 22:04:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: ntp policy
Date: Thu, 21 Mar 2002 23:05:10 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203211402450.19336-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203211402450.19336-100000@raven>
MIME-Version: 1.0
Message-Id: <20020321220510.7EFCA41C99@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Mar 2002 20:15, Stephen Smalley wrote:
> > #################################
> > #
> > # uses_shlib(domain)
> > #
> > # Permissions for using shared libraries.
> > #
> > define(`uses_shlib',`
> > allow $1 { root_t usr_t var_t }:dir r_dir_perms;
>
> Why var_t?  If you want /var/lib, then you'll need var_lib_t as well, but
> it isn't clear to me that you need it.  Also, you can put lib_t here
> rather than separately below.

I think that I originally put it there as a sort of catch-all rule, misusing 
that macro a bit.  I've removed it now.

> > allow $1 ld_so_t:file rx_file_perms;
> > allow $1 ld_so_t:file execute_no_trans;
> > allow $1 ld_so_t:lnk_file r_file_perms;
> > allow $1 shlib_t:file rx_file_perms;
> > allow $1 shlib_t:lnk_file r_file_perms;
> > allow $1 ld_so_cache_t:file r_file_perms;
> > allow $1 lib_t:dir r_dir_perms;
> > allow $1 lib_t:file rx_file_perms;
>
> I don't think you want the last rule in uses_shlib.  If the library is a
> shared library, it should be labeled with shlib_t, so why grant execute
> access to lib_t here?

OK, so we have the following now:
define(`uses_shlib',`
allow $1 { root_t usr_t lib_t }:dir r_dir_perms;
allow $1 { ld_so_t shlib_t }:file rx_file_perms;
allow $1 ld_so_t:file execute_no_trans;
allow $1 shlib_t:lnk_file r_file_perms;
allow $1 ld_so_t:lnk_file r_file_perms;
allow $1 ld_so_cache_t:file r_file_perms;
allow $1 lib_t:file r_file_perms;
')

> > #################################
> > #
> > # uses_base_bins(domain)
> > #
> > # Permissions for running basic programs
> > #
> > define(`uses_base_bins',`
> > uses_shlib($1)
> > allow $1 bin_t:dir r_dir_perms;
> > allow $1 bin_t:{ file lnk_file } r_file_perms;
> > ')dnl
> >
> > Then we can have some other macros which use uses_base_bins (which
> > probably isn't a good name) and add extra functionality of executing
> > shells or sbin_t.
>
> Do you want a separate macro like this, or do you want to add rules to the
> can_exec and can_exec_any macros to make them more standalone?

can_exec() is great the way it is!  can_exec_any() should call uses_shlib() - 
you can't really execute many things without shlibs!  My suggestion for 
uses_base_bins() is essentially can_exec_any(), I must have overlooked it in 
the macros file.

> > How about the following for defining domains for daemons:
> > define(`daemon_domain', `
> > type $1_t, domain, privlog;
> > type $1_exec_t, file_type, sysadmfile, exec_type;
> >
> > role system_r types $1_t;
> >
> > domain_auto_trans(initrc_t, $1_exec_t, $1_t)
> >
> > # Inherit and use descriptors from init.
> > allow $1_t { init_t newrole_t }:fd inherit_fd_perms;
> > allow $1_t { init_t newrole_t }:process sigchld;
>
> Why the newrole_t permissions?

Because they seem to be needed for the tty devices.  But that might be 
related to my issues with using devfs instead of devpts.  I'll have to 
compile a new kernel with devpts and try it again.

> > allow $1_t self:process signal;
>
> You might want to use signal_perms here to pick up all of the signal
> permissions.

OK.

> > # Create pid file.
> > type var_run_$1_t, file_type, sysadmfile, pidfile;
> > file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
>
> Other possible candidates for file_type_auto_trans rules include
> temporary files, log files, tmpfs/shm pseudo files, and lock files.

Yes.  I think that it's probably best to have other macros that do them in 
addition to the base stuff.

> > allow $1_t self:process fork;
>
> You'll also want sigchld if you allow forking, which will be handled
> if you use signal_perms above.

Yes, although the main need for a fork in the daemon is as part of the 
detaching process, it forks and then the parent process exits leaving the 
child inherited by init.

> On a different note, I'm wondering if we need a better mechanism for
> coordinating your contributions to the example policy.  There is the CVS
> tree at the sourceforge selinux site.  To date, we've been keeping a
> pristine copy of each NSA public release imported on the vendor
> branch under the 'nsa' directory.

I don't think it makes sense for me to do CVS commits at the moment while you 
are pointing out mistakes in every policy file I post.  But if you would 
commit the versions that meet your approval without waiting for a new main 
release it would be a definite advantage.  Then I can start using new macros 
without waiting for a new release.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
