Subject: Re: [PATCH] refpolicy: experimental X policy -v2
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45D2498C.3090902@tycho.nsa.gov>
References: <45B938EE.8010303@tycho.nsa.gov>
	 <cadfc0e40702131226y3cef4a81h626bcdb264c563ee@mail.gmail.com>
	 <45D2498C.3090902@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 13:53:49 -0500
Message-Id: <1172602429.11157.48.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-13 at 18:28 -0500, Eamon Walsh wrote:
> This is an experimental policy for use with the X userspace object 
> manager.  It includes both unconfined and strict policy and is 
> controlled by a tunable, xwindows_object_manager.  The labeling conf 
> file in the X.org xserver git (XACE-SELINUX branch) assumes that this 
> policy is loaded, i.e. the types listed in that file are defined in this 
> policy.

Unfortunately I didn't get a chance to look at this until today.  It'll
take some time to fully understand all this, but I have some notes from
my initial review inline:

>  modules/services/xwindows.fc |   13 +
>  modules/services/xwindows.if |  521 +++++++++++++++++++++++++++++++++++++++++++
>  modules/services/xwindows.te |   65 +++++

Eventually this should probably be merged into the xserver module.
Potentially in a tunable, when that support becomes available.  However,
for the purposes of vetting the design, a separate module is fine.

> Index: policy/modules/services/xwindows.if
> ===================================================================
> --- policy/modules/services/xwindows.if	(revision 0)
> +++ policy/modules/services/xwindows.if	(revision 0)
> @@ -0,0 +1,521 @@

> +template(`xwindows_property',`
> +	gen_require(`
> +		type $1_t;
> +		type $2;
> +		attribute xproperty_type;
> +		attribute $1_xproperty_type;
> +		attribute $2ype;
> +		class property all_property_perms;
> +	')
> +
> +	type $1_$2, $1_xproperty_type, $2ype, xproperty_type;
> +	type_transition $1_t $2:property $1_$2;
> +')

> +template(`xwindows_property_set',`
> +

> +	attribute $1_xproperty_type;
> +	xwindows_property($1,client_xproperty_t)
> +	xwindows_property($1,info_xproperty_t)
> +	xwindows_property($1,seclabel_xproperty_t)
> +	xwindows_property($1,rm_xproperty_t)
> +	xwindows_property($1,wm_xproperty_t)
> +	xwindows_property($1,clipboard_xproperty_t)
> +	xwindows_property($1,unknown_xproperty_t)
> +')

Is there be a situation where one wouldn't want a full set of
properties?  If not, I'd rather eliminate xwindows_property(), because
the name mangling being done with the base property type names (e.g.,
$2ype) is a little ugly.


> +template(`xwindows_windowmgr_client',`
[cut]
> +		# can set properties on all windows
> +		allow $3 domain:window { chprop chproplist };

> +		# X Windows - extensive control over all windows
> +		# can query windows for visual information
> +		allow $3 domain:drawable getattr;
> +		# can enumerate and change attributes of root window
> +		allow $3 $1_root_window_t:window { enumerate setattr };
> +		# can enumerate, set, and change attributes of all non-root windows
> +		allow $3 domain:window { enumerate getattr setattr };
> +		# can map and unmap all non-root windows
> +		allow $3 domain:window { map unmap move ctrllife };
> +		# can send various events to all non-root windows
> +		allow $3 domain:window { windowchangeevent clientcomevent };
> +		# can reparent all non-root windows
> +		allow $3 domain:window { chparent chstack };
> +		# can list properties of all non-root windows
> +		allow $3 domain:window listprop;

> +		# X Input
> +		# can change input focus on all windows
> +		allow $3 domain:window setfocus;

domain attribute can't be used here, since its not owned by this module.
Its overly broad too.  One thing to investigate would be adding an
attribute, something like xserver_xclient_type for all X clients, and
then use that here.  Then that attribute would be added to a domain,
perhaps via xserver_user_client_template().


> +template(`xwindows_displaymgr_client',`
> +	gen_require(`
> +		class xextension use;
> +	')

> +	xwindows_basic_client($1,$2,$3,$4)

> +	tunable_policy(`xwindows_object_manager',`
> +		# X Protocol Extensions
> +		allow $3 output_xext_t:xextension use;
> +
> +		# allow server grabs
> +		allow $3 $1_xserver_t:xserver { grab ungrab };
> +		allow $3 $1_xserver_t:xinput { getattr activegrab };
> +
> +		# can move the mouse cursor
> +		allow $3 $1_xserver_t:xinput warppointer;
> +
> +		# can set resource manager properties
> +		allow $3 $2_rm_xproperty_t:property { write free };
> +
> +		# can enumerate windows
> +		allow $3 $1_root_window_t:window enumerate;
> +	')
> +')

I suspect this might work as part of xserver_user_client_template(), but
the derived type for the property is going to be a problem.


> +template(`xwindows_resourcemgr_client',`
> +	gen_require(`
> +		class property all_property_perms;
> +	')

> +	tunable_policy(`xwindows_object_manager',`
> +		# X Properties
> +		# can read and write resource manager settings
> +		allow $3 $2_rm_xproperty_t:property { read write };
> +	')
> +')

Not sure why there is no $1.  Do you anticipate this being used outside
of the one use in the patch?  If not, the rule might as well go in the
caller.


> Index: policy/modules/services/xserver.if
> ===================================================================
> --- policy/modules/services/xserver.if	(revision 2180)
> +++ policy/modules/services/xserver.if	(working copy)
> @@ -90,6 +90,13 @@
>  	kernel_read_kernel_sysctls($1_xserver_t)
>  	kernel_write_proc_files($1_xserver_t)
>  
> +	# X server userspace object manager
> +	tunable_policy(`xwindows_object_manager',`
> +		allow $1_xserver_t self:netlink_audit_socket create;
> +		allow $1_xserver_t self:netlink_selinux_socket { bind create read };
> +		allow $1_xserver_t security_t:security { check_context compute_av compute_create };

This should be:

send_audit_msgs_pattern($1_xserver_t)
selinux_validate_context($1_xserver_t)
selinux_compute_access_vector($1_xserver_t)
selinux_compute_create_context($1_xserver_t)

> Index: policy/modules/system/unconfined.if
> ===================================================================
> --- policy/modules/system/unconfined.if	(revision 2180)
> +++ policy/modules/system/unconfined.if	(working copy)
> @@ -31,6 +42,19 @@
>  	allow $1 self:nscd *;
>  	allow $1 self:dbus *;
>  	allow $1 self:passwd *;
> +	tunable_policy(`xwindows_object_manager',`
> +		allow $1 self:drawable *;
> +		allow $1 self:window *;
> +		allow $1 self:gc *;
> +		allow $1 self:font *;
> +		allow $1 self:colormap *;
> +		allow $1 self:property *;
> +		allow $1 self:cursor *;
> +		allow $1 self:xclient *;
> +		allow $1 self:xserver *;
> +		allow $1 self:xinput *;
> +		allow $1 self:xextension *;
> +	')

I don't think this needs to be tunable.  It probably should go in an
xserver_unconfined() too (as should the classes for the other userland
object managers for that matter).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
