Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IEEhV9001703
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 10:14:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IEEelK008219
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 14:14:40 GMT
Message-ID: <47DFCE47.8020408@redhat.com>
Date: Tue, 18 Mar 2008 10:14:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@a61.nl
CC: selinux@tycho.nsa.gov
Subject: Re: myjboss and jbossjava selinux-modules
References: <53028.80.95.164.250.1204551758.squirrel@rvandenblink.nl>
In-Reply-To: <53028.80.95.164.250.1204551758.squirrel@rvandenblink.nl>
Content-Type: multipart/mixed;
 boundary="------------040201020207000609050001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040201020207000609050001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

selinux@a61.nl wrote:
> Hi Gents,
> 
> We have spent the last two weeks on creating selinux-modules for jboss and
> a custom-made jbossjava-module. I've attached the files to this message.
> 
> We would like you guys to take a look at our modules and tell us what we
> did wrong. For instance we didn't use real domain-transitions (at least we
> didn't use real domtrans()) to give jbossjava access to myjboss, do we
> have to? Or is the way we work sufficient?
> 
> It is possible that we made some of the rules to coarse, if that's the
> case, please let us know how we can make them better. This is our first
> attempt to write a module and let it checked upstream but that doesn't
> mean you have to be mild to us!
> 
> At the moment we use the (selinux)-user ejbca because in our current
> system we are running ejbca on top of jboss, but we are changing it this
> week to run as jboss.
> 
> Please sent changes as real patches so we can patch our source-code!
> 
> 
> With regards,
> 
> 
> Ronald van den Blink
Just getting around to reviewing this.

myjboss.te

1 You have jboss_rx_t defined but never used.
2 init_daemon_domain contains domain_type(jboss_t)
3 you should try to avoid using gen_require in a te file, you should try
to use interfaces instead
userdom_dontaudit_search_sysadm_home_dirs(jboss_t)
for example.
staff_tmp_t is not used anywhere
4 type port_t should probably be jboss_port_t and then map the actual
ports jboss needs to connect/bind to.

Probably jboss_rw_t and jboss_opt_t should be combined to one type
files_pid_filetrans(jboss_t,jboss_rw_t, { file dir })
Should probably be
files_pid_filetrans(jboss_t,jboss_var_run_t, { file dir })

Does jboss_tmp_t needed?  If yes you probably need
 files_tmp_filetrans(jboss_t,jboss_tmp_t, { file dir })

You are missing
allow jboss_t jboss_log_t:dir manage_dir_perms;
allow jboss_t jboss_log_t:file manage_file_perms;

Not sure you need this, or if jboss_t execs other jboss_exec_t you need
can_exec(jboss_t, jboss_exec_t)
allow jboss_t jboss_exec_t:dir r_dir_perms;


I would just remove the jbossjava stuff all together and use the
standard definitions of java.

I rewrote some of your defs and attached.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkffzjcACgkQrlYvE4MpobP2vACgonlpdAyBgqSiT4CVCv7A/mqH
TvEAoKXnUNCB3q6L9iCqfZ6arsORgs1z
=Xni2
-----END PGP SIGNATURE-----

--------------040201020207000609050001
Content-Type: text/plain;
 name="myjboss.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="myjboss.fc"


/var/run/jboss\.pid     --                              gen_context(ejbca:object_r:jboss_var_run_t)
/opt/jboss-4.2.2.GA/bin(/.*)?			          gen_context(ejbca:object_r:jboss_exec_t)
/var/log/jboss(/.*)?                            gen_context(ejbca:object_r:jboss_log_t)
/opt/jboss-4.2.2.GA(/.*)?                       gen_context(ejbca:object_r:jboss_rw_t)
/opt/jboss(/.*)?  			                     gen_context(ejbca:object_r:jboss_rw_t)

--------------040201020207000609050001
Content-Type: text/plain;
 name="myjboss.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="myjboss.if"

## <summary>myjboss module</summary>

########################################
## <summary>
##      Execute a domain transition to run jboss.
## </summary>
## <param name="domain">
## <summary>
##      Domain allowed to transition.
## </summary>
## </param>
#
interface(`jboss_domtrans',`
        gen_require(`
                type jboss_t, jboss_exec_t;
        ')

        domain_auto_trans($1,jboss_exec_t,jboss_t)

        allow jboss_t $1:fd use;
        allow jboss_t $1:fifo_file rw_file_perms;
        allow jboss_t $1:process sigchld;
')

########################################
## <summary>
##      Do not audit attempts to read,
##      jboss tmp files
## </summary>
## <param name="domain">
##      <summary>
##      Domain to not audit.
##      </summary>
## </param>
#
interface(`jboss_dontaudit_read_tmp_files',`
        gen_require(`
                type jboss_tmp_t;
        ')

        dontaudit $1 jboss_tmp_t:file r_file_perms;
')

########################################
## <summary>
##      Allow domain to read, jboss tmp files
## </summary>
## <param name="domain">
##      <summary>
##      Domain to not audit.
##      </summary>
## </param>
#
interface(`jboss_read_tmp_files',`
        gen_require(`
                type jboss_tmp_t;
        ')

        dontaudit $1 jboss_tmp_t:file r_file_perms;
')

########################################
## <summary>
##      Search jboss rw directories.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`jboss_search_rw_dir',`
        gen_require(`
                type jboss_rw_t;
        ')

        allow $1 jboss_rw_t:dir search_dir_perms;
        files_search_rw($1)
')

########################################
## <summary>
##      Read jboss rw files.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`jboss_read_rw_files',`
        gen_require(`
                type jboss_rw_t;
        ')

        allow $1 jboss_rw_t:file r_file_perms;
        allow $1 jboss_rw_t:dir list_dir_perms;
        files_search_rw($1)
')

########################################
## <summary>
##      Create, read, write, and delete
##      jboss rw files.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`jboss_manage_rw_files',`
        gen_require(`
                type jboss_rw_t;
        ')

        allow $1 jboss_rw_t:file manage_file_perms;
        allow $1 jboss_rw_t:dir rw_dir_perms;
')

########################################
## <summary>
##	Allow the specified domain to manage
##	jboss pid file
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`jboss_manage_pid',`
	gen_require(`
		type jboss_var_run_t;
	')
	manage_files_pattern($1,jboss_var_run_t,httpd_var_run_t)
	files_pid_filetrans($1,jboss_var_run_t, file)
')


--------------040201020207000609050001
Content-Type: text/plain;
 name="myjboss.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="myjboss.te"

policy_module(myjboss,1.1.2)

########################################
#
# Declarations
#

type jboss_t;
type jboss_exec_t;
domain_type(jboss_t)
init_daemon_domain(jboss_t, jboss_exec_t)
role system_r types jboss_t;

type jboss_port_t;
ports_type(jboss_port_t)

type jboss_log_t;
logging_log_file(jboss_log_t)
type jboss_tmp_t;
files_tmp_file(jboss_tmp_t)
type jboss_rw_t;
files_type(jboss_rw_t)
type jboss_var_run_t;
files_pid_file(jboss_var_run_t)

########################################
#
# jboss local policy
#

# Init script handling
domain_use_interactive_fds(jboss_t)

allow jboss_t self:capability dac_override;
allow jboss_t self:process { execmem getsched signal };

## internal communication is often done using fifo and unix sockets.
allow jboss_t self:fifo_file rw_file_perms;
allow jboss_t self:unix_stream_socket create_stream_socket_perms;
allow jboss_t self:tcp_socket create_stream_socket_perms;

# Allow acces too our selves
allow jboss_t jboss_exec_t:dir r_dir_perms;
allow jboss_t jboss_rw_t:dir manage_dir_perms;
allow jboss_t jboss_rw_t:file manage_file_perms;

allow jboss_t jboss_log_t:dir manage_dir_perms;
allow jboss_t jboss_log_t:file manage_file_perms;

allow jboss_t jboss_tmp_t:file manage_file_perms;
allow jboss_t jboss_tmp_t:dir create_dir_perms;
files_tmp_filetrans(jboss_t,jboss_tmp_t, { file dir })

files_read_etc_files(jboss_t)

# Network
allow jboss_t jboss_port_t:tcp_socket { name_bind name_connect };

# Localization access
miscfiles_read_localization(jboss_t)

auth_use_nsswitch(jboss_t)

#lib access
libs_use_ld_so(jboss_t)
libs_use_lib_files(jboss_t)
libs_use_shared_libs(jboss_t)

# Call our own bin-dir
corecmd_exec_bin(jboss_t)
corecmd_read_bin_symlinks(jboss_t)
corecmd_search_bin(jboss_t)
corecmd_search_sbin(jboss_t)

# Radomizer access for ssl
dev_read_rand(jboss_t)
dev_read_urand(jboss_t)

# Network Access
kernel_read_network_state(jboss_t)
kernel_search_network_state(jboss_t)
corenet_tcp_bind_http_cache_port(jboss_t)
corenet_tcp_bind_http_port(jboss_t)
corenet_tcp_bind_generic_node(jboss_t)
corenet_tcp_bind_inaddr_any_node(jboss_t)
corenet_tcp_bind_kerberos_master_port(jboss_t)
corenet_tcp_bind_lo_node(jboss_t)
corenet_non_ipsec_sendrecv(jboss_t)
corenet_tcp_connect_http_cache_port(jboss_t)
corenet_tcp_connect_http_port(jboss_t)
sysnet_dns_name_resolve(jboss_t)

files_pid_filetrans(jboss_t,jboss_var_log_t, { file dir })
files_manage_generic_tmp_files(jboss_t)
files_manage_generic_tmp_dirs(jboss_t)
files_read_usr_symlinks(jboss_t)
kernel_read_system_state(jboss_t)
dontaudit jboss_t sysadm_home_dir_t:dir search;

#Go to jbossjava domain

jbossjava_read_lnk(jboss_t)
jbossjava_execute_file(jboss_t)
jbossjava_search_r_dir(jboss_t)

--------------040201020207000609050001
Content-Type: application/octet-stream;
 name="myjboss.fc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="myjboss.fc.sig"

iEYEABECAAYFAkffzjcACgkQrlYvE4MpobN36wCgxR9HviNDqSd0pj7JnJcJYGjWJKQAnj9Y
yegiRPJ3OPJ4qvqqRx/RzsYX
--------------040201020207000609050001
Content-Type: application/octet-stream;
 name="myjboss.if.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="myjboss.if.sig"

iEYEABECAAYFAkffzjcACgkQrlYvE4MpobPlNQCgiyd6wGLUnkEM4CL5qFoIQXJE9H4AoLst
WCW6bjXceKZyfUwuOqMf8RpI
--------------040201020207000609050001
Content-Type: application/octet-stream;
 name="myjboss.te.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="myjboss.te.sig"

iEYEABECAAYFAkffzjcACgkQrlYvE4MpobOwOgCgqrNlVYJ3PxI5OVcAyzBqGwWt5VsAoLDN
k3mcFJ586zdlZmNt0417BlFp
--------------040201020207000609050001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
