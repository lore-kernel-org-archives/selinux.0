Subject: Re: semodule -i error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shaunak saha <reach.shaunak@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
	 <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 09:59:11 -0400
Message-Id: <1220018351.5708.297.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-29 at 19:18 +0530, shaunak saha wrote:
> 
> >So that's the problem - you didn't install it?  Or you didn't include
> it
> >in your base?
>  
> No.I didn't installed it,neither did anything to include it in
> base.Actually i m not aware what this module is required for.Previouly
> while inserting any module didn't got this erorr.
>  
> 
> >I think we'd have to see your module .te file
>  
> This is my .te file
>  
>  policy_module(dbus_exe,1.0.0)

Wait - the error message you displayed listed "dbus_rpc_example_server"
as the module name, not dbus_exe - so you aren't showing the module that
is triggering the error.  And I'm not sure what the purpose of this
module is, given that dbus already has a policy module.

> ########################################
> #
> # Declarations
> #
> require{
> type system_dbusd_t;
> class dbus acquire_svc;
> class dbus send_msg;
> class gconf set_value;
> }
> type dbus_exe_t;
> type dbus_exe_exec_t;
> domain_type(dbus_exe_t)
> init_daemon_domain(dbus_exe_t, dbus_exe_exec_t)
> domtrans_pattern(unconfined_t,dbus_exe_exec_t,dbus_exe_t)
> role unconfined_r types dbus_exe_t;
> ########################################
> #
> # dbus_exe local policy
> #
> # Check in /etc/selinux/refpolicy/include for macros to use instead of
> allow rules.
> # Some common macros (you might be able to remove some)
> files_read_etc_files(dbus_exe_t)
> libs_use_ld_so(dbus_exe_t)
> libs_use_shared_libs(dbus_exe_t)
> miscfiles_read_localization(dbus_exe_t)
> dbus_system_bus_client_template(dbus_exe,dbus_exe_t)
> ## internal communication is often done using fifo and unix sockets.
> allow dbus_exe_t self:fifo_file { read write };
> allow dbus_exe_t self:unix_stream_socket create_stream_socket_perms;
> allow dbus_exe_t system_dbusd_t:dbus { send_msg };
> allow dbus_exe_t self:dbus {acquire_svc send_msg};
> allow dbus_exe_t self:chr_file {getattr read write};
> allow dbus_exe_t devpts_t:chr_file {getattr read write};
> allow dbus_exe_t self:process {signal};

Nothing above seems to have anything to do with resmgrd, and the policy
module name doesn't match, so I'm guessing this isn't the right file.

Just in case it isn't clear though - you cannot add new classes/perms in
a non-base module; they have to be defined in the base module.  A
non-base module can only require them, not declare them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
