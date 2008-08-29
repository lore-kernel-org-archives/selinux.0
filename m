Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7TDm3pd023904
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 09:48:03 -0400
Received: from yx-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7TDlV5o011263
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 13:47:31 GMT
Received: by yx-out-1718.google.com with SMTP id 3so484083yxi.84
        for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 06:48:03 -0700 (PDT)
Message-ID: <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
Date: Fri, 29 Aug 2008 19:18:02 +0530
From: "shaunak saha" <reach.shaunak@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: semodule -i error
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8841_23874916.1220017682474"
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
	 <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_8841_23874916.1220017682474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>So that's the problem - you didn't install it?  Or you didn't include it
>in your base?

No.I didn't installed it,neither did anything to include it in base.Actually
i m not aware what this module is required for.Previouly while inserting any
module didn't got this erorr.


>I think we'd have to see your module .te file

This is my .te file

 policy_module(dbus_exe,1.0.0)
########################################
#
# Declarations
#
require{
type system_dbusd_t;
class dbus acquire_svc;
class dbus send_msg;
class gconf set_value;
}
type dbus_exe_t;
type dbus_exe_exec_t;
domain_type(dbus_exe_t)
init_daemon_domain(dbus_exe_t, dbus_exe_exec_t)
domtrans_pattern(unconfined_t,dbus_exe_exec_t,dbus_exe_t)
role unconfined_r types dbus_exe_t;
########################################
#
# dbus_exe local policy
#
# Check in /etc/selinux/refpolicy/include for macros to use instead of allow
rules.
# Some common macros (you might be able to remove some)
files_read_etc_files(dbus_exe_t)
libs_use_ld_so(dbus_exe_t)
libs_use_shared_libs(dbus_exe_t)
miscfiles_read_localization(dbus_exe_t)
dbus_system_bus_client_template(dbus_exe,dbus_exe_t)
## internal communication is often done using fifo and unix sockets.
allow dbus_exe_t self:fifo_file { read write };
allow dbus_exe_t self:unix_stream_socket create_stream_socket_perms;
allow dbus_exe_t system_dbusd_t:dbus { send_msg };
allow dbus_exe_t self:dbus {acquire_svc send_msg};
allow dbus_exe_t self:chr_file {getattr read write};
allow dbus_exe_t devpts_t:chr_file {getattr read write};
allow dbus_exe_t self:process {signal};


On Fri, Aug 29, 2008 at 6:52 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>
> On Fri, 2008-08-29 at 16:03 +0530, shaunak saha wrote:
> > Hi all,
> >
> > When i m trying to install a module using semodule -i <name of the
> > module> i m geting the following error:
> >
> > libsepol.print_missing_requirements: dbus_rpc_example_server's global
> > requirements were not met: type/attribute resmgrd_var_run_t
>
> So your module has a require on that type (presumably by using an
> interface that depends on it), and you don't have that type defined in
> your policy.
>
> > libsemanage.semanage_link_sandbox: Link packages failed
> > semodule:  Failed!
> >
> > Also when i do "semodule -l" i could not see any module resmgr.
>
> So that's the problem - you didn't install it?  Or you didn't include it
> in your base?
>
> > I m actually trying to insert a new class gconf (making gconf-daemon
> > an userspace object manager).
> > For this i have downloaded the refpolicy
> >
> > refpolicy-20080702.tar.bz2 from
> > http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease and
> > installed it.
> >
> > Then from  /etc/selinux/refpolicy/src/policy/policy/flask directory i
> > m editing the security_classes and access_vectors files to add my new
> > gconf class and permissions, then rebuilding and installing the
> > policy.
> > The whenever i m giving the class gconf in my module .te file and
> > trying to install it i m getting this error.I guess i m missing
> > something.PLease help.
>
> I think we'd have to see your module .te file.
> And maybe your modules.conf.
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_8841_23874916.1220017682474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div><br>&gt;So that&#39;s the problem - you didn&#39;t install it? &nbsp;Or you didn&#39;t include it<br>&gt;in your base?</div>
<div>&nbsp;</div>
<div>No.I didn&#39;t installed it,neither did anything to include it in base.Actually i m not aware what this module is required for.Previouly while inserting any module didn&#39;t got this erorr.</div>
<div>&nbsp;</div>
<div><br>&gt;I think we&#39;d have to see your module .te file</div>
<div>&nbsp;</div>
<div>This is my .te file</div>
<div>&nbsp;</div>
<div>&nbsp;policy_module(dbus_exe,1.0.0)</div>
<div>########################################<br>#<br># Declarations<br>#<br>require{<br>type system_dbusd_t;<br>class dbus acquire_svc;<br>class dbus send_msg;<br>class gconf set_value;<br>}</div>
<div>type dbus_exe_t;<br>type dbus_exe_exec_t;<br>domain_type(dbus_exe_t)<br>init_daemon_domain(dbus_exe_t, dbus_exe_exec_t)</div>
<div>domtrans_pattern(unconfined_t,dbus_exe_exec_t,dbus_exe_t)<br>role unconfined_r types dbus_exe_t;<br>########################################<br>#<br># dbus_exe local policy<br>#<br># Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.<br>
# Some common macros (you might be able to remove some)<br>files_read_etc_files(dbus_exe_t)<br>libs_use_ld_so(dbus_exe_t)<br>libs_use_shared_libs(dbus_exe_t)<br>miscfiles_read_localization(dbus_exe_t)<br>dbus_system_bus_client_template(dbus_exe,dbus_exe_t)<br>
## internal communication is often done using fifo and unix sockets.<br>allow dbus_exe_t self:fifo_file { read write };<br>allow dbus_exe_t self:unix_stream_socket create_stream_socket_perms;<br>allow dbus_exe_t system_dbusd_t:dbus { send_msg };<br>
allow dbus_exe_t self:dbus {acquire_svc send_msg};<br>allow dbus_exe_t self:chr_file {getattr read write};<br>allow dbus_exe_t devpts_t:chr_file {getattr read write};<br>allow dbus_exe_t self:process {signal};</div>
<div><br>&nbsp;</div>
<div class="gmail_quote">On Fri, Aug 29, 2008 at 6:52 PM, Stephen Smalley <span dir="ltr">&lt;<a href="mailto:sds@tycho.nsa.gov" target="_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><br>On Fri, 2008-08-29 at 16:03 +0530, shaunak saha wrote:<br>&gt; Hi all,<br>&gt;<br>&gt; When i m trying to install a module using semodule -i &lt;name of the<br>&gt; module&gt; i m geting the following error:<br>
&gt;<br>&gt; libsepol.print_missing_requirements: dbus_rpc_example_server&#39;s global<br>&gt; requirements were not met: type/attribute resmgrd_var_run_t<br><br></div>So your module has a require on that type (presumably by using an<br>
interface that depends on it), and you don&#39;t have that type defined in<br>your policy.<br>
<div><br>&gt; libsemanage.semanage_link_sandbox: Link packages failed<br>&gt; semodule: &nbsp;Failed!<br>&gt;<br>&gt; Also when i do &quot;semodule -l&quot; i could not see any module resmgr.<br><br></div>So that&#39;s the problem - you didn&#39;t install it? &nbsp;Or you didn&#39;t include it<br>
in your base?<br>
<div><br>&gt; I m actually trying to insert a new class gconf (making gconf-daemon<br>&gt; an userspace object manager).<br>&gt; For this i have downloaded the refpolicy<br>&gt;<br>&gt; refpolicy-20080702.tar.bz2 from<br>
&gt; <a href="http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease" target="_blank">http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease</a> and<br>&gt; installed it.<br>&gt;<br>&gt; Then from &nbsp;/etc/selinux/refpolicy/src/policy/policy/flask directory i<br>
&gt; m editing the security_classes and access_vectors files to add my new<br>&gt; gconf class and permissions, then rebuilding and installing the<br>&gt; policy.<br>&gt; The whenever i m giving the class gconf in my module .te file and<br>
&gt; trying to install it i m getting this error.I guess i m missing<br>&gt; something.PLease help.<br><br></div>I think we&#39;d have to see your module .te file.<br>And maybe your modules.conf.<br><font color="#888888"><br>
--<br>Stephen Smalley<br>National Security Agency<br><br></font></blockquote></div><br></div>

------=_Part_8841_23874916.1220017682474--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
