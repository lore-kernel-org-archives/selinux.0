Subject: Re: SUDO package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <200304231710.34773.russell@coker.com.au>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
	 <3EA021A5.4020603@redhat.com>
	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
	 <200304231710.34773.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051205517.20300.71.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Apr 2003 13:31:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-23 at 03:10, Russell Coker wrote:
> In the daemon_domain() macro defined in macros/global_macros.te the naming 
> scheme var_run_$1_t is used.  It might make things easier in future to use 
> that.
> 
> We probably should have a macro var_run_domain() which is used by 
> daemon_domain() and by other policy such as the sudo policy.
> 
> How about something like the following:
> define(`var_run_domain', `
> type var_run_$1_t, file_type, sysadmfile, lockfile;
> file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
> ')
> 
> Or we could change the naming scheme to something else.  Log files etc have 
> the _log_t part appended to the base name of the program domain.

I prefer extending the domain name with the type suffix, but this is
obviously not a big deal as long as we are consistent.  It is likely
easier to quickly see what types are associated with a given domain if
they use the domain name as the prefix.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
