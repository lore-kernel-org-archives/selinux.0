Message-ID: <47D1867A.9000207@redhat.com>
Date: Fri, 07 Mar 2008 13:16:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: jwcart2@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
 when upstart runs a shell
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil> <96B901A6-B8BE-474E-B7D0-71164D8A64BF@nall.com> <47D148AF.1090606@redhat.com> <D0A88599-46C2-4E2B-9207-2B95462B5FC3@nall.com> <972010AD-1752-466D-BF5F-B4B941C211C5@nall.com>
In-Reply-To: <972010AD-1752-466D-BF5F-B4B941C211C5@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joe Nall wrote:
> 
> On Mar 7, 2008, at 9:49 AM, Joe Nall wrote:
> 
>>
>> On Mar 7, 2008, at 7:52 AM, Daniel J Walsh wrote:
>>
>>>>
>>> Looks like it.  I think leaving making it initrc_t would fix most of
>>> your avc messages.
>>
>> It certainly changed them. Here is the of the changing init_t to initrc_t
> 
> and the result of deleting the transition entirely (Jame's patch)
> 
> #============= init_t ==============
> allow init_t self:unix_dgram_socket sendto;
> allow init_t shell_exec_t:file { read execute execute_no_trans };
> 
> #============= initrc_t ==============
> allow initrc_t etc_t:file write;
> allow initrc_t lvm_control_t:chr_file write;
> allow initrc_t var_run_t:sock_file create;
> 
> #============= insmod_t ==============
> allow insmod_t kernel_t:process setsched;
This looks like an MLS constraint, since the allow rule is in policy
> 
> #============= setrans_t ==============
> allow setrans_t initrc_t:fd use;
> 
> 
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926624.921:3): avc: 
> denied  { execute } for  pid=502 comm="init" name="bash" dev=sda2
> ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926624.921:4): avc: 
> denied  { read } for  pid=502 comm="init" name="bash" dev=sda2
> ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926624.922:5): avc: 
> denied  { execute_no_trans } for  pid=502 comm="init" path="/bin/bash"
> dev=sda2 ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926628.114:6): avc: 
> denied  { setsched } for  pid=612 comm="modprobe"
> scontext=system_u:system_r:insmod_t:s0-s15:c0.c1023
> tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=process
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926633.712:7): avc: 
> denied  { write } for  pid=1310 comm="multipath.stati" name="control"
> dev=tmpfs ino=5407 scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:lvm_control_t:s0 tclass=chr_file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926635.761:8): avc: 
> denied  { execute } for  pid=1448 comm="init" name="bash" dev=sda2
> ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926635.761:9): avc: 
> denied  { read } for  pid=1448 comm="init" name="bash" dev=sda2
> ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926635.761:10):
> avc:  denied  { execute_no_trans } for  pid=1448 comm="init"
> path="/bin/bash" dev=sda2 ino=24084497
> scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926635.837:11):
> avc:  denied  { sendto } for  pid=1448 comm="telinit"
> path=002F636F6D2F7562756E74752F75707374617274
> scontext=system_u:system_r:init_t:s0-s15:c0.c1023
> tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=unix_dgram_socket
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926636.048:12):
> avc:  denied  { setsched } for  pid=1477 comm="modprobe"
> scontext=system_u:system_r:insmod_t:s0-s15:c0.c1023
> tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=process
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926638.005:13):
> avc:  denied  { write } for  pid=1732 comm="ifup-eth"
> name="dhclient-eth0.conf" dev=sda2 ino=20055551
> scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:etc_t:s0 tclass=file
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926644.913:15):
> avc:  denied  { use } for  pid=2031 comm="mcstransd"
> path="/lib/ld-2.7.90.so" dev=sda2 ino=12125240
> scontext=system_u:system_r:setrans_t:s15:c0.c1023
> tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=fd
> Mar  7 15:50:46 rawhide kernel: type=1400 audit(1204926645.074:16):
> avc:  denied  { create } for  pid=2041 comm="rpcbind"
> name="rpcbind.sock" scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:var_run_t:s0 tclass=sock_file
> 
> joe
> 

Looks like some transitions are not happening.  rpcbind should have
transitioned is it labeled correctly?  ifup-eth/dhclient should have
transitioned also.

init execing shell might need to transition to initrc_t?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfRhnUACgkQrlYvE4MpobMxKACgw3jaZ/8HBNFcVC0rPrDuObB5
7zMAn2ja2138cDpcreJ4ZcSv6OWCKxtb
=1p5I
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
