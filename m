Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IGc6rT022544
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 12:38:06 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IGc6hM005308
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 16:38:06 GMT
Subject: Re: MySQL Policy Patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net>
References: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net>
Content-Type: text/plain
Message-Id: <1098117292.27895.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 12:34:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 11:49, Alex Ackerman wrote:
> allow mysqld_t staff_home_dir_t:dir { search };
> 
> allow mysqld_t sysadm_tmp_t:file { getattr read };
> 
>  
> 
> For some reason, MySQL is still trying to access staff home
> directories in the search for my.cnf. The second rule is for trying to
> read tmp files.  After reloading the policy with these changes,
> running /usr/bin/mysql_install_db works while in enforcing mode.  
> 
>  
> 
> Comments?

Think about the security implications:  Do you want a compromised mysqld
to be able to read arbitrary admin temporary files?  Not likely.  So
what you likely truly want is to run the installation procedure in a
different domain than the daemon itself.  Questions for Russell or
others who worked on this policy:
1) Is mysqld_exec_t the right type for /usr/libexec/mysqld?  Or should
it only be applied to /usr/sbin/mysqld?  Are they different programs on
your system?  If so, then one could avoid entering the domain via the
/usr/libexec helper by putting it into a different type.
2) Should mysqld.te use the nosysadm option to the daemon_domain macro
to preclude automatic transitions from sysadm_t?  That would avoid the
transition on the install script, but requires use of run_init on manual
restart of the daemon by the admin.
3) Should the install script be modified to use runcon or similar to
explictly override the domain transition?
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
