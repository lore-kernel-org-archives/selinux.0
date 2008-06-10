Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5AECENH002518
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 10:12:14 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5AECB3e023295
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 14:12:11 GMT
Received: by yx-out-1718.google.com with SMTP id 3so239304yxi.84
        for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 07:12:10 -0700 (PDT)
Message-ID: <484E8BB3.1070505@gmail.com>
Date: Tue, 10 Jun 2008 09:12:03 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: X in MLS enforcing problem
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>	 <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com> <cadfc0e40806091535k1929bbc8gd4eebefb4b6069ff@mail.gmail.com> <484DC4D2.7050201@tycho.nsa.gov>
In-Reply-To: <484DC4D2.7050201@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Xavier Toth wrote:
>
> [snip]
>
>> Now I looking at the USER_AVCs and trying to figure out how to
>> translate those into policy. Will audit2allow be updated to help with
>> generating rules for the X USER_AVCs?
>>   
>
> The stock audit2allow parses my audit.log just fine.  It doesn't work 
> for you?

It does I just made a mistake when copy/pasting AVCs while experimenting :(
>
>
>> For those who haven't seen the X user space object manager AVCs here
>> are some examples:
>> type=USER_AVC msg=audit(1213049927.142:132): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { blend } for request=X11:CreateWindow comm=dbus-launch resid=800001
>> restype=WINDOW scontext=user_u:user_r:user_t:s0
>> tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>   
>
> This is a program attempting to create a window with no background.  
> The denial will cause the window background to be filled in with a 
> solid color.
>
> Dontaudit should work here.
>
> However, window managers do need the blend permission (on all 
> windows).  The "compositing" feature requires this permission.
>
>
>> type=USER_AVC msg=audit(1213049927.144:133): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { setattr } for request=X11:SetSelectionOwner comm=dbus-launch
>> selection=_DBUS_SESSION_BUS_SELECTION_tedx_caa2282936b539cb3e36c2ae4845ed0b 
>>
>> scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:object_r:xselection_t:s0 tclass=x_selection :
>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>   
>
> This is a known issue.  I have not found an explanation yet for the 
> purpose of these D-BUS selections.
>
> There is no easy solution here.  The selabel system cannot handle 
> these funky names.  Even if there was regexp support, as Chris has 
> indicated the name contains a username, implying that it should be 
> labeled with a derived type.
>
> I think the "dbus-launch" program needs to undergo surgery to either 
> not create these things or to label them explicitly.
>
>

So what's the way forward here, open a bug against dbus? If the other 
AVCs are addressed would this still cause a session abend?

>> type=USER_AVC msg=audit(1213049927.227:134): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { manage } for request=X11:ChangeHosts comm=xhost
>> scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tclass=x_server : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
>> terminal=?)'
>>   
>
> Somewhere in the startup scripts xhost is being called to fiddle with 
> the lists of hosts that can connect to the server.
>
> Either solve the xdm_xserver_t versus user_xserver_t problem, which 
> has been much discussed, or grant the permission above, and rely on 
> the Xauthority mechanism to keep people from running xhost on other 
> people's servers.
>
> As to the former, I'm trying to get something working with setcon and 
> my GDM/pam_selinux patches.
>
>
>> type=USER_AVC msg=audit(1213049927.653:135): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { blend } for request=X11:CreateWindow comm=gnome-session
>> resid=800001 restype=WINDOW scontext=user_u:user_r:user_t:s0
>> tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>> type=USER_AVC msg=audit(1213049927.656:136): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { blend } for request=X11:CreateWindow comm=gnome-session
>> resid=800002 restype=WINDOW scontext=user_u:user_r:user_t:s0
>> tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>   
>
> More blend errors.
>
>
>> type=USER_AVC msg=audit(1213049927.659:137): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { getattr } for request=X11:QueryPointer comm=gnome-session
>> xdevice="Virtual core pointer" scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
>> terminal=?)'
>>   
>
> The default label for devices is the server's context.  Another xdm / 
> user issue.
>
> My GDM/pam_selinux patches attempt to relabel the devices to the 
> user's context, the same way the terminal is relabeled when you log in 
> at the console.
>
>
>> type=USER_AVC msg=audit(1213049927.661:138): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { use } for request=XKEYBOARD:SelectEvents comm=gnome-session
>> xdevice="Virtual core keyboard" scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
>> terminal=?)'
>> type=USER_AVC msg=audit(1213049927.661:139): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { use } for request=XKEYBOARD:SelectEvents comm=gnome-session
>> xdevice="Virtual core keyboard" scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
>> terminal=?)'
>> type=USER_AVC msg=audit(1213049927.661:140): user pid=2636 uid=0
>> auid=4294967295 ses=4294967295
>> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>>  { getattr setattr } for request=XKEYBOARD:PerClientFlags
>> comm=gnome-session xdevice="Virtual core keyboard"
>> scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
>> terminal=?)'
>>   
>
> More device errors.
>
>> type=ANOM_ABEND msg=audit(1213049927.662:141): auid=500 uid=500
>> gid=500 ses=4 subj=user_u:user_r:user_t:s0 pid=3280
>> comm="gnome-session" sig=5
>>   
>
> Standard error handling behavior for the desktop.
>
>
>
>> type=CRED_DISP msg=audit(1213049927.674:142): user pid=2720 uid=0
>> auid=500 ses=4 subj=system_u:system_r:xdm_t:s0-s15:c0.c1023
>> msg='op=PAM:setcred acct="tedx" exe="/usr/libexec/gdm-session-worker"
>> (hostname=?, addr=?, terminal=:0 res=success)'
>> type=USER_END msg=audit(1213049927.697:143): user pid=2720 uid=0
>> auid=500 ses=4 subj=system_u:system_r:xdm_t:s0-s15:c0.c1023
>> msg='op=PAM:session_close acct="tedx"
>> exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=:0
>> res=success)'
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>>   
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
