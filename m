Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7TEErRF031581
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 10:14:53 -0400
Received: from yx-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7TEEL5o020603
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 14:14:22 GMT
Received: by yx-out-1718.google.com with SMTP id 3so490933yxi.84
        for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 07:14:53 -0700 (PDT)
Message-ID: <d74d42a50808290714l53ed8c4et2f51ddde98681124@mail.gmail.com>
Date: Fri, 29 Aug 2008 19:44:52 +0530
From: "shaunak saha" <reach.shaunak@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: semodule -i error
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1220018351.5708.297.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9535_29443686.1220019292598"
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
	 <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
	 <1220018351.5708.297.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_9535_29443686.1220019292598
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Wait - the error message you displayed listed "dbus_rpc_example_server"
>as the module name, not dbus_exe - so you aren't showing the module that
>is triggering the error.

yes.They are different modules but they are giving the same error.This one
gives:

*[root@localhost shaunak]# semodule -i dbus_exe.pp
libsepol.print_missing_requirements: dbus_exe's global requirements were not
met: type/attribute resmgrd_var_run_t
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed*

I have given the .te file for this as this is comparitively smaller than the
other module.I m sorry for that confusion.

> And I'm not sure what the purpose of this module

This is a sample program i have written to learn the policy writing.It calls
some dbus api's.It is working fine with the dbus.But now i want to test
gconf.I m working on making gconf-daemon an userspace object manager.For
this i wanted to add gconf class and test it.

>Just in case it isn't clear though - you cannot add new classes/perms in
>a non-base module; they have to be defined in the base module.  A
>non-base module can only require them, not declare them.

How to declare them in base module?Sorry for the ignorance but dont
really know how to do this



On Fri, Aug 29, 2008 at 7:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>
> On Fri, 2008-08-29 at 19:18 +0530, shaunak saha wrote:
> >
> > >So that's the problem - you didn't install it?  Or you didn't include
> > it
> > >in your base?
> >
> > No.I didn't installed it,neither did anything to include it in
> > base.Actually i m not aware what this module is required for.Previouly
> > while inserting any module didn't got this erorr.
> >
> >
> > >I think we'd have to see your module .te file
> >
> > This is my .te file
> >
> >  policy_module(dbus_exe,1.0.0)
>
> Wait - the error message you displayed listed "dbus_rpc_example_server"
> as the module name, not dbus_exe - so you aren't showing the module that
> is triggering the error.  And I'm not sure what the purpose of this
> module is, given that dbus already has a policy module.
>
> > ########################################
> > #
> > # Declarations
> > #
> > require{
> > type system_dbusd_t;
> > class dbus acquire_svc;
> > class dbus send_msg;
> > class gconf set_value;
> > }
> > type dbus_exe_t;
> > type dbus_exe_exec_t;
> > domain_type(dbus_exe_t)
> > init_daemon_domain(dbus_exe_t, dbus_exe_exec_t)
> > domtrans_pattern(unconfined_t,dbus_exe_exec_t,dbus_exe_t)
> > role unconfined_r types dbus_exe_t;
> > ########################################
> > #
> > # dbus_exe local policy
> > #
> > # Check in /etc/selinux/refpolicy/include for macros to use instead of
> > allow rules.
> > # Some common macros (you might be able to remove some)
> > files_read_etc_files(dbus_exe_t)
> > libs_use_ld_so(dbus_exe_t)
> > libs_use_shared_libs(dbus_exe_t)
> > miscfiles_read_localization(dbus_exe_t)
> > dbus_system_bus_client_template(dbus_exe,dbus_exe_t)
> > ## internal communication is often done using fifo and unix sockets.
> > allow dbus_exe_t self:fifo_file { read write };
> > allow dbus_exe_t self:unix_stream_socket create_stream_socket_perms;
> > allow dbus_exe_t system_dbusd_t:dbus { send_msg };
> > allow dbus_exe_t self:dbus {acquire_svc send_msg};
> > allow dbus_exe_t self:chr_file {getattr read write};
> > allow dbus_exe_t devpts_t:chr_file {getattr read write};
> > allow dbus_exe_t self:process {signal};
>
> Nothing above seems to have anything to do with resmgrd, and the policy
> module name doesn't match, so I'm guessing this isn't the right file.
>
> Just in case it isn't clear though - you cannot add new classes/perms in
> a non-base module; they have to be defined in the base module.  A
> non-base module can only require them, not declare them.
>
> --
>  Stephen Smalley
> National Security Agency
>
>

------=_Part_9535_29443686.1220019292598
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div><br>&gt;Wait - the error message you displayed listed &quot;dbus_rpc_example_server&quot;<br>&gt;as the module name, not dbus_exe - so you aren&#39;t showing the module that<br>&gt;is triggering the error.</div>

<div>&nbsp;</div>
<div>yes.They are different modules but they are giving the same error.This one gives:</div>
<div>&nbsp;</div>
<div><strong>[root@localhost shaunak]# semodule -i dbus_exe.pp <br>libsepol.print_missing_requirements: dbus_exe&#39;s global requirements were not<br>met: type/attribute resmgrd_var_run_t<br>libsemanage.semanage_link_sandbox: Link packages failed<br>
semodule:&nbsp; Failed</strong>&nbsp;</div>
<div>&nbsp;</div>
<div>I have given the .te file for this as this is comparitively smaller than the other module.I m sorry for that confusion.</div>
<div>&nbsp;</div>
<div>&gt; And I&#39;m not sure what the purpose of this module</div>
<div>&nbsp;</div>
<div>This is a sample program i have written to learn the policy writing.It calls some dbus api&#39;s.It is working fine with the dbus.But now i want to test gconf.I m working on making gconf-daemon an userspace object manager.For this i&nbsp;wanted to add gconf class and test it.</div>

<div>&nbsp;</div>
<div>&gt;Just in case it isn&#39;t clear though - you cannot add new classes/perms in<br>&gt;a non-base module; they have to be defined in the base module.&nbsp; A<br>&gt;non-base module can only require them, not declare them.</div>

<div>&nbsp;</div>
<div>How to declare them in base module?Sorry for the ignorance but dont really&nbsp;know&nbsp;how to do this</div>
<div>&nbsp;</div>
<div><br>&nbsp;</div>
<div class="gmail_quote">On Fri, Aug 29, 2008 at 7:29 PM, Stephen Smalley <span dir="ltr">&lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class="Ih2E3d"><br>On Fri, 2008-08-29 at 19:18 +0530, shaunak saha wrote:<br>&gt;<br>&gt; &gt;So that&#39;s the problem - you didn&#39;t install it? &nbsp;Or you didn&#39;t include<br>&gt; it<br>&gt; &gt;in your base?<br>
&gt;<br>&gt; No.I didn&#39;t installed it,neither did anything to include it in<br>&gt; base.Actually i m not aware what this module is required for.Previouly<br>&gt; while inserting any module didn&#39;t got this erorr.<br>
&gt;<br>&gt;<br>&gt; &gt;I think we&#39;d have to see your module .te file<br>&gt;<br>&gt; This is my .te file<br>&gt;<br>&gt; &nbsp;policy_module(dbus_exe,1.0.0)<br><br></div>Wait - the error message you displayed listed &quot;dbus_rpc_example_server&quot;<br>
as the module name, not dbus_exe - so you aren&#39;t showing the module that<br>is triggering the error. &nbsp;And I&#39;m not sure what the purpose of this<br>module is, given that dbus already has a policy module.<br>
<div>
<div></div>
<div class="Wj3C7c"><br>&gt; ########################################<br>&gt; #<br>&gt; # Declarations<br>&gt; #<br>&gt; require{<br>&gt; type system_dbusd_t;<br>&gt; class dbus acquire_svc;<br>&gt; class dbus send_msg;<br>
&gt; class gconf set_value;<br>&gt; }<br>&gt; type dbus_exe_t;<br>&gt; type dbus_exe_exec_t;<br>&gt; domain_type(dbus_exe_t)<br>&gt; init_daemon_domain(dbus_exe_t, dbus_exe_exec_t)<br>&gt; domtrans_pattern(unconfined_t,dbus_exe_exec_t,dbus_exe_t)<br>
&gt; role unconfined_r types dbus_exe_t;<br>&gt; ########################################<br>&gt; #<br>&gt; # dbus_exe local policy<br>&gt; #<br>&gt; # Check in /etc/selinux/refpolicy/include for macros to use instead of<br>
&gt; allow rules.<br>&gt; # Some common macros (you might be able to remove some)<br>&gt; files_read_etc_files(dbus_exe_t)<br>&gt; libs_use_ld_so(dbus_exe_t)<br>&gt; libs_use_shared_libs(dbus_exe_t)<br>&gt; miscfiles_read_localization(dbus_exe_t)<br>
&gt; dbus_system_bus_client_template(dbus_exe,dbus_exe_t)<br>&gt; ## internal communication is often done using fifo and unix sockets.<br>&gt; allow dbus_exe_t self:fifo_file { read write };<br>&gt; allow dbus_exe_t self:unix_stream_socket create_stream_socket_perms;<br>
&gt; allow dbus_exe_t system_dbusd_t:dbus { send_msg };<br>&gt; allow dbus_exe_t self:dbus {acquire_svc send_msg};<br>&gt; allow dbus_exe_t self:chr_file {getattr read write};<br>&gt; allow dbus_exe_t devpts_t:chr_file {getattr read write};<br>
&gt; allow dbus_exe_t self:process {signal};<br><br></div></div>Nothing above seems to have anything to do with resmgrd, and the policy<br>module name doesn&#39;t match, so I&#39;m guessing this isn&#39;t the right file.<br>
<br>Just in case it isn&#39;t clear though - you cannot add new classes/perms in<br>a non-base module; they have to be defined in the base module. &nbsp;A<br>non-base module can only require them, not declare them.<br><font color="#888888"><br>
--<br></font>
<div>
<div></div>
<div class="Wj3C7c">Stephen Smalley<br>National Security Agency<br><br></div></div></blockquote></div><br></div>

------=_Part_9535_29443686.1220019292598--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
