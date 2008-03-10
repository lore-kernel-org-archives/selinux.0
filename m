Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2AJalJK001859
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 15:36:47 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2AJak0u025461
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 19:36:46 GMT
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Message-Id: <46514C07-63FC-4CD1-8507-D0799BAE9BF5@nall.com>
From: Joe Nall <joe@nall.com>
To: Xavier Toth <txtoth@gmail.com>
In-Reply-To: <cadfc0e40803091236i5ddca650hd81d470109295541@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: x fails to start on fc9
Date: Mon, 10 Mar 2008 14:36:07 -0500
References: <cadfc0e40803091236i5ddca650hd81d470109295541@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 9, 2008, at 2:36 PM, Xavier Toth wrote:

> selinux-policy 3.3.1-11
> xorg-x11-server-Xorg-1.4.99.900-0.28.20080304
>
> Error message something like:
> file_contexts line 0 invalid context  
> system_u:object_r:info_xproperty_t:s0
> SELinux: Failed to set label property on window!
>
> I'm using MLS policy in permissive mode.

Using selinux-policy 3.3.1-13 (or what I think it will be) and xorg- 
x11-server-Xorg-1.4.99.901-1.20080307.fc9.i386 on a rawhide box build  
today  and

setsebool xdm_sysadm_login on
setsebool xserver_object_manager on
setsebool allow_xserver_execmem on
setsebool allow_read_x_device on

I can login to a Fedora 9 system in mls/Permissive as a normal user.   
An attempt to login as 'Other' fails before the username prompt.

A 'restorecon -rv /' does have an X related relabel.

restorecon reset /tmp/.X11-unix context system_u:object_r:tmp_t:s0- 
 >system_u:object_r:xdm_tmp_t:s0

The following avcs were in dmesg
type=1400 audit(1205177196.981:5): avc:  denied  { read } for   
pid=1299 comm="Xorg" name="mem" dev=tmpfs ino=3742  
scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:memory_device_t:s15:c0.c1023 tclass=chr_file
type=1400 audit(1205177197.000:6): avc:  denied  { getpgid } for   
pid=1299 comm="Xorg" scontext=system_u:system_r:xdm_xserver_t:s0- 
s15:c0.c1023 tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023  
tclass=process
type=1400 audit(1205177197.295:7): avc:  denied  { write } for   
pid=1299 comm="Xorg" name="mem" dev=tmpfs ino=3742  
scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:memory_device_t:s15:c0.c1023 tclass=chr_file
type=1400 audit(1205177197.546:8): avc:  denied  { read } for   
pid=1299 comm="Xorg" name="perms" dev=selinuxfs ino=67111368  
scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:security_t:s0 tclass=dir
type=1400 audit(1205177197.568:9): avc:  denied  { write } for   
pid=1299 comm="Xorg" name="create" dev=selinuxfs ino=7  
scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:security_t:s0 tclass=file
type=1400 audit(1205177197.568:10): avc:  denied  { compute_create }  
for  pid=1299 comm="Xorg" scontext=system_u:system_r:xdm_xserver_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:security_t:s15:c0.c1023  
tclass=security
type=1400 audit(1205177197.680:11): avc:  denied  { check_context }  
for  pid=1299 comm="Xorg" scontext=system_u:system_r:xdm_xserver_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:security_t:s15:c0.c1023  
tclass=security
type=1400 audit(1205177198.574:12): avc:  denied  { signal } for   
pid=1299 comm="Xorg" scontext=system_u:system_r:xdm_xserver_t:s0- 
s15:c0.c1023 tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023  
tclass=process

audit2allow says

#============= initrc_t ==============
allow initrc_t mnt_t:dir mounton;
allow initrc_t ramfs_t:dir setattr;

#============= xdm_xserver_t ==============
allow xdm_xserver_t initrc_t:process { signal getpgid };
allow xdm_xserver_t memory_device_t:chr_file { read write };
allow xdm_xserver_t security_t:dir read;
allow xdm_xserver_t security_t:file write;
allow xdm_xserver_t security_t:security { check_context  
compute_create };

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
