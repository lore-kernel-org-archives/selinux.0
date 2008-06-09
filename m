Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59MaI6f021059
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 18:36:18 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59MZuJb016094
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 22:35:57 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1605777fgg.40
        for <selinux@tycho.nsa.gov>; Mon, 09 Jun 2008 15:35:56 -0700 (PDT)
Message-ID: <cadfc0e40806091535k1929bbc8gd4eebefb4b6069ff@mail.gmail.com>
Date: Mon, 9 Jun 2008 17:35:55 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Chad Hanson" <chanson@TrustedCS.com>
Subject: Re: X in MLS enforcing problem
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>
	 <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 9, 2008 at 4:49 PM, Chad Hanson <chanson@trustedcs.com> wrote:
>
> mls_trusted_object(xdm_xserver_t) won't help this problem, but something
> like mls_file_read_up and mls_file_write_down would be more approriate
> for xdm_xserver_t.
>
> -Chad
>
>>
>> type=AVC msg=audit(1213041678.053:8): avc:  denied  { read } for
>> pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
>> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
>> tclass=chr_file
>> type=AVC msg=audit(1213041678.432:10): avc:  denied  { write } for
>> pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
>> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
>> tclass=chr_file
>>
>> The xserver_common_domain_template seems to have the necessary allow
>> rules (dev_read_raw_memory and dev_wx_raw_memory) for the types so  I
>> create a local module and added:
>> mls_trusted_object(xdm_xserver_t)
>> to deal with the MLS constraint violation but I'm still getting these
>> AVC.What else can it be?
>>
>> Ted
>>
>

Indeed that would only work if the target (the chr_file) were an
mls_trusted_object. So for now I'm using
mls_file_(read/write)_all_levels and those AVCs are handled.

Now I looking at the USER_AVCs and trying to figure out how to
translate those into policy. Will audit2allow be updated to help with
generating rules for the X USER_AVCs?
For those who haven't seen the X user space object manager AVCs here
are some examples:
type=USER_AVC msg=audit(1213049927.142:132): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { blend } for request=X11:CreateWindow comm=dbus-launch resid=800001
restype=WINDOW scontext=user_u:user_r:user_t:s0
tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213049927.144:133): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { setattr } for request=X11:SetSelectionOwner comm=dbus-launch
selection=_DBUS_SESSION_BUS_SELECTION_tedx_caa2282936b539cb3e36c2ae4845ed0b
scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:xselection_t:s0 tclass=x_selection :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213049927.227:134): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { manage } for request=X11:ChangeHosts comm=xhost
scontext=user_u:user_r:user_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tclass=x_server : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
terminal=?)'
type=USER_AVC msg=audit(1213049927.653:135): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { blend } for request=X11:CreateWindow comm=gnome-session
resid=800001 restype=WINDOW scontext=user_u:user_r:user_t:s0
tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213049927.656:136): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { blend } for request=X11:CreateWindow comm=gnome-session
resid=800002 restype=WINDOW scontext=user_u:user_r:user_t:s0
tcontext=user_u:object_r:user_t:s0 tclass=x_drawable :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1213049927.659:137): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { getattr } for request=X11:QueryPointer comm=gnome-session
xdevice="Virtual core pointer" scontext=user_u:user_r:user_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
terminal=?)'
type=USER_AVC msg=audit(1213049927.661:138): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=XKEYBOARD:SelectEvents comm=gnome-session
xdevice="Virtual core keyboard" scontext=user_u:user_r:user_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
terminal=?)'
type=USER_AVC msg=audit(1213049927.661:139): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { use } for request=XKEYBOARD:SelectEvents comm=gnome-session
xdevice="Virtual core keyboard" scontext=user_u:user_r:user_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
terminal=?)'
type=USER_AVC msg=audit(1213049927.661:140): user pid=2636 uid=0
auid=4294967295 ses=4294967295
subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
 { getattr setattr } for request=XKEYBOARD:PerClientFlags
comm=gnome-session xdevice="Virtual core keyboard"
scontext=user_u:user_r:user_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,
terminal=?)'
type=ANOM_ABEND msg=audit(1213049927.662:141): auid=500 uid=500
gid=500 ses=4 subj=user_u:user_r:user_t:s0 pid=3280
comm="gnome-session" sig=5
type=CRED_DISP msg=audit(1213049927.674:142): user pid=2720 uid=0
auid=500 ses=4 subj=system_u:system_r:xdm_t:s0-s15:c0.c1023
msg='op=PAM:setcred acct="tedx" exe="/usr/libexec/gdm-session-worker"
(hostname=?, addr=?, terminal=:0 res=success)'
type=USER_END msg=audit(1213049927.697:143): user pid=2720 uid=0
auid=500 ses=4 subj=system_u:system_r:xdm_t:s0-s15:c0.c1023
msg='op=PAM:session_close acct="tedx"
exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=:0
res=success)'

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
