Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MIWg08013441
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 14:32:42 -0400
Received: by mail-vk0-f49.google.com with SMTP id x71so45637723vkd.0
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 11:32:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170522182350.GC12310@julius.enp8s0.d30>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
 <1495477109.24649.6.camel@tycho.nsa.gov>
 <20170522182350.GC12310@julius.enp8s0.d30>
From: "Chris O'Neil" <anzavalley@gmail.com>
Date: Mon, 22 May 2017 11:32:35 -0700
Message-ID: <CAAung+a72_qvAaFz+XCiFDvatZR4TwKcWDWYttW4Tzf1qT_n9g@mail.gmail.com>
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR op=security_bounded_transition
 seresult=denied
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 22, 2017 at 11:23 AM, Dominick Grift <dac.override@gmail.com> wrote:
> On Mon, May 22, 2017 at 02:18:29PM -0400, Stephen Smalley wrote:
>> On Mon, 2017-05-22 at 09:29 -0700, Chris O'Neil wrote:
>> > Hi, running latest RHEL 7.3 ... struggling with an SELinux issue
>> > related
>> > to Apache httpd that I just can't figure out.  I have always been
>> > able
>> > to tune policy or alter a boolean, this one has me stumped!
>> >
>> > What I am trying to do: I am trying to deploy a simple, 3 line CGI
>> > script in /var/www/cgi-bin/.  Runs fine with enforcement disabled
>> > (see
>> > output below).  My custom policy for Apache (see below) comes from my
>> > EL6 environment.
>> >
>> > The normal setroubleshooting tools don't help, as there is only a
>> > single
>> > line in audit.log (of type=SELINUX_ERR)
>> >
>> > This is not happening on latest RHEL 6.9 ...
>> >
>> > Might be related to systemd?  I don't see any "NoNewPrivileges"
>> > directives inside /etc/systemd/ though ... weird!
>>
>> Is the filesystem mounted nosuid?
>
> If selinux also uses that message for that scenario then i find that confusing since the message, to me, implies that the issue can be find by adding a type bounds, but i don't think that would work for nosuid mounted slices

Stephen ... /var/www/ was mounted with the "nosuid" option.  I forgot
about that ... if I remember correctly, when "nosuid" is set on a
mounted FS, SELinux trans will fail under this condition.  This bit me
before, years ago... and I forgot about it.

Everything is working as expected now.  If I want to mitigate some
risk, and still use "nosuid" for /var/www/ ....  I'll need to split
/var/www/cgi-bin away from /var/www/ ...

Thank you both for your time and help
-chris

>>
>> >
>> > Many thanks for your help!
>> > -chris
>> >
>> >
>> > #####################################################################
>> > ###
>> > # With enforcement disabled ... all is good (as expected)
>> > #####################################################################
>> > ###
>> >
>> > # ls -laZ /var/www/cgi-bin/
>> > drwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 .
>> > drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 ..
>> > -rwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0
>> > ok.cgi
>> >
>> > # setenforce 0
>> > # systemctl restart httpd.service
>> > $ curl localhost/cgi-bin/ok.cgi
>> > OK
>> >
>> >
>> > #####################################################################
>> > ###
>> > # With enforcement enabled ... CGI script fails, all you find is a
>> > # single deny in /var/log/audit/audit.log
>> > #####################################################################
>> > ###
>> >
>> > # setenforce 1
>> > # systemctl restart httpd.service
>> >
>> > # getenforce
>> > Enforcing
>> >
>> > $ curl localhost/cgi-bin/ok.cgi
>> > <html><head><title>500 Server Error</title></head><body><h1>Server
>> > Error</h1></body></html>
>> >
>> > # tail /var/log/audit/audit.log | grep denied
>> > type=SELINUX_ERR msg=audit(1495468154.591:121695):
>> > op=security_bounded_transition seresult=denied
>> > oldcontext=system_u:system_r:httpd_t:s0
>> > newcontext=system_u:system_r:httpd_sys_script_t:s0
>> >
>> >
>> > #####################################################################
>> > ###
>> > # System details ...
>> > #####################################################################
>> > ###
>> >
>> > # uname -r
>> > 3.10.0-514.16.1.el7.x86_64
>> >
>> > # cat /etc/redhat-release
>> > Red Hat Enterprise Linux Server release 7.3 (Maipo)
>> >
>> > # sestatus
>> > SELinux status:                 enabled
>> > SELinuxfs mount:                /sys/fs/selinux
>> > SELinux root directory:         /etc/selinux
>> > Loaded policy name:             targeted
>> > Current mode:                   enforcing
>> > Mode from config file:          enforcing
>> > Policy MLS status:              enabled
>> > Policy deny_unknown status:     allowed
>> > Max kernel policy version:      28
>> >
>> > # find /etc/ -type f | xargs grep NoNewPrivileges
>> > [NO OUTPUT]
>> >
>> > # getsebool -a | grep httpd_
>> > httpd_anon_write --> on
>> > httpd_builtin_scripting --> on
>> > httpd_can_check_spam --> off
>> > httpd_can_connect_ftp --> off
>> > httpd_can_connect_ldap --> off
>> > httpd_can_connect_mythtv --> off
>> > httpd_can_connect_zabbix --> off
>> > httpd_can_network_connect --> on
>> > httpd_can_network_connect_cobbler --> off
>> > httpd_can_network_connect_db --> on
>> > httpd_can_network_memcache --> off
>> > httpd_can_network_relay --> off
>> > httpd_can_sendmail --> on
>> > httpd_dbus_avahi --> on
>> > httpd_dbus_sssd --> off
>> > httpd_dontaudit_search_dirs --> off
>> > httpd_enable_cgi --> on
>> > httpd_enable_ftp_server --> off
>> > httpd_enable_homedirs --> off
>> > httpd_execmem --> off
>> > httpd_graceful_shutdown --> on
>> > httpd_manage_ipa --> off
>> > httpd_mod_auth_ntlm_winbind --> off
>> > httpd_mod_auth_pam --> off
>> > httpd_read_user_content --> on
>> > httpd_run_ipa --> off
>> > httpd_run_preupgrade --> off
>> > httpd_run_stickshift --> off
>> > httpd_serve_cobbler_files --> off
>> > httpd_setrlimit --> off
>> > httpd_ssi_exec --> off
>> > httpd_sys_script_anon_write --> off
>> > httpd_tmp_exec --> off
>> > httpd_tty_comm --> on
>> > httpd_unified --> on
>> > httpd_use_cifs --> off
>> > httpd_use_fusefs --> off
>> > httpd_use_gpg --> off
>> > httpd_use_nfs --> off
>> > httpd_use_openstack --> off
>> > httpd_use_sasl --> off
>> > httpd_verify_dns --> off
>> >
>> >
>> > # THIS IS MY GENERIC APACHE TE FILE FROM EL6 ...
>> >
>> > # cat myapache.te
>> > module myapache 0.4;
>> >
>> > require {
>> >         type httpd_t;
>> >         type httpd_sys_script_t;
>> >         type http_port_t;
>> >         type mysqld_port_t;
>> >         type rpm_var_cache_t;
>> >         type kernel_t;
>> >         class process { setpgid transition };
>> >         class system module_request;
>> >         class tcp_socket name_connect;
>> >         class dir { read search open getattr };
>> >         class file { open read getattr };
>> > }
>> >
>> > allow httpd_t rpm_var_cache_t:dir { read search open getattr };
>> > allow httpd_t rpm_var_cache_t:file { read getattr open } ;
>> > allow httpd_t mysqld_port_t:tcp_socket name_connect;
>> > allow httpd_sys_script_t self:process setpgid;
>> > allow httpd_sys_script_t http_port_t:tcp_socket name_connect;
>> > allow httpd_sys_script_t kernel_t:system module_request;
>> >
>> > #type=SELINUX_ERR msg=audit(1495467001.822:84934):
>> > op=security_bounded_transition seresult=denied
>> > oldcontext=system_u:system_r:httpd_t:s0
>> > newcontext=system_u:system_r:httpd_sys_script_t:s0
>> > # THIS STILL DOES NOT WORK! SYSTEMD ISSUE?
>> > allow httpd_t httpd_sys_script_t:process transition;
>> >
>> >
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
