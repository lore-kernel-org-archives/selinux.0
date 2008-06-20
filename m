Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5KJtOVd004222
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 15:55:24 -0400
Message-ID: <485C0B2A.6050809@tycho.nsa.gov>
Date: Fri, 20 Jun 2008 15:55:22 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: x_extension use
References: <cadfc0e40806191533j265e146q2070b19d2bcd10d@mail.gmail.com>
In-Reply-To: <cadfc0e40806191533j265e146q2070b19d2bcd10d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> I'm seeing a number of AVCs out of gnome applications for a range of X
> extensions. Now I wondering about allowing access to X extensions. In
> general should apps be able to use any extension or are there specific
> one that need greater access control?
>   

First, the mechanics of the check: the way it's supposed to work is that 
the application first calls XQueryExtension to see if the extension is 
present.  This results in a check on the "query" permission, which you 
are not seeing in your AVC's because there is a dontaudit rule for it.  
If the "query" permission is denied, then the X server reports the 
extension as not being present.  The application is then supposed to 
either fail gracefully, or find some other way of doing its job.

Since you are in permissive mode, the query checks are succeeding and 
the apps are going on to use the extension.  There is no dontaudit rule 
for "use" so you get AVC's.  You _could_ try going into enforcing.  It 
might just work, since the query will be denied and it will appear as 
though the extension isn't supported.  However obviously if the app 
needs the extension to work, you'll have to grant access.


Now, as far as which extensions are good and which are bad, I tried to 
put them in different categories in the x_contexts file.  For example, 
GLX is the OpenGL extension so I labeled it accelgraphics_xext_t.  Chris 
has done some experimentation which resulted in changing the labels on 
some extensions.  A basic extension policy would be to only restrict 
access to the extensions that are specifically for debugging: XTest, 
XTrap, and RECORD.  From there, the controls can gradually be tightened 
up, for example by only allowing gnome-screensaver to touch the screen 
saver extension.

The extension controls are supposed to be a coarse-grained mechanism.  
In a perfect world, the fine-grained controls would capture what the 
application is doing at a lower level (touching this window or that 
device, etc). 

I have been actively campaigning upstream to try and reduce the number 
of extensions in the current Xorg server.


> type=USER_AVC msg=audit(1213883752.209:892): user pid=23989 uid=0
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>  { use } for request=RANDR:QueryVersion comm=gnome-session
> extension=RANDR scontext=user_u:user_r:user_t:s0
> tcontext=system_u:object_r:output_xext_t:s0 tclass=x_extension :
> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
> type=USER_AVC msg=audit(1213883755.647:918): user pid=23989 uid=0
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>  { use } for request=XFree86-VidModeExtension:QueryVersion
> comm=gnome-screensaver extension=XFree86-VidModeExtension
> scontext=user_u:user_r:user_t:s0
> tcontext=system_u:object_r:directhw_xext_t:s0 tclass=x_extension :
> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
> type=USER_AVC msg=audit(1213883796.665:934): user pid=23989 uid=0
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>  { use } for request=DPMS:Capable comm=gnome-power-manager
> extension=DPMS scontext=user_u:user_r:user_t:s0
> tcontext=system_u:object_r:screensaver_xext_t:s0 tclass=x_extension :
> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
> type=USER_AVC msg=audit(1213884106.649:948): user pid=23989 uid=0
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>  { use } for request=XFree86-Misc:SetGrabKeysState
> comm=gnome-screensaver extension=XFree86-Misc
> scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:xext_t:s0
> tclass=x_extension : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
> terminal=?)'
> type=USER_AVC msg=audit(1213889695.688:955): user pid=23989 uid=0
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>  { use } for request=GLX:QueryVersion
> comm=/usr/libexec/gnome-screensaver-gl-helper extension=GLX
> scontext=user_u:user_r:user_t:s0
> tcontext=system_u:object_r:accelgraphics_xext_t:s0 tclass=x_extension
> : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
