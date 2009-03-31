Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VEfSIV015055
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 10:41:28 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VEfROw023546
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 14:41:27 GMT
Received: by wa-out-1112.google.com with SMTP id m33so1439844wag.18
        for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 07:41:26 -0700 (PDT)
Message-ID: <49D22BEA.8020403@gmail.com>
Date: Tue, 31 Mar 2009 10:42:50 -0400
From: m <maximilianbianco@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: request for review of httpd-related Boolean definitions
References: <20090331151638.770627cb@redhat.com> <1238495418.3465.69.camel@notebook2.grift.internal>
In-Reply-To: <1238495418.3465.69.camel@notebook2.grift.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Tue, 2009-03-31 at 15:16 +1000, Scott Radvan wrote:
> 
> I am going to use this thread to just share any thoughts i have with regards to this
>> o  allow_httpd_anon_write
>> This Boolean is off by default, allowing httpd only read access to
>> files labeled with the public_content_rw_t type. Enabling this Boolean
>> will allow httpd to write to files labeled with the public_content_rw_t
>> type, such as a public directory containing files for a public file
>> transfer service. 
> 
> 
>> o  allow_httpd_mod_auth_ntlm_winbind
>> This Boolean is off by default. Enabling it will allow access to NTLM
>> and Winbind authentication mechanisms via the mod_auth_ntlm_winbind
>> module in httpd. 
>>
>> o  allow_httpd_mod_auth_pam
>> This Boolean is off by default. Enabling it will allow access to PAM
>> authentication mechanisms via the mod_auth_pam module in httpd.
>>
>> o  allow_httpd_sys_script_anon_write
>> This Boolean is off by default. It defines whether or not HTTP scripts
>> are allowed write access to files labeled with the public_content_rw_t
>> type, as used in a public file transfer service.
>>
>> o  httpd_builtin_scripting 
>> This Boolean is on by default, allowing httpd scripting. Having this
>> Boolean enabled is often required for PHP content.
> 
> It allows: 
> 
> 1. httpd_t to manage templated httpd rw content,
> 2. httpd_t to read templated httpd ra content,
> 3. httpd_t to read templated httpd content,
> 
> # Allow the web server to run scripts and serve pages
> tunable_policy(`httpd_builtin_scripting',`
> 	manage_dirs_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 	manage_files_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 	manage_lnk_files_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 	rw_sock_files_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 
> 	allow httpd_t httpd_$1_content_ra_t:dir { list_dir_perms
> add_entry_dir_perms };
> 	read_files_pattern(httpd_t, httpd_$1_content_ra_t, httpd_
> $1_content_ra_t)
> 	append_files_pattern(httpd_t, httpd_$1_content_ra_t, httpd_
> $1_content_ra_t)
> 	read_lnk_files_pattern(httpd_t, httpd_$1_content_ra_t, httpd_
> $1_content_ra_t)
> 
> 	allow httpd_t httpd_$1_content_t:dir list_dir_perms;
> 	read_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> 	read_lnk_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> 
> 	allow httpd_t httpd_$1_content_t:dir list_dir_perms;
> 	read_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> 	read_lnk_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> ')
> 
> I think this is a bug in policy or atleast that this boolean is too
> coarse
> 
> with this boolean set to false: httpd_t cannot read
> httpd_user_content_t. Basically what it means is that you cannot use
> httpd userdirs (httpd_enable_userdirs) without scripting enabled.
> 
>> o  httpd_can_network_connect
>> This Boolean is off by default, preventing HTTP scripts and modules
>> from initiating a connection to a network or remote port. Turn this
>> Boolean on to allow this access. 
>>
>> o  httpd_can_network_connect_db
>> This Boolean is off by default, preventing HTTP scripts and modules
>> from initiating a connection to database servers. Turn this Boolean on
>> to allow this access. 
>>
>> o  httpd_can_network_relay
>> Turn this Boolean on when httpd is being used as a forward or
>> reverse proxy. 
>>
>> o  httpd_can_sendmail
>> This Boolean is off by default, preventing HTTP modules from sending
>> mail. This can prevent spam attacks should a vulnerability be found in
>> httpd. Turn this Boolean on to allow HTTP modules to send mail.
>>
>> o  httpd_dbus_avahi
>> This Boolean is off by default, denying httpd access to the avahi
>> service via dbus. Turn this Boolean on to allow this access.
>>
>> o  httpd_enable_cgi
>> By default, SELinux prevents httpd from executing CGI scripts. Turn
>> this Boolean on to allow httpd to execute CGI scripts (CGI scripts must
>> be labeled with the httpd_sys_script_exec_t type).
> 
> 1. It creates an entrypoint for templated httpd domains and their
> executable files
> 
> 2. It allow httpd_t to domain transition to templated httpd domains
> 
> 3. it allows templated httpd domains basic permissions to run.
> 
> tunable_policy(`httpd_enable_cgi',`
> 	allow httpd_$1_script_t httpd_$1_script_exec_t:file entrypoint;
> 
> 	# privileged users run the script:
> 	domtrans_pattern(httpd_exec_scripts, httpd_$1_script_exec_t, httpd_
> $1_script_t)
> 
> 	allow httpd_exec_scripts httpd_$1_script_exec_t:file read_file_perms;
> 
> 	# apache runs the script:
> 	domtrans_pattern(httpd_t, httpd_$1_script_exec_t, httpd_$1_script_t)
> 
> 	allow httpd_t httpd_$1_script_exec_t:file read_file_perms;
> 
> 	allow httpd_t httpd_$1_script_t:process { signal sigkill sigstop };
> 	allow httpd_t httpd_$1_script_exec_t:dir list_dir_perms;
> 
> 	allow httpd_$1_script_t self:process { setsched signal_perms };
> 	allow httpd_$1_script_t self:unix_stream_socket
> create_stream_socket_perms;
> 
> 	allow httpd_$1_script_t httpd_t:fd use;
> 	allow httpd_$1_script_t httpd_t:process sigchld;
> 
> 	kernel_read_system_state(httpd_$1_script_t)
> 
> 	dev_read_urand(httpd_$1_script_t)
> 
> 	fs_getattr_xattr_fs(httpd_$1_script_t)
> 
> 	files_read_etc_runtime_files(httpd_$1_script_t)
> 	files_read_usr_files(httpd_$1_script_t)
> 
> 	libs_read_lib_files(httpd_$1_script_t)
> 
> 	miscfiles_read_localization(httpd_$1_script_t)
> 	')
> 
> So it is not only for httpd_sys_script_exec_t but for example also
> httpd_user_script_exec_t or any other httpd domain create with
> apache_content_template or declared as apache_domain()
> 
> Also it is specifically responsible for domain transitions.
> 
> 
>> o  httpd_enable_ftp_server
>> Turning this Boolean on will allow httpd to listen on the FTP port and
>> act as an FTP server. 
>>
>> o  httpd_enable_homedirs
>> By default, SELinux prevents httpd from accessing user home
>> directories. Turn this Boolean on to allow httpd access to user home
>> directories, for example, /home/*/public_html/. 
> 
> All it does is allow httpd_t to search /home/*/ for httpd content
> 
> tunable_policy(`httpd_enable_homedirs',`
> 	userdom_search_user_home_dirs(httpd_t)
> 	userdom_search_user_home_dirs(httpd_suexec_t)
> 	userdom_search_user_home_dirs(httpd_user_script_t)
> ')
> 
> This does not actually allow httpd_t to read httpd_user_content_t
> ( requires the httpd_builtin_scripting boolean to be set )
> 
>> o  httpd_execmem
> 
> tunable_policy(`httpd_execmem',`
> 	allow httpd_t self:process { execmem execstack };
> 	allow httpd_sys_script_t self:process { execmem execstack };
> 	allow httpd_suexec_t self:process { execmem execstack };
> ') 
> 
> Note that is also allows execstack.
> Note that it allows it also for httpd_sys_script_t
> Note that it *does not* allow it for httpd_user_script_t ( or any other
> templated httpd script)

I think here he is looking to understand what exactly execmem allows. My 
understanding is that it allows memory to be both writeable and 
executable which is a no no but often required because of some 
questionable programming practices. Please correct me if I am wrong but 
if the above is correct then this allows the webserver to make memory 
both writeable and executable, something that should be avoided.

>> o  httpd_ssi_exec
>> Off by default, this Boolean makes sure that httpd can only execute
>> shell scripts that have the shell_exec_t type assigned to them.
>> Enabling this Boolean will allow httpd to execute any script.
>>
>> o  httpd_tty_comm
>> This Boolean defines whether or not httpd is allowed access to the
>> controlling terminal. Usually this access is not required; however in
>> cases such as configuring an SSL certificate file, terminal access is
>> required to display and process a password prompt. 
>>
>> o  httpd_unified
>> This Boolean is off by default, turning it on will allow all httpd
>> executables to have full access to all content labeled with http file
>> context. Leaving it off ensures that one httpd service can not
>> interfere with another, limiting the opportunity for privilege
>> escalation vulnerability.
> 
> I think this boolean needs a good thorough review.
> I do not think it works properly but i might be wrong
> 
>> o  httpd_use_cifs 
>> Turn this Boolean on to allow httpd access to files on CIFS file
>> systems that are labeled with the cifs_t type, such as file systems
>> mounted via Samba. 
>>
>> o  httpd_use_nfs
>> Turn this Boolean on to allow httpd access to files on NFS file systems
>> that are labeled with the nfs_t type, such as file systems mounted via
>> NFS.
>>
>>
>> All comments are more than welcome! Again, thank you.
>>
>>
>>
>> [1] - https://fedorahosted.org/managing-confined-services/
>> [2] - http://people.redhat.com/drepper/selinux-mem.html
>>
>>
>> Cheers,
>>
>>
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
"Any fool can know. The point is to understand" --Albert Einstein

Bored??
http://fiction.wikia.com/wiki/Fuqwit1.0

http://fiction.wikia.com/wiki/Coding_the_Magic_into_the_Eight_Ball

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
