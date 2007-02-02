Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l12GqGhU029977
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 11:52:16 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l12GrLJx022281
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 16:53:21 GMT
Received: by nz-out-0506.google.com with SMTP id z3so817924nzf
        for <selinux@tycho.nsa.gov>; Fri, 02 Feb 2007 08:53:20 -0800 (PST)
Message-ID: <45C36C7C.2020102@gmail.com>
Date: Fri, 02 Feb 2007 10:53:16 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] refpolicy: experimental X policy
References: <45B938EE.8010303@tycho.nsa.gov>
In-Reply-To: <45B938EE.8010303@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I try and start X I'm getting :
(EE) VESA(0): Cannot open /dev/mem
(EE) Screen(s) found, but none have a usable configuration.

Does the policy need to change to allow access to /dev/mem?

Ted

Eamon Walsh wrote:
> This is an experimental policy for use with the X userspace object 
> manager.  It includes both unconfined and strict policy and is 
> controlled by a tunable, xwindows_object_manager.  The labeling conf 
> file in the X.org xserver git (XACE-SELINUX branch) assumes that this 
> policy is loaded, i.e. the types listed in that file are defined in 
> this policy.
>
> The target audience for this is people experimenting with the X object 
> manager.
>
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
>
> ---
>
> policy/global_tunables              |    7 
> policy/modules/services/xserver.if  |   14 
> policy/modules/services/xwindows.fc |   13 
> policy/modules/services/xwindows.if |  522 
> ++++++++++++++++++++++++++++++++++++
> policy/modules/services/xwindows.te |   65 ++++
> policy/modules/system/unconfined.if |   24 +
> 6 files changed, 645 insertions(+)
>
> ---
> Index: policy/modules/services/xwindows.te
> ===================================================================
> --- policy/modules/services/xwindows.te    (revision 0)
> +++ policy/modules/services/xwindows.te    (revision 0)
> @@ -0,0 +1,65 @@
> +
> +policy_module(xwindows,1.0.0)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +# X Window System userspace-managed objects
> +attribute xclient_type;
> +attribute xwindow_type;
> +attribute xproperty_type;
> +attribute xextension_type;
> +
> +# Default type for remotely connected clients
> +type remote_xclient_t, xclient_type;
> +
> +# X Property types and attributes
> +attribute client_xproperty_type;
> +attribute info_xproperty_type;
> +attribute seclabel_xproperty_type;
> +attribute rm_xproperty_type;
> +attribute wm_xproperty_type;
> +attribute clipboard_xproperty_type;
> +attribute unknown_xproperty_type;
> +
> +type client_xproperty_t, client_xproperty_type, xproperty_type;
> +type info_xproperty_t, info_xproperty_type, xproperty_type;
> +type seclabel_xproperty_t, seclabel_xproperty_type, xproperty_type;
> +type rm_xproperty_t, rm_xproperty_type, xproperty_type;
> +type wm_xproperty_t, wm_xproperty_type, xproperty_type;
> +type clipboard_xproperty_t, clipboard_xproperty_type, xproperty_type;
> +type unknown_xproperty_t, unknown_xproperty_type, xproperty_type;
> +
> +# X Extension types
> +type accelgraphics_xext_t, xextension_type;
> +type debug_xext_t, xextension_type;
> +type font_xext_t, xextension_type;
> +type input_xext_t, xextension_type;
> +type output_xext_t, xextension_type;
> +type screensaver_xext_t, xextension_type;
> +type security_xext_t, xextension_type;
> +type shmem_xext_t, xextension_type;
> +type std_xext_t, xextension_type;
> +type video_xext_t, xextension_type;
> +type unknown_xext_t, xextension_type;
> +type windowmgr_xext_t, xextension_type;
> +
> +
> +# X client domains
> +
> +# Display Manager
> +# defined in services/xserver.te
> +
> +# Window Manager
> +type xwm_exec_t;
> +corecmd_executable_file(xwm_exec_t)
> +
> +# Resource Manager
> +type xrdb_exec_t;
> +corecmd_executable_file(xrdb_exec_t)
> +
> +# Protected test client
> +type xprotected_exec_t;
> +corecmd_executable_file(xprotected_exec_t)
> Index: policy/modules/services/xwindows.fc
> ===================================================================
> --- policy/modules/services/xwindows.fc    (revision 0)
> +++ policy/modules/services/xwindows.fc    (revision 0)
> @@ -0,0 +1,13 @@
> +#
> +# /usr
> +#
> +
> +/usr/bin/(t|m|fv)wm    --    
> gen_context(system_u:object_r:xwm_exec_t,s0)
> +/usr/bin/metacity    --    gen_context(system_u:object_r:xwm_exec_t,s0)
> +/usr/bin/xrdb        --    gen_context(system_u:object_r:xrdb_exec_t,s0)
> +/usr/bin/xeyes        --    
> gen_context(system_u:object_r:xprotected_exec_t,s0)
> +
> +/usr/X11R6/bin/(t|m|fv)wm    --    
> gen_context(system_u:object_r:xwm_exec_t,s0)
> +/usr/X11R6/bin/metacity        --    
> gen_context(system_u:object_r:xwm_exec_t,s0)
> +/usr/X11R6/bin/xrdb        --    
> gen_context(system_u:object_r:xrdb_exec_t,s0)
> +/usr/X11R6/bin/xeyes        --    
> gen_context(system_u:object_r:xprotected_exec_t,s0)
> Index: policy/modules/services/xwindows.if
> ===================================================================
> --- policy/modules/services/xwindows.if    (revision 0)
> +++ policy/modules/services/xwindows.if    (revision 0)
> @@ -0,0 +1,522 @@
> +## <summary>X Window System Userspace Object Manager</summary>
> +
> +#######################################
> +## <summary>
> +##    Declares a single X property type using a user prefix
> +##    and base type, along with appropriate transition rules.
> +## </summary>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="type">
> +##    <summary>
> +##    Base X property type
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_property',`
> +    gen_require(`
> +        type $1_t;
> +        type $2;
> +        attribute xproperty_type;
> +        attribute $1_xproperty_type;
> +        attribute $2ype;
> +        class property all_property_perms;
> +    ')
> +
> +    ##############################
> +    #
> +    # Declarations
> +    #
> +
> +    type $1_$2, $1_xproperty_type, $2ype, xproperty_type;
> +    type_transition $1_t $2:property $1_$2;
> +')
> +
> +#######################################
> +## <summary>
> +##    Declares a set of X property types for use with an X
> +##    client domain.
> +## </summary>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_property_set',`
> +
> +    ##############################
> +    #
> +    # Declarations
> +    #
> +
> +    attribute $1_xproperty_type;
> +    xwindows_property($1,client_xproperty_t)
> +    xwindows_property($1,info_xproperty_t)
> +    xwindows_property($1,seclabel_xproperty_t)
> +    xwindows_property($1,rm_xproperty_t)
> +    xwindows_property($1,wm_xproperty_t)
> +    xwindows_property($1,clipboard_xproperty_t)
> +    xwindows_property($1,unknown_xproperty_t)
> +')
> +
> +#######################################
> +## <summary>
> +##    Template to provide X object permissions on a given X server to
> +##    an X client domain.  Provides the minimal set required by a basic
> +##    X client application.
> +## </summary>
> +## <param name="server_prefix">
> +##    <summary>
> +##    The prefix of the server domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the client domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="domain">
> +##    <summary>
> +##    Client domain allowed access.
> +##    </summary>
> +## </param>
> +## <param name="role">
> +##    <summary>
> +##    The role associated with the client domain.
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_basic_client',`
> +    gen_require(`
> +        type $1_xserver_t;
> +        type $1_root_window_t;
> +        type $1_xserver_rm_xproperty_t;
> +        type $2_info_xproperty_t;
> +        type $1_xserver_info_xproperty_t;
> +        type $1_xserver_clipboard_xproperty_t;
> +        type $2_client_xproperty_t;
> +        attribute $2_xproperty_type;
> +        class drawable all_drawable_perms;
> +        class window all_window_perms;
> +        class gc all_gc_perms;
> +        class font all_font_perms;
> +        class colormap all_colormap_perms;
> +        class property all_property_perms;
> +        class cursor all_cursor_perms;   
> +        class xclient all_xclient_perms;
> +        class xserver all_xserver_perms;
> +        class xinput all_xinput_perms;
> +        class xextension all_xextension_perms;
> +    ')
> +
> +    ##############################
> +    #
> +    # Local Policy
> +    #
> +
> +        tunable_policy(`xwindows_object_manager',`
> +        # X Protocol Extensions
> +        allow $3 xextension_type:xextension query;
> +        allow $3 std_xext_t:xextension use;
> +        allow $3 input_xext_t:xextension use;
> +        allow $3 font_xext_t:xextension use;
> +        allow $3 shmem_xext_t:xextension use;
> +
> +        # X Properties
> +        # can read resource manager settings on the root window
> +        allow $3 $1_xserver_rm_xproperty_t:property read;
> +        # can read info properties
> +        allow $3 $2_info_xproperty_t:property read;
> +        allow $3 $1_xserver_info_xproperty_t:property read;
> +        # can read and write client properties
> +        allow $3 $2_client_xproperty_t:property { read write free };
> +        # can read and write cut buffers on the root window
> +        allow $3 $1_xserver_clipboard_xproperty_t:property { read 
> write free };
> +
> +        # X Windows
> +        # can get attributes of root window
> +        allow $3 $1_root_window_t:window getattr;
> +        # can add children to root window
> +        allow $3 $1_root_window_t:window { addchild chstack };
> +        # can change properties of root window
> +        allow $3 $1_root_window_t:window { listprop chprop chproplist };
> +
> +        # can query window manager windows (GTK2 thing?)
> +    #    allow $3 $1_xwm_t:window { enumerate getattr };
> +    #    allow $3 $1_xwm_t:drawable getattr;
> +
> +        # X Fonts
> +        allow $3 self:font { use free };
> +
> +        # X Input
> +        # can set focus on own windows
> +        allow $3 self:window setfocus;
> +        allow $3 $1_xserver_t:xinput { setfocus getattr };
> +        # can track mouse motions on own windows
> +        allow $3 self:window mousemotion;
> +        # can create and use cursors
> +        allow $3 self:cursor { createglyph setattr free };
> +        # can set selections on own windows
> +        allow $3 self:window chselection;
> +
> +        # X Drawing
> +        # can query root window attributes
> +        allow $3 $1_root_window_t:drawable getattr;
> +        allow $3 $1_xserver_t:colormap { read store };
> +        allow $3 $1_xserver_t:font { load use free };
> +        allow $3 self:drawable { create getattr draw copy destroy };
> +        allow $3 self:gc { create setattr free };
> +        allow $3 self:window { addchild chprop chproplist chstack 
> create destroy enumerate getattr listprop map move setattr unmap };
> +    ')
> +')
> +
> +#######################################
> +## <summary>
> +##    Template to provide X object permissions to an X window manager.
> +## </summary>
> +## <param name="server_prefix">
> +##    <summary>
> +##    The prefix of the server domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the client domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="domain">
> +##    <summary>
> +##    Client domain allowed access.
> +##    </summary>
> +## </param>
> +## <param name="role">
> +##    <summary>
> +##    The role associated with the client domain.
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_windowmgr_client',`
> +    gen_require(`
> +        class xextension use;
> +    ')
> +
> +    ##############################
> +    #
> +    # Declarations
> +    #
> +
> +    xwindows_basic_client($1,$2,$3,$4)
> +
> +    ##############################
> +    #
> +    # Local Policy
> +    #
> +
> +    tunable_policy(`xwindows_object_manager',`
> +        # X Protocol Extensions
> +        allow $3 windowmgr_xext_t:xextension use;
> +
> +        # X Properties
> +        # can read all security labels
> +        allow $3 seclabel_xproperty_type:property read;
> +        # can read and write all wm-specific properties
> +        allow $3 wm_xproperty_type:property { read write };
> +        # can set properties on all windows
> +        allow $3 domain:window { chprop chproplist };
> +
> +        # can install colormaps
> +        allow $3 $1_xserver_t:colormap install;
> +
> +        # X Windows - extensive control over all windows
> +        # can query windows for visual information
> +        allow $3 domain:drawable getattr;
> +        # can enumerate and change attributes of root window
> +        allow $3 $1_root_window_t:window { enumerate setattr };
> +        # can enumerate, set, and change attributes of all non-root 
> windows
> +        allow $3 domain:window { enumerate getattr setattr };
> +        # can map and unmap all non-root windows
> +        allow $3 domain:window { map unmap move ctrllife };
> +        # can send various events to all non-root windows
> +        allow $3 domain:window { windowchangeevent clientcomevent };
> +        # can reparent all non-root windows
> +        allow $3 domain:window { chparent chstack };
> +        # can list properties of all non-root windows
> +        allow $3 domain:window listprop;
> +
> +        # X Input
> +        # can change input focus on all windows
> +        allow $3 domain:window setfocus;
> +        allow $3 $1_root_window_t:window setfocus;
> +        allow $3 $1_xserver_t:xinput setfocus;
> +        # can move the mouse cursor
> +        allow $3 $1_xserver_t:xinput warppointer;
> +        # can grab server
> +        allow $3 $1_xserver_t:xserver { grab ungrab };
> +        allow $3 $1_xserver_t:xinput { activegrab passivegrab ungrab };
> +
> +        # X Drawing
> +        # can draw on the root window
> +        allow $3 $1_root_window_t:drawable draw;
> +    ')
> +')
> +
> +#######################################
> +## <summary>
> +##    Template to provide X object permissions to an X display manager.
> +## </summary>
> +## <param name="server_prefix">
> +##    <summary>
> +##    The prefix of the server domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the client domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="domain">
> +##    <summary>
> +##    Client domain allowed access.
> +##    </summary>
> +## </param>
> +## <param name="role">
> +##    <summary>
> +##    The role associated with the client domain.
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_displaymgr_client',`
> +    gen_require(`
> +        class xextension use;
> +    ')
> +
> +    ##############################
> +    #
> +    # Declarations
> +    #
> +
> +    xwindows_basic_client($1,$2,$3,$4)
> +
> +    ##############################
> +    #
> +    # Local Policy
> +    #
> +
> +    tunable_policy(`xwindows_object_manager',`
> +        # X Protocol Extensions
> +        allow $3 output_xext_t:xextension use;
> +
> +        # allow server grabs
> +        allow $3 $1_xserver_t:xserver { grab ungrab };
> +        allow $3 $1_xserver_t:xinput { getattr activegrab };
> +
> +        # can move the mouse cursor
> +        allow $3 $1_xserver_t:xinput warppointer;
> +
> +        # can set resource manager properties
> +        allow $3 $2_rm_xproperty_t:property { write free };
> +
> +        # can enumerate windows
> +        allow $3 $1_root_window_t:window enumerate;
> +    ')
> +')
> +
> +#######################################
> +## <summary>
> +##    Template to provide X object permissions to an X resource manager.
> +## </summary>
> +## <param name="server_prefix">
> +##    <summary>
> +##    The prefix of the server domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the client domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="domain">
> +##    <summary>
> +##    Client domain allowed access.
> +##    </summary>
> +## </param>
> +## <param name="role">
> +##    <summary>
> +##    The role associated with the client domain.
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_resourcemgr_client',`
> +    gen_require(`
> +        class property all_property_perms;
> +    ')
> +
> +    ##############################
> +    #
> +    # Local Policy
> +    #
> +
> +    tunable_policy(`xwindows_object_manager',`
> +        # X Properties
> +        # can read and write resource manager settings
> +        allow $3 $2_rm_xproperty_t:property { read write };
> +    ')
> +')
> +
> +#######################################
> +## <summary>
> +##    Template to provide X object permissions to an X server domain.
> +## </summary>
> +## <param name="prefix">
> +##    <summary>
> +##    The prefix of the domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="domain">
> +##    <summary>
> +##    Domain allowed access.
> +##    </summary>
> +## </param>
> +## <param name="role">
> +##    <summary>
> +##    The role associated with the domain.
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_server',`
> +    gen_require(`
> +        attribute xwindow_type;
> +        class window map;
> +        class drawable draw;
> +    ')
> +
> +    ##############################
> +    #
> +    # Declarations
> +    #
> +
> +    # Type for the root window
> +    type $1_root_window_t, xwindow_type;
> +    role $3 types $1_root_window_t;
> +
> +    # Types for properties
> +    xwindows_property_set($1_xserver)
> +    role $3 types $1_xserver_xproperty_type;
> +
> +    ##############################
> +    #
> +    # Local Policy
> +    #
> +
> +    tunable_policy(`xwindows_object_manager',`
> +        # Labeling rules for root windows
> +        type_transition $2 $2:window $1_root_window_t;
> +        type_transition $2 $2:drawable $1_root_window_t;
> +
> +        # Allow server to map the root window
> +        allow $2 $1_root_window_t:window map;
> +    ')
> +')
> +
> +#######################################
> +## <summary>
> +##    The per role template for the xwindows module.
> +## </summary>
> +## <desc>
> +##    <p>
> +##    This template creates a derived domains which are used
> +##    for X userspace object manager related programs.
> +##    </p>
> +##    <p>
> +##    This template is invoked automatically for each user, and
> +##    generally does not need to be invoked directly
> +##    by policy writers.
> +##    </p>
> +## </desc>
> +## <param name="userdomain_prefix">
> +##    <summary>
> +##    The prefix of the user domain (e.g., user
> +##    is the prefix for user_t).
> +##    </summary>
> +## </param>
> +## <param name="user_domain">
> +##    <summary>
> +##    The type of the user domain.
> +##    </summary>
> +## </param>
> +## <param name="user_role">
> +##    <summary>
> +##    The role associated with the user domain.
> +##    </summary>
> +## </param>
> +#
> +template(`xwindows_per_role_template',`
> +
> +    ##############################
> +    #
> +    # Declarations
> +    #
> +
> +    # Types for window managers
> +    type $1_xwm_t;
> +    domain_type($1_xwm_t)
> +    domain_entry_file($1_xwm_t,xwm_exec_t)
> +    role $3 types $1_xwm_t;
> +
> +    # Types for resource managers
> +    type $1_xrdb_t;
> +    domain_type($1_xrdb_t)
> +    domain_entry_file($1_xrdb_t,xrdb_exec_t)
> +    role $3 types $1_xrdb_t;
> +
> +    # Protected test type
> +    type $1_xprotected_t;
> +    domain_type($1_xprotected_t)
> +    domain_entry_file($1_xprotected_t,xprotected_exec_t)
> +    role $3 types $1_xprotected_t;
> +
> +    # Types for properties
> +    xwindows_property_set($1)
> +    role $3 types $1_xproperty_type;
> +    xwindows_property_set($1_xwm)
> +    role $3 types $1_xwm_xproperty_type;
> +    xwindows_property_set($1_xrdb)
> +    role $3 types $1_xrdb_xproperty_type;
> +    xwindows_property_set($1_xprotected)
> +    role $3 types $1_xprotected_xproperty_type;
> +
> +    # Basic default client
> +    xwindows_basic_client($1,$1,$1_t,$3)
> +
> +    # Other clients
> +    xwindows_basic_client($1,$1_xprotected,$1_xprotected_t,$3)
> +    xwindows_windowmgr_client($1,$1_xwm,$1_xwm_t,$3)
> +    xwindows_resourcemgr_client($1,$1_xrdb,$1_xrdb_t,$3)
> +
> +    ##############################
> +    #
> +    # Local Policy
> +    #
> +
> +    tunable_policy(`xwindows_object_manager',`
> +        domain_auto_trans($2,xwm_exec_t,$1_xwm_t)
> +        domain_auto_trans($2, xrdb_exec_t, $1_xrdb_t)
> +        domain_auto_trans($2, xprotected_exec_t, $1_xprotected_t)
> +    ')
> +')
> +')
> Index: policy/modules/services/xserver.if
> ===================================================================
> --- policy/modules/services/xserver.if    (revision 2178)
> +++ policy/modules/services/xserver.if    (working copy)
> @@ -90,6 +90,13 @@
>     kernel_read_kernel_sysctls($1_xserver_t)
>     kernel_write_proc_files($1_xserver_t)
>
> +    # X server userspace object manager
> +    tunable_policy(`xwindows_object_manager',`
> +        allow $1_xserver_t self:netlink_audit_socket create;
> +        allow $1_xserver_t self:netlink_selinux_socket { bind create 
> read };
> +        allow $1_xserver_t security_t:security { check_context 
> compute_av compute_create };
> +    ')
> +
>     # Run helper programs in $1_xserver_t.
>     corecmd_search_sbin($1_xserver_t)
>     corecmd_exec_bin($1_xserver_t)
> @@ -267,6 +274,13 @@
>
>     ##############################
>     #
> +    # $1_xserver_t X Userspace Object Manager
> +    #
> +
> +    xwindows_server($1,$1_xserver_t,$3)
> +
> +    ##############################
> +    #
>     # $1_xserver_t Local policy
>     #
>
> Index: policy/modules/system/unconfined.if
> ===================================================================
> --- policy/modules/system/unconfined.if    (revision 2178)
> +++ policy/modules/system/unconfined.if    (working copy)
> @@ -15,6 +15,17 @@
>         class dbus all_dbus_perms;
>         class nscd all_nscd_perms;
>         class passwd all_passwd_perms;
> +        class drawable all_drawable_perms;
> +        class window all_window_perms;
> +        class gc all_gc_perms;
> +        class font all_font_perms;
> +        class colormap all_colormap_perms;
> +        class property all_property_perms;
> +        class cursor all_cursor_perms;   
> +        class xclient all_xclient_perms;
> +        class xserver all_xserver_perms;
> +        class xinput all_xinput_perms;
> +        class xextension all_xextension_perms;
>     ')
>
>     # Use any Linux capability.
> @@ -31,6 +42,19 @@
>     allow $1 self:nscd *;
>     allow $1 self:dbus *;
>     allow $1 self:passwd *;
> +    tunable_policy(`xwindows_object_manager',`
> +        allow $1 self:drawable *;
> +        allow $1 self:window *;
> +        allow $1 self:gc *;
> +        allow $1 self:font *;
> +        allow $1 self:colormap *;
> +        allow $1 self:property *;
> +        allow $1 self:cursor *;
> +        allow $1 self:xclient *;
> +        allow $1 self:xserver *;
> +        allow $1 self:xinput *;
> +        allow $1 self:xextension *;
> +    ')
>
>     kernel_unconfined($1)
>     corenet_unconfined($1)
> Index: policy/global_tunables
> ===================================================================
> --- policy/global_tunables    (revision 2178)
> +++ policy/global_tunables    (working copy)
> @@ -348,6 +348,13 @@
> ## </desc>
> gen_tunable(use_samba_home_dirs,false)
>
> +## <desc>
> +## <p>
> +## Support X userspace object manager
> +## </p>
> +## </desc>
> +gen_tunable(xwindows_object_manager,false)
> +
> ########################################
> #
> # Strict policy specific
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
