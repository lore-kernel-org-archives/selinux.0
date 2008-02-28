Message-ID: <47C6C16D.1010002@redhat.com>
Date: Thu, 28 Feb 2008 09:13:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Tonights rawhide contains a fix to stop xspy.
References: <47C63353.9040008@redhat.com> <47C6650F.2060909@tycho.nsa.gov>
In-Reply-To: <47C6650F.2060909@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eamon Walsh wrote:
> Daniel J Walsh wrote:
> Basically if you turn on xserver_object_manager boolean, no applications
> will be allowed to read the x_device.  This stops xspy as you said dead
> in its tracks,  but some other applications start to get AVC's around
> querypointer, and eventually I hung the server.  You mentioned in
> another email, that you were going to change the querypointer to a
> getattr rather then a read, I think this is necessary, to make this work.
>   
> 
>> I have attached a patch that will do this.  There is another request,
>> XKEYBOARD:GetState, that also requires read and I've noticed that
>> gnome-settings-daemon is calling it (see below).  If you want to drop
>> that down to getattr too, let me know; it doesn't look like it returns
>> the whole keyboard like XQueryKeymap does, however both it and
>> XQueryPointer return the mouse buttons and the modifier keys (shift,
>> alt, ctrl, etc.).  Long-term we really need to get applications to stop
>> calling these.
>
Is there any way to differentiate the mouse from the keyboard, why are
the the same type?  Can you get this patch upstream, it is a lot easier
to get it into rawhide that way.

Open bugzilla's on any you find, is the best way to get it fixed.

>> "Manage" permission on devices is another can of worms you may care to
>> open at some point.  Anyone with that can remap the keys or do other
>> things that affect the device globally.
> 
>> The other AVC's I'm getting are from interactions between staff_mono and
>> staff.  I believe that this the result of a small application such as
>> the clock or load graph being staff_mono_t, running inside gnome-panel
>> which is staff_t.  This is the type of thing I was trying to solve with
>> the 4-argument templates that allowed some permissions among the entire
>> "role's" windows (however manage was not one of them).
> 
Yes this is one of the reasons that I like the ability to extend
contexts so all privs of staff_t are inherited by staff_mono_t plus the
exec checks.

staff_mono_t == staff_t + execmem execstack;


I think we are going to need an interface that says one domain can play
communicate with another domain, sort of the dbus_chat type interfaces.

I have not looked at interaction between staff_mozilla_t and staff_t yet.

>> avc:  denied  { use } for request=XTEST:GrabControl
>> comm=/usr/libexec/at-spi-registryd extension=XTEST
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=system_u:object_r:debug_xext_t:s0 tclass=x_extension
>> avc:  denied  { read } for request=XKEYBOARD:GetState
>> comm=/usr/libexec/gnome-settings-daemon xdevice="Virtual core keyboard"
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device
>> avc:  denied  { manage } for request=XKEYBOARD:SetMap
>> comm=/usr/libexec/gnome-settings-daemon xdevice="Virtual core keyboard"
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device
>> avc:  denied  { use } for request=RANDR:GetScreenSizeRange
>> comm=/usr/libexec/gnome-settings-daemon extension=RANDR
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=system_u:object_r:output_xext_t:s0 tclass=x_extension
>> avc:  denied  { receive } for request=X11:ChangeWindowAttributes
>> comm=mono resid=1400006 restype=WINDOW
>> scontext=staff_u:staff_r:staff_mono_t:s0
>> tcontext=staff_u:object_r:staff_t:s0 tclass=x_drawable
>> avc:  denied  { getattr } for request=X11:GetWindowAttributes comm=mono
>> resid=1400006 restype=WINDOW scontext=staff_u:staff_r:staff_mono_t:s0
>> tcontext=staff_u:object_r:staff_t:s0 tclass=x_drawable
>> avc:  denied  { list_child } for request=X11:QueryTree comm=mono
>> resid=1400006 restype=WINDOW scontext=staff_u:staff_r:staff_mono_t:s0
>> tcontext=staff_u:object_r:staff_t:s0 tclass=x_drawable
>> avc:  denied  { get_property } for request=X11:GetProperty comm=mono
>> resid=1400006 restype=WINDOW scontext=staff_u:staff_r:staff_mono_t:s0
>> tcontext=staff_u:object_r:staff_t:s0 tclass=x_drawable
>> avc:  denied  { read } for request=X11:GetProperty comm=mono
>> property=_XSETTINGS_SETTINGS scontext=staff_u:staff_r:staff_mono_t:s0
>> tcontext=staff_u:object_r:staff_default_xproperty_t:s0 tclass=x_property
>> avc:  denied  { list_child } for request=X11:QueryTree
>> comm=gnome-screensaver resid=4e00001 restype=WINDOW
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { get_property } for request=X11:GetProperty
>> comm=/usr/libexec/gnome-settings-daemon resid=4e00001 restype=WINDOW
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { read } for request=X11:GetProperty
>> comm=/usr/libexec/gnome-settings-daemon property=WM_NAME
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_default_xproperty_t:s0
>> tclass=x_property
>> avc:  denied  { getattr } for request=X11:GetWindowAttributes
>> comm=gnome-screensaver resid=4e00001 restype=WINDOW
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { receive } for request=X11:ChangeWindowAttributes
>> comm=gnome-screensaver resid=4e00001 restype=WINDOW
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { receive } for  comm=/usr/libexec/gnome-settings-daemon
>> event=X11:PropertyNotify scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_property_xevent_t:s0 tclass=x_event
>> avc:  denied  { receive } for  comm=/usr/libexec/gnome-settings-daemon
>> event=X11:CreateNotify scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_manage_xevent_t:s0 tclass=x_event
>> avc:  denied  { hide } for request=X11:UnmapWindow comm=gnome-panel
>> resid=4e00021 restype=WINDOW scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { manage } for request=X11:ReparentWindow comm=gnome-panel
>> resid=4e00021 restype=WINDOW scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { send } for request=X11:SendEvent comm=gnome-panel
>> resid=4e00021 restype=WINDOW scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { send } for request=X11:SendEvent comm=gnome-panel
>> event=X11:ClientMessage scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_client_xevent_t:s0
>> tclass=x_synthetic_event
>> avc:  denied  { setattr } for request=X11:ConfigureWindow
>> comm=gnome-panel resid=4e00021 restype=WINDOW
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { set_property } for request=X11:ChangeProperty
>> comm=gnome-panel resid=4e00021 restype=WINDOW
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { show } for request=X11:MapWindow comm=gnome-panel
>> resid=4e00021 restype=WINDOW scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_t:s0 tclass=x_drawable
>> avc:  denied  { receive } for  comm=gnome-screensaver event=X11:Expose
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=staff_u:object_r:staff_mono_default_xevent_t:s0 tclass=x_event
>> avc:  denied  { use } for request=GLX:QueryVersion
>> comm=/usr/libexec/gnome-screensaver-gl-helper extension=GLX
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=system_u:object_r:accelgraphics_xext_t:s0 tclass=x_extension
> 
> 
> 
> 
> #============= mono_t ==============
> allow mono_t xdm_xserver_t:x_device read;
> 
> #============= unconfined_t ==============
> allow unconfined_t xdm_xserver_t:x_device read;
> 
> #============= xdm_t ==============
> allow xdm_t xdm_xserver_t:x_device read;
> 
> type=USER_AVC msg=audit(1204170576.402:774): user pid=2729 uid=0
> auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
> msg='avc:  denied  { read } for request=X11:QueryPointer comm=mono
> xdevice="Virtual core pointer"
> scontext=unconfined_u:unconfined_r:mono_t:s0
> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device
> : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfGwW0ACgkQrlYvE4MpobNbrwCePmOPBq29FGi+m07NXKpJeORs
JZgAoMPYEhEitxrnWyHI1tiOjSam8pNj
=eF82
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
