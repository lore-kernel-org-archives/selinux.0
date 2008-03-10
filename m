Message-ID: <47D596C0.8040201@redhat.com>
Date: Mon, 10 Mar 2008 16:14:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Xavier Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: x fails to start on fc9
References: <cadfc0e40803091236i5ddca650hd81d470109295541@mail.gmail.com> <46514C07-63FC-4CD1-8507-D0799BAE9BF5@nall.com>
In-Reply-To: <46514C07-63FC-4CD1-8507-D0799BAE9BF5@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joe Nall wrote:
> 
> On Mar 9, 2008, at 2:36 PM, Xavier Toth wrote:
> 
>> selinux-policy 3.3.1-11
>> xorg-x11-server-Xorg-1.4.99.900-0.28.20080304
>>
>> Error message something like:
>> file_contexts line 0 invalid context
>> system_u:object_r:info_xproperty_t:s0
>> SELinux: Failed to set label property on window!
>>
>> I'm using MLS policy in permissive mode.
> 
> Using selinux-policy 3.3.1-13 (or what I think it will be) and
> xorg-x11-server-Xorg-1.4.99.901-1.20080307.fc9.i386 on a rawhide box
> build today  and
> 
> setsebool xdm_sysadm_login on
> setsebool xserver_object_manager on
> setsebool allow_xserver_execmem on
> setsebool allow_read_x_device on
> 
> I can login to a Fedora 9 system in mls/Permissive as a normal user.  An
> attempt to login as 'Other' fails before the username prompt.
> 
> A 'restorecon -rv /' does have an X related relabel.
> 
> restorecon reset /tmp/.X11-unix context
> system_u:object_r:tmp_t:s0->system_u:object_r:xdm_tmp_t:s0
> 
> The following avcs were in dmesg
> type=1400 audit(1205177196.981:5): avc:  denied  { read } for  pid=1299
> comm="Xorg" name="mem" dev=tmpfs ino=3742
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023 tclass=chr_file
This is MLS Violation
> type=1400 audit(1205177197.000:6): avc:  denied  { getpgid } for 
> pid=1299 comm="Xorg"
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=process
What is running as initrc_t?
> type=1400 audit(1205177197.295:7): avc:  denied  { write } for  pid=1299
> comm="Xorg" name="mem" dev=tmpfs ino=3742
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023 tclass=chr_file
> type=1400 audit(1205177197.546:8): avc:  denied  { read } for  pid=1299
> comm="Xorg" name="perms" dev=selinuxfs ino=67111368
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:security_t:s0 tclass=dir
> type=1400 audit(1205177197.568:9): avc:  denied  { write } for  pid=1299
> comm="Xorg" name="create" dev=selinuxfs ino=7
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:security_t:s0 tclass=file
> type=1400 audit(1205177197.568:10): avc:  denied  { compute_create }
> for  pid=1299 comm="Xorg"
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:security_t:s15:c0.c1023 tclass=security
> type=1400 audit(1205177197.680:11): avc:  denied  { check_context } for 
> pid=1299 comm="Xorg"
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:security_t:s15:c0.c1023 tclass=security
> type=1400 audit(1205177198.574:12): avc:  denied  { signal } for 
> pid=1299 comm="Xorg"
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=process
> 
> audit2allow says
> 
> #============= initrc_t ==============
> allow initrc_t mnt_t:dir mounton;
> allow initrc_t ramfs_t:dir setattr;
What app is running as initrc_t?
> 
> #============= xdm_xserver_t ==============
> allow xdm_xserver_t initrc_t:process { signal getpgid };
> allow xdm_xserver_t memory_device_t:chr_file { read write };

> allow xdm_xserver_t security_t:dir read;
> allow xdm_xserver_t security_t:file write;
> allow xdm_xserver_t security_t:security { check_context compute_create };
These should be allowed via the xserver_object_manager boolean so these
might also be MLS Violations.  xdm_xserver_t probably needs lots of mls
attributes.
> 
> joe
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfVlr8ACgkQrlYvE4MpobP6sQCgm1IBY1+bJLUI5P0uNHMtZXzS
1jAAoNutL6KDOryjCtnEhNkRtf5KKbUk
=OMAi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
