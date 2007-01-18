Message-ID: <45AFA113.4040901@tresys.com>
Date: Thu, 18 Jan 2007 11:32:19 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] 2/4 - Hierarchal apache policy for reference policy (interfaces)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is an RFC for the interface file for a hierarchal apache policy. 
It includes metapolicy for apache types at the bottom of the 
apache_per_role_template template.

-----------------------------------------------

## <summary>Apache web server</summary>

########################################
## <summary>
##    Create a set of derived types for apache
##    web content.
## </summary>
## <param name="prefix">
##    <summary>
##    The prefix to be used for deriving type names.
##    </summary>
## </param>
#
template(`apache_content_template',`
    gen_require(`
        attribute httpdcontent;
        attribute httpd_exec_scripts;
        attribute httpd_script_exec_type;
        type apache_t.daemon, apache_t.suexec, apache_t.log;
    ')

    # allow write access to public file transfer
    # services files.
    gen_tunable(allow_httpd_$1_script_anon_write,false)

    #This type is for webpages
    type apache_t.$1_content alias httpd_$1_content_t, httpdcontent; # 
customizable
    files_type(apache_t.$1_content)

    # This type is used for .htaccess files
    type apache_t.$1_htaccess alias httpd_$1_htaccess_t; # customizable;
    files_type(apache_t.$1_htaccess)

    # Type that CGI scripts run as
    type apache_t.$1_script alias httpd_$1_script_t;
    domain_type(apache_t.$1_script)
    role system_r types apache_t.$1_script;

    # This type is used for executable scripts files
    type apache_t.$1_script_exec alias httpd_$1_script_exec_t, 
httpd_script_exec_type; # customizable;
    corecmd_shell_entry_type(apache_t.$1_script)
    domain_entry_file(apache_t.$1_script,apache_t.$1_script_exec)

    # The following three are the only areas that
    # scripts can read, read/write, or append to
    type apache_t.$1_script_ro alias httpd_$1_script_ro_t, httpdcontent; 
# customizable
    files_type(apache_t.$1_script_ro)

    type apache_t.$1_script_rw alias httpd_$1_script_rw_t, httpdcontent; 
# customizable
    files_type(apache_t.$1_script_rw)

    type apache_t.$1_script_ra alias httpd_$1_script_ra_t, httpdcontent; 
# customizable
    files_type(apache_t.$1_script_ra)

    # metapolicy labeling for these rules
    type $1_apache_policy_t, apache_content_policy_type;

    ##############################
    #
    # Local policy
    #

    allow apache_t.daemon apache_t.$1_htaccess:file read_file_perms;

    domtrans_pattern(apache_t.suexec, apache_t.$1_script_exec, 
apache_t.$1_script)

    allow apache_t.suexec { apache_t.$1_content apache_t.$1_script_ro 
apache_t.$1_script_rw apache_t.$1_script_exec }:dir search_dir_perms;

    allow apache_t.$1_script self:fifo_file rw_file_perms;
    allow apache_t.$1_script self:unix_stream_socket connectto;

    allow apache_t.$1_script apache_t.daemon:fifo_file write;
    # apache should set close-on-exec
    dontaudit apache_t.$1_script apache_t.daemon:unix_stream_socket { 
read write };

    # Allow the script process to search the cgi directory, and users 
directory
    allow apache_t.$1_script apache_t.$1_content:dir search_dir_perms;

    append_files_pattern(apache_t.$1_script,apache_t.log,apache_t.log)
    logging_search_logs(apache_t.$1_script)

    can_exec(apache_t.$1_script, apache_t.$1_script_exec)
    allow apache_t.$1_script apache_t.$1_script_exec:dir search_dir_perms;

    allow apache_t.$1_script apache_t.$1_script_ra:dir { list_dir_perms 
add_entry_dir_perms };
    
read_files_pattern(apache_t.$1_script,apache_t.$1_script_ra,apache_t.$1_script_ra)
    
append_files_pattern(apache_t.$1_script,apache_t.$1_script_ra,apache_t.$1_script_ra)
    
read_lnk_files_pattern(apache_t.$1_script,apache_t.$1_script_ra,apache_t.$1_script_ra)

    allow apache_t.$1_script apache_t.$1_script_ro:dir list_dir_perms;
    
read_files_pattern(apache_t.$1_script,apache_t.$1_script_ro,apache_t.$1_script_ro)
    
read_lnk_files_pattern(apache_t.$1_script,apache_t.$1_script_ro,apache_t.$1_script_ro)

    
manage_dirs_pattern(apache_t.$1_script,apache_t.$1_script_rw,apache_t.$1_script_rw)
    
manage_files_pattern(apache_t.$1_script,apache_t.$1_script_rw,apache_t.$1_script_rw)
    
manage_lnk_files_pattern(apache_t.$1_script,apache_t.$1_script_rw,apache_t.$1_script_rw)
    
manage_fifo_files_pattern(apache_t.$1_script,apache_t.$1_script_rw,apache_t.$1_script_rw)
    
manage_sock_files_pattern(apache_t.$1_script,apache_t.$1_script_rw,apache_t.$1_script_rw)
    files_tmp_filetrans(apache_t.$1_script,apache_t.$1_script_rw,{ dir 
file lnk_file sock_file fifo_file })

    kernel_dontaudit_search_sysctl(apache_t.$1_script)
    kernel_dontaudit_search_kernel_sysctl(apache_t.$1_script)

    dev_read_rand(apache_t.$1_script)
    dev_read_urand(apache_t.$1_script)

    corecmd_exec_all_executables(apache_t.$1_script)

    files_exec_etc_files(apache_t.$1_script)
    files_read_etc_files(apache_t.$1_script)
    files_search_home(apache_t.$1_script)

    libs_use_ld_so(apache_t.$1_script)
    libs_use_shared_libs(apache_t.$1_script)
    libs_exec_ld_so(apache_t.$1_script)
    libs_exec_lib_files(apache_t.$1_script)

    miscfiles_read_fonts(apache_t.$1_script)
    miscfiles_read_public_files(apache_t.$1_script)

    seutil_dontaudit_search_config(apache_t.$1_script)

    tunable_policy(`httpd_enable_cgi && httpd_unified',`
        allow apache_t.$1_script httpdcontent:file entrypoint;

        manage_dirs_pattern(apache_t.$1_script,httpdcontent,httpdcontent)
        manage_files_pattern(apache_t.$1_script,httpdcontent,httpdcontent)
        
manage_lnk_files_pattern(apache_t.$1_script,httpdcontent,httpdcontent)
        can_exec(apache_t.$1_script, httpdcontent)
    ')

    tunable_policy(`allow_httpd_$1_script_anon_write',`
        miscfiles_manage_public_files(apache_t.$1_script)
    ')

    # Allow the web server to run scripts and serve pages
    tunable_policy(`httpd_builtin_scripting',`
        
manage_dirs_pattern(apache_t.daemon,apache_t.$1_script_rw,apache_t.$1_script_rw)
        
manage_files_pattern(apache_t.daemon,apache_t.$1_script_rw,apache_t.$1_script_rw)
        
manage_lnk_files_pattern(apache_t.daemon,apache_t.$1_script_rw,apache_t.$1_script_rw)
        
rw_sock_files_pattern(apache_t.daemon,apache_t.$1_script_rw,apache_t.$1_script_rw)

        allow apache_t.daemon apache_t.$1_script_ra:dir { list_dir_perms 
add_entry_dir_perms };
        
read_files_pattern(apache_t.daemon,apache_t.$1_script_ra,apache_t.$1_script_ra)
        
append_files_pattern(apache_t.daemon,apache_t.$1_script_ra,apache_t.$1_script_ra)
        
read_lnk_files_pattern(apache_t.daemon,apache_t.$1_script_ra,apache_t.$1_script_ra)

        allow apache_t.daemon apache_t.$1_script_ro:dir list_dir_perms;
        
read_files_pattern(apache_t.daemon,apache_t.$1_script_ro,apache_t.$1_script_ro)
        
read_lnk_files_pattern(apache_t.daemon,apache_t.$1_script_ro,apache_t.$1_script_ro)

        allow apache_t.daemon apache_t.$1_content:dir list_dir_perms;
        
read_files_pattern(apache_t.daemon,apache_t.$1_content,apache_t.$1_content)
        
read_lnk_files_pattern(apache_t.daemon,apache_t.$1_content,apache_t.$1_content)
    ')

    tunable_policy(`httpd_enable_cgi',`
        allow apache_t.$1_script apache_t.$1_script_exec:file entrypoint;

        # privileged users run the script:
        domtrans_pattern(httpd_exec_scripts, apache_t.$1_script_exec, 
apache_t.$1_script)

        # apache runs the script:
        domtrans_pattern(apache_t.daemon, apache_t.$1_script_exec, 
apache_t.$1_script)

        allow apache_t.daemon apache_t.$1_script:process { signal 
sigkill sigstop };
        allow apache_t.daemon apache_t.$1_script_exec:dir list_dir_perms;

        allow apache_t.$1_script self:process { setsched signal_perms };
        allow apache_t.$1_script self:unix_stream_socket 
create_stream_socket_perms;

        allow apache_t.$1_script apache_t.daemon:fd use;
        allow apache_t.$1_script apache_t.daemon:process sigchld;

        kernel_read_system_state(apache_t.$1_script)

        dev_read_urand(apache_t.$1_script)

        fs_getattr_xattr_fs(apache_t.$1_script)

        files_read_etc_runtime_files(apache_t.$1_script)
        files_read_usr_files(apache_t.$1_script)

        libs_read_lib_files(apache_t.$1_script)

        miscfiles_read_localization(apache_t.$1_script)
    ')

    tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
        allow apache_t.$1_script self:tcp_socket create_stream_socket_perms;
        allow apache_t.$1_script self:udp_socket create_socket_perms;

        corenet_non_ipsec_sendrecv(apache_t.$1_script)
        corenet_tcp_sendrecv_all_if(apache_t.$1_script)
        corenet_udp_sendrecv_all_if(apache_t.$1_script)
        corenet_tcp_sendrecv_all_nodes(apache_t.$1_script)
        corenet_udp_sendrecv_all_nodes(apache_t.$1_script)
        corenet_tcp_sendrecv_all_ports(apache_t.$1_script)
        corenet_udp_sendrecv_all_ports(apache_t.$1_script)
        corenet_tcp_connect_postgresql_port(apache_t.$1_script)
        corenet_tcp_connect_mysqld_port(apache_t.$1_script)
        corenet_sendrecv_postgresql_client_packets(apache_t.$1_script)
        corenet_sendrecv_mysqld_client_packets(apache_t.$1_script)

        sysnet_read_config(apache_t.$1_script)
    ')

    tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
        allow apache_t.$1_script self:tcp_socket create_stream_socket_perms;
        allow apache_t.$1_script self:udp_socket create_socket_perms;

        corenet_non_ipsec_sendrecv(apache_t.$1_script)
        corenet_tcp_sendrecv_all_if(apache_t.$1_script)
        corenet_udp_sendrecv_all_if(apache_t.$1_script)
        corenet_tcp_sendrecv_all_nodes(apache_t.$1_script)
        corenet_udp_sendrecv_all_nodes(apache_t.$1_script)
        corenet_tcp_sendrecv_all_ports(apache_t.$1_script)
        corenet_udp_sendrecv_all_ports(apache_t.$1_script)
        corenet_tcp_connect_all_ports(apache_t.$1_script)
        corenet_sendrecv_all_client_packets(apache_t.$1_script)

        sysnet_read_config(apache_t.$1_script)
    ')

    optional_policy(`
        mta_send_mail(apache_t.$1_script)
    ')

    optional_policy(`
        tunable_policy(`httpd_enable_cgi && allow_ypbind',`
            nis_use_ypbind_uncond(apache_t.$1_script)
        ')
    ')

    optional_policy(`
        nscd_socket_use(apache_t.$1_script)
    ')
')

#######################################
## <summary>
##    The per role template for the apache module.
## </summary>
## <desc>
##    <p>
##    This template creates types used for web pages
##    and web cgi to be used from the user home directory.
##    </p>
##    <p>
##    This template is invoked automatically for each user, and
##    generally does not need to be invoked directly
##    by policy writers.
##    </p>
## </desc>
## <param name="userdomain_prefix">
##    <summary>
##    The prefix of the user domain (e.g., user
##    is the prefix for user_t).
##    </summary>
## </param>
## <param name="user_domain">
##    <summary>
##    The type of the user domain.
##    </summary>
## </param>
## <param name="user_role">
##    <summary>
##    The role associated with the user domain.
##    </summary>
## </param>
#
template(`apache_per_role_template', `
    gen_require(`
        attribute httpdcontent, httpd_script_domains;
        attribute httpd_exec_scripts;
        type apache_t.daemon, apache_t.suexec, apache_t.log;

        # metapolicy requirements
        class policy.class { use add_perm };
        class policy.user { add add_role };
        class policy.role { add use };
        class policy.type { add use };
        class policy.attribute { add add_type };
    ')

    apache_content_template($1)

    typeattribute apache_t.$1_content httpd_script_domains;
    userdom_user_home_content($1,apache_t)
    userdom_user_home_content($1,apache_t.$1_content)

    role $3 types apache_t.$1_script;

    ##############################
    #
    # Local policy
    #

    manage_dirs_pattern($2,apache_t,apache_t)
    manage_files_pattern($2,apache_t,apache_t)
    manage_lnk_files_pattern($2,apache_t,apache_t)
    relabel_dirs_pattern($2,apache_t,apache_t)
    relabel_files_pattern($2,apache_t,apache_t)
    relabel_lnk_files_pattern($2,apache_t,apache_t)

    allow $2 apache_t.$1_content:{ dir file lnk_file } { relabelto 
relabelfrom };

    allow $2 apache_t.$1_htaccess:file { manage_file_perms relabelto 
relabelfrom };

    manage_dirs_pattern($2,apache_t.$1_script_ra,apache_t.$1_script_ra)
    manage_files_pattern($2,apache_t.$1_script_ra,apache_t.$1_script_ra)
    manage_lnk_files_pattern($2,apache_t.$1_script_ra,apache_t.$1_script_ra)
    relabel_dirs_pattern($2,apache_t.$1_script_ra,apache_t.$1_script_ra)
    relabel_files_pattern($2,apache_t.$1_script_ra,apache_t.$1_script_ra)
    
relabel_lnk_files_pattern($2,apache_t.$1_script_ra,apache_t.$1_script_ra)

    manage_dirs_pattern($2,apache_t.$1_script_ro,apache_t.$1_script_ro)
    manage_files_pattern($2,apache_t.$1_script_ro,apache_t.$1_script_ro)
    manage_lnk_files_pattern($2,apache_t.$1_script_ro,apache_t.$1_script_ro)
    relabel_dirs_pattern($2,apache_t.$1_script_ro,apache_t.$1_script_ro)
    relabel_files_pattern($2,apache_t.$1_script_ro,apache_t.$1_script_ro)
    
relabel_lnk_files_pattern($2,apache_t.$1_script_ro,apache_t.$1_script_ro)

    manage_dirs_pattern($2,apache_t.$1_script_rw,apache_t.$1_script_rw)
    manage_files_pattern($2,apache_t.$1_script_rw,apache_t.$1_script_rw)
    manage_lnk_files_pattern($2,apache_t.$1_script_rw,apache_t.$1_script_rw)
    relabel_dirs_pattern($2,apache_t.$1_script_rw,apache_t.$1_script_rw)
    relabel_files_pattern($2,apache_t.$1_script_rw,apache_t.$1_script_rw)
    
relabel_lnk_files_pattern($2,apache_t.$1_script_rw,apache_t.$1_script_rw)

    manage_dirs_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
    manage_files_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
    
manage_lnk_files_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
    relabel_dirs_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
    
relabel_files_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
    
relabel_lnk_files_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)

    tunable_policy(`httpd_enable_cgi',`
        # If a user starts a script by hand it gets the proper context
        # cjp: this should be domtrans_pattern, but it gets a
        # type transition conflict
        domain_transition_pattern($2, apache_t, apache_t)
        allow apache_t $2:fd use;
        allow apache_t $2:fifo_file rw_file_perms;
        allow apache_t $2:process sigchld;

        domtrans_pattern($2, apache_t.$1_script_exec, apache_t.$1_script)
    ')

    tunable_policy(`httpd_enable_cgi && httpd_unified',`
        allow apache_t.$1_script httpdcontent:file entrypoint;
        # cjp: this should be domtrans_pattern, but it gets a
        # type transition conflict
        domain_transition_pattern($2, httpdcontent, apache_t)
        allow apache_t $2:fd use;
        allow apache_t $2:fifo_file rw_file_perms;
        allow apache_t $2:process sigchld;

        domtrans_pattern($2, httpdcontent, apache_t.$1_script)
    ')

    # allow accessing files/dirs below the users home dir
    tunable_policy(`httpd_enable_homedirs',`
        userdom_search_user_home_dirs($1,apache_t.daemon)
        userdom_search_user_home_dirs($1,apache_t.suexec)
        userdom_search_user_home_dirs($1,apache_t.$1_script)
    ')

    ##############################
    #
    # Local metapolicy
    #

    allow $2 $1_apache_policy_t:policy.class { use add_perm };
    allow $2 $1_apache_policy_t:policy.user { add add_role };
    allow $2 $1_apache_policy_t:policy.role { add use };
    allow $2 $1_apache_policy_t:policy.type { add use };
    allow $2 $1_apache_policy_t:policy.attribute { add add_type };
')

########################################
## <summary>
##    Read httpd user scripts executables.
## </summary>
## <param name="domain_prefix">
##    <summary>
##    Prefix of the domain. Example, user would be
##    the prefix for the uder_t domain.
##    </summary>
## </param>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
template(`apache_read_user_scripts',`
    gen_require(`
        type apache_t,apache_t.$1_script_exec;
    ')

    allow $2 apache_t:dir list_dir_perms;
    read_files_pattern($2,apache_t,apache_t)
    read_lnk_files_pattern($2,apache_t,apache_t)

    allow $2 apache_t.$1_script_exec:dir list_dir_perms;
    read_files_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
    
read_lnk_files_pattern($2,apache_t.$1_script_exec,apache_t.$1_script_exec)
')

########################################
## <summary>
##    Read user web content.
## </summary>
## <param name="domain_prefix">
##    <summary>
##    Prefix of the domain. Example, user would be
##    the prefix for the uder_t domain.
##    </summary>
## </param>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
template(`apache_read_user_content',`
    gen_require(`
        type apache_t,apache_t.$1_content;
    ')

    allow $2 apache_t:dir list_dir_perms;
    read_files_pattern($2,apache_t,apache_t)
    read_lnk_files_pattern($2,apache_t,apache_t)

    allow $2 apache_t.$1_content:dir list_dir_perms;
    read_files_pattern($2,apache_t.$1_content,apache_t.$1_content)
    read_lnk_files_pattern($2,apache_t.$1_content,apache_t.$1_content)
')

########################################
## <summary>
##    Transition to apache.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_domtrans',`
    gen_require(`
        type apache_t,apache_t.daemon, apache_t.daemon_exec;
    ')

    corecmd_search_sbin($1)
    domtrans_pattern($1,apache_t,apache_t)
    domtrans_pattern($1,apache_t.daemon_exec,apache_t.daemon)
')

########################################
## <summary>
##    Send a null signal to apache.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_signull',`
    gen_require(`
        type apache_t,apache_t.daemon;
    ')

    allow $1 apache_t:process signull;
    allow $1 apache_t.daemon:process signull;
')

########################################
## <summary>
##    Send a SIGCHLD signal to apache.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_sigchld',`
    gen_require(`
        type apache_t,apache_t.daemon;
    ')

    allow $1 apache_t:process sigchld;
    allow $1 apache_t.daemon:process sigchld;
')

########################################
## <summary>
##    Inherit and use file descriptors from Apache.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_use_fds',`
    gen_require(`
        type apache_t,apache_t.daemon;
    ')

    allow $1 apache_t:fd use;
    allow $1 apache_t.daemon:fd use;
')

########################################
## <summary>
##    Do not audit attempts to read and write Apache
##    unix domain stream sockets.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_dontaudit_rw_stream_sockets',`
    gen_require(`
        type apache_t.daemon;
    ')

    dontaudit $1 apache_t.daemon:unix_stream_socket { read write };
')

########################################
## <summary>
##    Do not audit attempts to read and write Apache
##    TCP sockets.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_dontaudit_rw_tcp_sockets',`
    gen_require(`
        type apache_t,apache_t.daemon;
    ')

    dontaudit $1 apache_t.daemon:tcp_socket { read write };
')

########################################
## <summary>
##    Create, read, write, and delete all web content.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
## <rolecap/>
#
interface(`apache_manage_all_content',`
    gen_require(`
        attribute httpdcontent, httpd_script_exec_type;
    ')

    manage_dirs_pattern($1,httpdcontent,httpdcontent)
    manage_files_pattern($1,httpdcontent,httpdcontent)
    manage_lnk_files_pattern($1,httpdcontent,httpdcontent)

    manage_dirs_pattern($1,httpd_script_exec_type,httpd_script_exec_type)
    manage_files_pattern($1,httpd_script_exec_type,httpd_script_exec_type)
    
manage_lnk_files_pattern($1,httpd_script_exec_type,httpd_script_exec_type)
')

########################################
## <summary>
##    Allow the specified domain to read
##    and write Apache cache files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_rw_cache_files',`
    gen_require(`
        type apache_t,apache_t.daemon_cache;
    ')

    allow $1 apache_t:file rw_file_perms;
    allow $1 apache_t.daemon_cache:file rw_file_perms;
')

########################################
## <summary>
##    Allow the specified domain to read
##    apache configuration files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
## <rolecap/>
#
interface(`apache_read_config',`
    gen_require(`
        type apache_t,apache_t.config;
    ')

    allow $1 apache_t:dir list_dir_perms;
    read_files_pattern($1,apache_t,apache_t)
    read_lnk_files_pattern($1,apache_t,apache_t)

    files_search_etc($1)
    allow $1 apache_t.config:dir list_dir_perms;
    read_files_pattern($1,apache_t.config,apache_t.config)
    read_lnk_files_pattern($1,apache_t.config,apache_t.config)
')

########################################
## <summary>
##    Allow the specified domain to manage
##    apache configuration files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_manage_config',`
    gen_require(`
        type apache_t,apache_t.config;
    ')

    manage_dirs_pattern($1,apache_t,apache_t)
    manage_files_pattern($1,apache_t,apache_t)
    read_lnk_files_pattern($1,apache_t,apache_t)

    files_search_etc($1)
    manage_dirs_pattern($1,apache_t.config,apache_t.config)
    manage_files_pattern($1,apache_t.config,apache_t.config)
    read_lnk_files_pattern($1,apache_t.config,apache_t.config)
')

########################################
## <summary>
##    Execute the Apache helper program with
##    a domain transition.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_domtrans_helper',`
    gen_require(`
        type apache_t,apache_t.helper,apache_t.helper_exec;
    ')

    domain_transition_pattern($1,apache_t,apache_t)
    allow apache_t $1:fd use;
    allow apache_t $1:fifo_file rw_file_perms;
    allow apache_t $1:process sigchld;

    corecmd_search_sbin($1)
    domtrans_pattern($1,apache_t.helper_exec,apache_t.helper)
')

########################################
## <summary>
##    Execute the Apache helper program with
##    a domain transition, and allow the
##    specified role the dmidecode domain.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
## <param name="role">
##    <summary>
##    The role to be allowed the dmidecode domain.
##    </summary>
## </param>
## <param name="terminal">
##    <summary>
##    The type of the terminal allow the dmidecode domain to use.
##    </summary>
## </param>
## <rolecap/>
#
interface(`apache_run_helper',`
    gen_require(`
        type apache_t,apache_t.helper;
    ')

    apache_domtrans_helper($1)
    role $2 types apache_t.helper;

    allow apache_t $3:chr_file rw_term_perms;
    allow apache_t.helper $3:chr_file rw_term_perms;
')

########################################
## <summary>
##    Allow the specified domain to read
##    apache log files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
## <rolecap/>
#
interface(`apache_read_log',`
    gen_require(`
        type apache_t,apache_t.log;
    ')

    allow $1 apache_t:dir list_dir_perms;
    read_files_pattern($1,apache_t,apache_t)
    read_lnk_files_pattern($1,apache_t,apache_t)

    logging_search_logs($1)
    allow $1 apache_t.log:dir list_dir_perms;
    read_files_pattern($1,apache_t.log,apache_t.log)
    read_lnk_files_pattern($1,apache_t.log,apache_t.log)
')

########################################
## <summary>
##    Allow the specified domain to append
##    to apache log files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_append_log',`
    gen_require(`
        type apache_t,apache_t.log;
    ')

    allow $1 apache_t:dir list_dir_perms;
    append_files_pattern($1,apache_t,apache_t)

    logging_search_logs($1)
    allow $1 apache_t.log:dir list_dir_perms;
    append_files_pattern($1,apache_t.log,apache_t.log)
')

########################################
## <summary>
##    Do not audit attempts to append to the
##    Apache logs.
## </summary>
## <param name="domain">
##    <summary>
##    Domain to not audit.
##    </summary>
## </param>
#
interface(`apache_dontaudit_append_log',`
    gen_require(`
        type apache_t,apache_t.log;
    ')

    dontaudit $1 apache_t.log:file { getattr append };
')

########################################
## <summary>
##    Allow the specified domain to manage
##    to apache log files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_manage_log',`
    gen_require(`
        type apache_t,apache_t.log;
    ')

    manage_dirs_pattern($1,apache_t,apache_t)
    manage_files_pattern($1,apache_t,apache_t)
    read_lnk_files_pattern($1,apache_t,apache_t)

    logging_search_logs($1)
    manage_dirs_pattern($1,apache_t.log,apache_t.log)
    manage_files_pattern($1,apache_t.log,apache_t.log)
    read_lnk_files_pattern($1,apache_t.log,apache_t.log)
')

########################################
## <summary>
##    Do not audit attempts to search Apache
##    module directories.
## </summary>
## <param name="domain">
##    <summary>
##    Domain to not audit.
##    </summary>
## </param>
#
interface(`apache_dontaudit_search_modules',`
    gen_require(`
        type apache_t,apache_t.daemon_modules;
    ')

    dontaudit $1 apache_t.daemon_modules:dir search_dir_perms;
')

########################################
## <summary>
##    Allow the specified domain to list
##    the contents of the apache modules
##    directory.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_list_modules',`
    gen_require(`
        type apache_t,apache_t.daemon_modules;
    ')

    allow $1 apache_t:dir list_dir_perms;
    allow $1 apache_t.daemon_modules:dir list_dir_perms;
')

########################################
## <summary>
##    Allow the specified domain to execute
##    apache modules.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_exec_modules',`
    gen_require(`
        type apache_t,apache_t.daemon_modules;
    ')

    allow $1 apache_t:dir list_dir_perms;
    allow $1 apache_t:lnk_file read_file_perms;
    can_exec($1,apache_t)

    allow $1 apache_t.daemon_modules:dir list_dir_perms;
    allow $1 apache_t.daemon_modules:lnk_file read_file_perms;
    can_exec($1,apache_t.daemon_modules)
')

########################################
## <summary>
##    Execute a domain transition to run httpd_rotatelogs.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_domtrans_rotatelogs',`
    gen_require(`
        type apache_t,apache_t.rotatelogs, apache_t.rotatelogs_exec;
    ')

    domain_transition_pattern($1,apache_t,apache_t)
    domtrans_pattern($1,apache_t.rotatelogs_exec,apache_t.rotatelogs)
')

########################################
## <summary>
##    Allow the specified domain to manage
##    apache system content files.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
## <rolecap/>
#
# Note that apache_t.sys_content is found in /var, /etc, /srv and /usr
interface(`apache_manage_sys_content',`
    gen_require(`
        type apache_t,apache_t.sys_content;
    ')

    manage_dirs_pattern($1,apache_t,apache_t)
    manage_files_pattern($1,apache_t,apache_t)
    manage_lnk_files_pattern($1,apache_t,apache_t)

    files_search_var($1)
    manage_dirs_pattern($1,apache_t.sys_content,apache_t.sys_content)
    manage_files_pattern($1,apache_t.sys_content,apache_t.sys_content)
    manage_lnk_files_pattern($1,apache_t.sys_content,apache_t.sys_content)
')

########################################
## <summary>
##    Execute all web scripts in the system
##    script domain.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
# cjp: this interface specifically added to allow
# sysadm_t to run scripts
interface(`apache_domtrans_sys_script',`
    gen_require(`
        attribute httpdcontent;
        type apache_t,apache_t.sys_script;
    ')

    tunable_policy(`httpd_enable_cgi && httpd_unified',`
        domain_transition_pattern($1, httpdcontent, apache_t)
        domtrans_pattern($1, httpdcontent, apache_t.sys_script)
    ')
')

########################################
## <summary>
##    Do not audit attempts to read and write Apache
##    system script unix domain stream sockets.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_dontaudit_rw_sys_script_stream_sockets',`
    gen_require(`
        type apache_t,apache_t.sys_script;
    ')

    dontaudit $1 apache_t.sys_script:unix_stream_socket { read write };
')

########################################
## <summary>
##    Execute all user scripts in the user
##    script domain.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_domtrans_all_scripts',`
    gen_require(`
        attribute httpd_exec_scripts;
    ')

    typeattribute $1 httpd_exec_scripts;
')

########################################
## <summary>
##    Execute all user scripts in the user
##    script domain.  Add user script domains
##    to the specified role.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
## <param name="role">
##    <summary>
##    The role to be allowed the script domains.
##    </summary>
## </param>
#
# cjp: this is missing the terminal since scripts
# do not output to the terminal
interface(`apache_run_all_scripts',`
    gen_require(`
        attribute httpd_exec_scripts, httpd_script_domains;
    ')

    role $2 types httpd_script_domains;
    apache_domtrans_all_scripts($1)
')

########################################
## <summary>
##    Allow the specified domain to read
##    apache squirrelmail data.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_read_squirrelmail_data',`
    gen_require(`
        type apache_t,apache_t.squirrelmail;
    ')

    allow $1 apache_t:file { getattr read };
    allow $1 apache_t.squirrelmail:file { getattr read };
')

########################################
## <summary>
##    Allow the specified domain to append
##    apache squirrelmail data.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_append_squirrelmail_data',`
    gen_require(`
        type apache_t,apache_t.squirrelmail;
    ')

    allow $1 apache_t:file { getattr append };
    allow $1 apache_t.squirrelmail:file { getattr append };
')

########################################
## <summary>
##    Search apache system content.
## </summary>
## <param name="domain">
##    <summary>
##    Domain allowed access.
##    </summary>
## </param>
#
interface(`apache_search_sys_content',`
    gen_require(`
        type apache_t,apache_t.sys_content;
    ')

    allow $1 apache_t:dir search_dir_perms;
    allow $1 apache_t.sys_content:dir search_dir_perms;
')

########################################
## <summary>
##    Read apache system content.
## </summary>
## <param name="domain">
##    <summary>
##    Domain to not audit.
##    </summary>
## </param>
#
interface(`apache_read_sys_content',`
    gen_require(`
        type apache_t,apache_t.sys_content;
    ')

    allow $1 apache_t:dir list_dir_perms;
    read_files_pattern($1,apache_t,apache_t)
    read_lnk_files_pattern($1,apache_t,apache_t)

    allow $1 apache_t.sys_content:dir list_dir_perms;
    read_files_pattern($1,apache_t.sys_content,apache_t.sys_content)
    read_lnk_files_pattern($1,apache_t.sys_content,apache_t.sys_content)
')

########################################
## <summary>
##    Search system script state directory.
## </summary>
## <param name="domain">
##    <summary>
##    Domain to not audit.
##    </summary>
## </param>
#
interface(`apache_search_sys_script_state',`
    gen_require(`
        type apache_t,apache_t.sys_script;
    ')

    allow $1 apache_t:dir search_dir_perms;
    allow $1 apache_t.sys_script:dir search_dir_perms;
')



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
