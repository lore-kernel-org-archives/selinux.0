Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2OGg136018756
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 11:42:01 -0500
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2OGeJV1003773
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 16:40:19 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2OGg0TN004403
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 11:42:00 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2OGfoTD238406
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 11:41:50 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2OGfn5a020049
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 11:41:50 -0500
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av03.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k2OGfnul020034
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 11:41:49 -0500
Received: from faith.austin.ibm.com (faith.austin.ibm.com [9.53.40.35])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id k2OGfm8t045056
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 10:41:48 -0600
Received: from faith.austin.ibm.com (localhost.localdomain [127.0.0.1])
	by faith.austin.ibm.com (8.13.4/8.12.8) with ESMTP id k2OGZ95I020672
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 10:35:09 -0600
Received: (from jml@localhost)
	by faith.austin.ibm.com (8.13.4/8.13.4/Submit) id k2OGZ8UM020671
	for selinux@tycho.nsa.gov; Fri, 24 Mar 2006 10:35:08 -0600
Subject: interfaces added...
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 24 Mar 2006 10:35:08 -0600
Message-Id: <1143218108.2462.208.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had a delivery failure so am resending to selinux list.

Regards,
Joy
------------------------------------------------------------------------
Chris,
        
        A week or so ago, on irc we discussed about adding several
        interfaces that would allow third party modules, such as the
        selinux test policy, to have types/domains that can be entered
        via the sysadm domain. 
        Below is a patch containing several new interfaces that allow
        this.
        Please let me know if these are ok or if I need to change
        something
        as I have added them to the test policy. miscfiles.te already
        defined a test_file_t, so I expanded on that.
        
        Regards,
        Joy Latten
        
        diff -urpN modules.orig/kernel/corecommands.if
        modules/kernel/corecommands.if
        --- modules.orig/kernel/corecommands.if	2006-03-23
        11:31:30.000000000 -0600
        +++ modules/kernel/corecommands.if	2006-03-23 11:37:10.000000000
        -0600
        @@ -780,3 +780,36 @@ interface(`corecmd_exec_chroot',`
         	allow $1 self:capability sys_chroot;
         ')
         
        +########################################
        +## <summary>
        +##	Make bin_t an entrypoint for the specified domain.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	The domain for which bin_t is an entrypoint.
        +##	</summary>
        +## </param>
        +interface(`corecmd_sbin_entry_type',`
        +	gen_require(`
        +		type sbin_t;
        +	')
        +
        +	domain_entry_file($1,sbin_t)
        +')
        +
        +########################################
        +## <summary>
        +##	Make bin_t an entrypoint for the specified domain.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	The domain for which bin_t is an entrypoint.
        +##	</summary>
        +## </param>
        +interface(`corecmd_bin_entry_type',`
        +	gen_require(`
        +		type bin_t;
        +	')
        +
        +	domain_entry_file($1,bin_t)
        +')
        diff -urpN modules.orig/system/miscfiles.if
        modules/system/miscfiles.if
        --- modules.orig/system/miscfiles.if	2006-03-23
        11:31:30.000000000 -0600
        +++ modules/system/miscfiles.if	2006-03-23 11:42:31.000000000
        -0600
        @@ -303,3 +303,62 @@ interface(`miscfiles_exec_tetex_data',`
         	allow $1 tetex_data_t:dir r_dir_perms;
         	can_exec($1,tetex_data_t)
         ')
        +
        +########################################
        +## <summary>
        +##	Read test files and directories.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	Domain allowed access.
        +##	</summary>
        +## </param>
        +#
        +interface(`miscfiles_read_test_files',`
        +	gen_require(`
        +		type test_file_t;
        +	')
        +
        +	allow $1 test_file_t:dir r_dir_perms;
        +	allow $1 test_file_t:file r_file_perms;
        +	allow $1 test_file_t:lnk_file r_file_perms;
        +')
        +
        +########################################
        +## <summary>
        +##	Execute test files.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	Domain allowed access.
        +##	</summary>
        +## </param>
        +#
        +interface(`miscfiles_exec_test_files',`
        +	gen_require(`
        +		type test_file_t;
        +	')
        +
        +	allow $1 test_file_t:dir r_dir_perms;
        +	allow $1 test_file_t:file r_file_perms;
        +	allow $1 test_file_t:lnk_file r_file_perms;
        +	can_exec($1, test_file_t)
        +')
        +
        +########################################
        +## <summary>
        +##	Let test domain be an entry point for
        +##	a specified domain.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	Domain to be entered.
        +##	</summary>
        +## </param>
        +#
        +interface(`miscfiles_domain_entry_test_files',`
        +	gen_require(`
        +		type test_file_t;
        +	')
        +	domain_entry_file($1, test_file_t)
        +')
        diff -urpN modules.orig/system/userdomain.if
        modules/system/userdomain.if
        --- modules.orig/system/userdomain.if	2006-03-23
        11:31:30.000000000 -0600
        +++ modules/system/userdomain.if	2006-03-23 11:54:53.000000000
        -0600
        @@ -3099,6 +3099,79 @@ interface(`userdom_entry_spec_domtrans_s
         
         ########################################
         ## <summary>
        +##	Allow sysadm to execute a generic bin program in
        +##	a specified domain.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	Domain to execute in.
        +##	</summary>
        +## </param>
        +#
        +interface(`userdom_sysadm_spec_domtrans_bin',`
        +	gen_require(`
        +		type sysadm_t;
        +	')
        +
        +	corecmd_bin_spec_domtrans(sysadm_t,$1)
        +
        +	allow sysadm_t $1:fd use;
        +	allow $1 sysadm_t:fd use;
        +	allow $1 sysadm_t:fifo_file rw_file_perms;
        +	allow $1 sysadm_t:process sigchld;
        +')
        +
        +########################################
        +## <summary>
        +##	Allow sysadm to execute a generic sbin program in
        +##	a specified domain.
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	Domain to execute in.
        +##	</summary>
        +## </param>
        +#
        +interface(`userdom_sysadm_spec_domtrans_sbin',`
        +	gen_require(`
        +		type sysadm_t;
        +	')
        +
        +	corecmd_sbin_spec_domtrans(sysadm_t, $1)
        +
        +	allow sysadm_t $1:fd use;
        +	allow $1 sysadm_t:fd use;
        +	allow $1 sysadm_t:fifo_file rw_file_perms;
        +	allow $1 sysadm_t:process sigchld;
        +')
        +
        +########################################
        +## <summary>
        +##	Allow sysadm to execute all entrypoint files
        +##	in the specified domain. This is an explicit
        +##	transition, requiring the caller to use setexeccon().
        +## </summary>
        +## <param name="domain">
        +##	<summary>
        +##	Domain to execute in.
        +##	</summary>
        +## </param>
        +#
        +interface(`userdom_sysadm_entry_spec_domtrans',`
        +	gen_require(`
        +		type sysadm_t;
        +	')
        +
        +	domain_entry_file_spec_domtrans(sysadm_t, $1)
        +
        +	allow sysadm_t $1:fd use;
        +	allow $1 sysadm_t:fd use;
        +	allow $1 sysadm_t:fifo_file rw_file_perms;
        +	allow $1 sysadm_t:process sigchld;
        +')
        +
        +########################################
        +## <summary>
         ##	Search the staff users home directory.
         ## </summary>
         ## <param name="domain">
        

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
