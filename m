Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5OKxfYr014533
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2008 16:59:41 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5OKxd0T021131
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2008 20:59:40 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1232182fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2008 13:59:39 -0700 (PDT)
Message-ID: <cadfc0e40806241359l31cdf6f9l663b47ca322b5c2d@mail.gmail.com>
Date: Tue, 24 Jun 2008 15:59:39 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: Re: first cut of window manager/metacity policy
In-Reply-To: <cadfc0e40806241151n3a87aca8t3dd362d9383b1259@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806241151n3a87aca8t3dd362d9383b1259@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry I must have hit paste twice as there are two copies of the patch :(

On Tue, Jun 24, 2008 at 1:51 PM, Xavier Toth <txtoth@gmail.com> wrote:
> --- serefpolicy-3.4.1/policy/modules/apps/wm.if 1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/wm.if     2008-06-24
> 12:01:56.000000000 -0500
> @@ -0,0 +1,105 @@
> +## <summary>Window Manager.</summary>
> +
> +#######################################
> +## <summary>
> +##     Template to create types and rules common to
> +##     any window manager domains.
> +## </summary>
> +## <param name="prefix">
> +##     <summary>
> +##     The prefix of the domain (e.g., user
> +##     is the prefix for user_t).
> +##     </summary>
> +## </param>
> +## <param name="prefix">
> +##     <summary>
> +##     The prefix of the X server domain (e.g., user
> +##     is the prefix for user_t).
> +##     </summary>
> +## </param>
> +#
> +template(`wm_domain_template',`
> +       gen_require(`
> +               type $1_t;
> +               type wm_exec_t;
> +               type tmpfs_t;
> +               type $1_dbusd_t;
> +               type $1_tmp_t;
> +               type $2_rootwindow_t, $2_xproperty_t, $2_xserver_t, $2_var_run_t;
> +               type $1_xproperty_t, $1_input_xevent_t, $1_manage_xevent_t,
> $1_property_xevent_t;
> +               type $1_focus_xevent_t, $1_client_xevent_t;
> +               type output_xext_t;
> +               class x_colormap { install uninstall };
> +               class x_drawable manage;
> +               class x_property write;
> +               class x_device { setfocus grab force_cursor freeze };
> +               class x_screen setattr;
> +       ')
> +
> +       type $1_wm_t;
> +       domain_type($1_wm_t)
> +       domain_entry_file($1_wm_t,wm_exec_t)
> +       role $1_r types $1_wm_t;
> +
> +       domtrans_pattern($1_t, wm_exec_t, $1_wm_t)
> +
> +       type $1_wm_tmpfs_t;
> +       xserver_user_x_domain_template($1, $1_wm, $1_wm_t, $1_wm_tmpfs_t)
> +
> +       files_read_etc_files($1_wm_t)
> +
> +       libs_use_ld_so($1_wm_t)
> +       libs_use_shared_libs($1_wm_t)
> +
> +       nscd_dontaudit_search_pid($1_wm_t)
> +
> +       miscfiles_read_localization($1_wm_t)
> +
> +       dev_read_urand($1_wm_t)
> +
> +       files_list_tmp($1_wm_t)
> +
> +       dbus_user_bus_client_template($1,$1,$1_wm_t)
> +
> +       allow $1_wm_t info_xproperty_t:x_property write;
> +
> +       allow $1_wm_t self:process getsched;
> +       allow $1_wm_t self:x_drawable blend;
> +
> +       allow $1_wm_t tmpfs_t:file { read write };
> +       allow $1_wm_t $1_client_xevent_t:x_synthetic_event send;
> +       allow $1_wm_t $1_focus_xevent_t:x_event receive;
> +       allow $1_wm_t $1_home_t:dir search;
> +       allow $1_wm_t $1_home_t:file { read append };
> +       allow $1_wm_t $1_input_xevent_t:x_event receive;
> +       allow $1_wm_t $1_manage_xevent_t:x_event receive;
> +       allow $1_wm_t $1_manage_xevent_t:x_synthetic_event { receive send };
> +       allow $1_wm_t $1_property_xevent_t:x_event receive;
> +       allow $1_wm_t $1_t:unix_stream_socket connectto;
> +       allow $1_wm_t $1_t:x_drawable { get_property setattr show receive
> manage send read getattr list_child set_property };
> +       allow $1_wm_t $1_tmp_t:dir { write search setattr remove_name
> getattr add_name };
> +       allow $1_wm_t $1_tmp_t:sock_file { write create unlink };
> +       allow $1_wm_t $1_xproperty_t:x_property { read write };
> +       allow $1_wm_t usr_t:file { read getattr };
> +       allow $1_wm_t usr_t:lnk_file read;
> +       allow $1_wm_t $2_rootwindow_t:x_colormap install;
> +       allow $1_wm_t $2_rootwindow_t:x_drawable { read write manage setattr };
> +       allow $1_wm_t $2_var_run_t:dir search;
> +       allow $1_wm_t $2_var_run_t:file { read getattr };
> +       allow $1_wm_t $2_xproperty_t:x_property { write read };
> +       allow $1_wm_t $2_xserver_t:x_device { setfocus use setattr grab
> manage getattr freeze };
> +       allow $1_wm_t $2_xserver_t:x_resource write;
> +       allow $1_wm_t $2_xserver_t:x_screen setattr;
> +       allow $1_wm_t xselection_t:x_selection setattr;
> +       allow $1_wm_t $2_rootwindow_t:x_colormap uninstall;
> +       allow $1_wm_t $2_xserver_t:x_device force_cursor;
> +
> +       ifdef(`enable_mls',`
> +               mls_file_read_all_levels($1_wm_t)
> +               mls_xwin_write_to_clearance($1_wm_t)
> +       ')
> +
> +       allow $1_t $1_wm_t:unix_stream_socket connectto;
> +       allow $1_t $1_wm_t:x_drawable { receive get_property getattr list_child };
> +')
> +
> --- serefpolicy-3.4.1/policy/modules/apps/wm.te 1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/wm.te     2008-06-24
> 12:01:56.000000000 -0500
> @@ -0,0 +1,8 @@
> +policy_module(wm,0.0.1)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type wm_exec_t;
> --- serefpolicy-3.4.1/policy/modules/apps/wm.fc 1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/wm.fc     2008-06-24
> 12:01:56.000000000 -0500
> @@ -0,0 +1 @@
> +
> --- serefpolicy-3.4.1/policy/modules/apps/metacity.fc   1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/metacity.fc       2008-06-24
> 12:01:26.000000000 -0500
> @@ -0,0 +1,5 @@
> +#
> +# /usr
> +#
> +
> +/usr/bin/metacity      --      gen_context(system_u:object_r:wm_exec_t,s0)
> --- serefpolicy-3.4.1/policy/modules/apps/metacity.if   1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/metacity.if       2008-06-24
> 12:01:26.000000000 -0500
> @@ -0,0 +1 @@
> +## <summary></summary>
> --- serefpolicy-3.4.1/policy/modules/apps/metacity.te   1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/metacity.te       2008-06-24
> 12:01:26.000000000 -0500
> @@ -0,0 +1,8 @@
> +policy_module(metacity,0.0.1)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +wm_domain_template(user,xdm)
> [root@localhost SOURCES]# cat wm-policy.patch
> --- serefpolicy-3.4.1/policy/modules/apps/wm.if 1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/wm.if     2008-06-24
> 12:01:56.000000000 -0500
> @@ -0,0 +1,105 @@
> +## <summary>Window Manager.</summary>
> +
> +#######################################
> +## <summary>
> +##     Template to create types and rules common to
> +##     any window manager domains.
> +## </summary>
> +## <param name="prefix">
> +##     <summary>
> +##     The prefix of the domain (e.g., user
> +##     is the prefix for user_t).
> +##     </summary>
> +## </param>
> +## <param name="prefix">
> +##     <summary>
> +##     The prefix of the X server domain (e.g., user
> +##     is the prefix for user_t).
> +##     </summary>
> +## </param>
> +#
> +template(`wm_domain_template',`
> +       gen_require(`
> +               type $1_t;
> +               type wm_exec_t;
> +               type tmpfs_t;
> +               type $1_dbusd_t;
> +               type $1_tmp_t;
> +               type $2_rootwindow_t, $2_xproperty_t, $2_xserver_t, $2_var_run_t;
> +               type $1_xproperty_t, $1_input_xevent_t, $1_manage_xevent_t,
> $1_property_xevent_t;
> +               type $1_focus_xevent_t, $1_client_xevent_t;
> +               type output_xext_t;
> +               class x_colormap { install uninstall };
> +               class x_drawable manage;
> +               class x_property write;
> +               class x_device { setfocus grab force_cursor freeze };
> +               class x_screen setattr;
> +       ')
> +
> +       type $1_wm_t;
> +       domain_type($1_wm_t)
> +       domain_entry_file($1_wm_t,wm_exec_t)
> +       role $1_r types $1_wm_t;
> +
> +       domtrans_pattern($1_t, wm_exec_t, $1_wm_t)
> +
> +       type $1_wm_tmpfs_t;
> +       xserver_user_x_domain_template($1, $1_wm, $1_wm_t, $1_wm_tmpfs_t)
> +
> +       files_read_etc_files($1_wm_t)
> +
> +       libs_use_ld_so($1_wm_t)
> +       libs_use_shared_libs($1_wm_t)
> +
> +       nscd_dontaudit_search_pid($1_wm_t)
> +
> +       miscfiles_read_localization($1_wm_t)
> +
> +       dev_read_urand($1_wm_t)
> +
> +       files_list_tmp($1_wm_t)
> +
> +       dbus_user_bus_client_template($1,$1,$1_wm_t)
> +
> +       allow $1_wm_t info_xproperty_t:x_property write;
> +
> +       allow $1_wm_t self:process getsched;
> +       allow $1_wm_t self:x_drawable blend;
> +
> +       allow $1_wm_t tmpfs_t:file { read write };
> +       allow $1_wm_t $1_client_xevent_t:x_synthetic_event send;
> +       allow $1_wm_t $1_focus_xevent_t:x_event receive;
> +       allow $1_wm_t $1_home_t:dir search;
> +       allow $1_wm_t $1_home_t:file { read append };
> +       allow $1_wm_t $1_input_xevent_t:x_event receive;
> +       allow $1_wm_t $1_manage_xevent_t:x_event receive;
> +       allow $1_wm_t $1_manage_xevent_t:x_synthetic_event { receive send };
> +       allow $1_wm_t $1_property_xevent_t:x_event receive;
> +       allow $1_wm_t $1_t:unix_stream_socket connectto;
> +       allow $1_wm_t $1_t:x_drawable { get_property setattr show receive
> manage send read getattr list_child set_property };
> +       allow $1_wm_t $1_tmp_t:dir { write search setattr remove_name
> getattr add_name };
> +       allow $1_wm_t $1_tmp_t:sock_file { write create unlink };
> +       allow $1_wm_t $1_xproperty_t:x_property { read write };
> +       allow $1_wm_t usr_t:file { read getattr };
> +       allow $1_wm_t usr_t:lnk_file read;
> +       allow $1_wm_t $2_rootwindow_t:x_colormap install;
> +       allow $1_wm_t $2_rootwindow_t:x_drawable { read write manage setattr };
> +       allow $1_wm_t $2_var_run_t:dir search;
> +       allow $1_wm_t $2_var_run_t:file { read getattr };
> +       allow $1_wm_t $2_xproperty_t:x_property { write read };
> +       allow $1_wm_t $2_xserver_t:x_device { setfocus use setattr grab
> manage getattr freeze };
> +       allow $1_wm_t $2_xserver_t:x_resource write;
> +       allow $1_wm_t $2_xserver_t:x_screen setattr;
> +       allow $1_wm_t xselection_t:x_selection setattr;
> +       allow $1_wm_t $2_rootwindow_t:x_colormap uninstall;
> +       allow $1_wm_t $2_xserver_t:x_device force_cursor;
> +
> +       ifdef(`enable_mls',`
> +               mls_file_read_all_levels($1_wm_t)
> +               mls_xwin_write_to_clearance($1_wm_t)
> +       ')
> +
> +       allow $1_t $1_wm_t:unix_stream_socket connectto;
> +       allow $1_t $1_wm_t:x_drawable { receive get_property getattr list_child };
> +')
> +
> --- serefpolicy-3.4.1/policy/modules/apps/wm.te 1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/wm.te     2008-06-24
> 12:01:56.000000000 -0500
> @@ -0,0 +1,8 @@
> +policy_module(wm,0.0.1)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type wm_exec_t;
> --- serefpolicy-3.4.1/policy/modules/apps/wm.fc 1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/wm.fc     2008-06-24
> 12:01:56.000000000 -0500
> @@ -0,0 +1 @@
> +
> --- serefpolicy-3.4.1/policy/modules/apps/metacity.fc   1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/metacity.fc       2008-06-24
> 12:01:26.000000000 -0500
> @@ -0,0 +1,5 @@
> +#
> +# /usr
> +#
> +
> +/usr/bin/metacity      --      gen_context(system_u:object_r:wm_exec_t,s0)
> --- serefpolicy-3.4.1/policy/modules/apps/metacity.if   1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/metacity.if       2008-06-24
> 12:01:26.000000000 -0500
> @@ -0,0 +1 @@
> +## <summary></summary>
> --- serefpolicy-3.4.1/policy/modules/apps/metacity.te   1969-12-31
> 17:00:00.000000000 -0700
> +++ serefpolicy-3.4.1.new/policy/modules/apps/metacity.te       2008-06-24
> 12:01:26.000000000 -0500
> @@ -0,0 +1,8 @@
> +policy_module(metacity,0.0.1)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +wm_domain_template(user,xdm)
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
