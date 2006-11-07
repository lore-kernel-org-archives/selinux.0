Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA7J4p86017016
	for <selinux@tycho.nsa.gov>; Tue, 7 Nov 2006 14:04:51 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA7J45jq008414
	for <selinux@tycho.nsa.gov>; Tue, 7 Nov 2006 19:04:06 GMT
Message-ID: <4550D8DC.60003@redhat.com>
Date: Tue, 07 Nov 2006 14:05:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Matt Anderson <mra@hp.com>
CC: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Policy for aide
References: <454F7298.9070306@hp.com>
In-Reply-To: <454F7298.9070306@hp.com>
Content-Type: multipart/mixed;
 boundary="------------000002090104070700040408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000002090104070700040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Try this.



--------------000002090104070700040408
Content-Type: text/plain;
 name="aide.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aide.fc"

/usr/sbin/aide	--	gen_context(system_u:object_r:aide_exec_t,mls_systemhigh)
/var/lib/aide(/.*)	gen_context(system_u:object_r:aide_db_t,mls_systemhigh)
/var/log/aide.log	--	gen_context(system_u:object_r:aide_log_t,mls_systemhigh)

--------------000002090104070700040408
Content-Type: text/plain;
 name="aide.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aide.if"

## <summary>Aide filesystem integrity checker</summary>

########################################
## <summary>
##      Execute aide in the aide domain
## </summary>
## <param name="domain">
##      <summary>
##      The type of the process performing this action.
##      </summary>
## </param>
#
interface(`aide_domtrans',`
        gen_require(`
                type aide_t, aide_exec_t;
        ')

	corecmd_search_sbin($1)
        domain_auto_trans($1,aide_exec_t,aide_t)

	allow $1 aide_t:fd use;
	allow aide_t $1:fd use;
	allow aide_t $1:fifo_file rw_file_perms;
	allow aide_t $1:process sigchld;
')


########################################
## <summary>
##	Execute aide programs in the AIDE domain.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to allow the AIDE domain.
##	</summary>
## </param>
## <param name="terminal">
##	<summary>
##	The type of the terminal allow the AIDE domain to use.
##	</summary>
## </param>
#
interface(`aide_run',`
	gen_require(`
		type aide_t;
	')

	aide_domtrans($1)
	role $2 types aide_t;
	allow aide_t $3:chr_file rw_file_perms;
')

--------------000002090104070700040408
Content-Type: text/plain;
 name="aide.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aide.te"


policy_module(aide,1.0)

########################################
#
# Declarations
#

type aide_t;
type aide_exec_t;

domain_type(aide_t)
domain_entry_file(aide_t,aide_exec_t)

# log files
type aide_log_t;
logging_log_file(aide_log_t)

# aide database
type aide_db_t;
files_type(aide_db_t)

########################################
#
# aide local policy
#
seutil_use_newrole_fds(aide_t)

# database actions
allow aide_t aide_db_t:dir rw_dir_perms;
allow aide_t aide_db_t:file create_file_perms;

# logs
logging_log_filetrans(aide_t,aide_log_t,file)
allow aide_t aide_log_t:file create_file_perms;

# audit
allow aide_t self:capability audit_write;
allow aide_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };


########################################
#
# Local policy
#

allow aide_t self:capability { dac_override fowner };

files_read_all_files(aide_t)

libs_use_shared_libs(aide_t)


--------------000002090104070700040408
Content-Type: text/plain;
 name="local.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="local.te"

policy_module(local,1.0)

gen_require(`
	type secadm_t, secadm_devpts_t, secadm_tty_device_t;	
	role secadm_r;
')

aide_run(secadm_t, secadm_r, { secadm_tty_device_t secadm_devpts_t })

--------------000002090104070700040408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
