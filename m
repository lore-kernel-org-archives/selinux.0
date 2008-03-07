Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
	when upstart runs a shell
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Joe Nall <joe@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <96B901A6-B8BE-474E-B7D0-71164D8A64BF@nall.com>
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>
	 <96B901A6-B8BE-474E-B7D0-71164D8A64BF@nall.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 08:59:51 -0500
Message-Id: <1204898391.21054.4.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-07 at 07:42 -0600, Joe Nall wrote:
> On Mar 6, 2008, at 3:11 PM, James Carter wrote:
> 
> > Upstart spawns a shell during boot and, without this patch, it will
> > transition to the sysadm_t domain, but remain in the system_r role.
> 
> Is that the cause of these mls avcs I'm seeing in /var/log/messages  
> from selinux-policy-mls-3.3.1-12.fc9?

Yes, for the first two.

> [root@rawhide ~]# grep sysadm_t /var/log/messages
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884961.873:3):  
> avc:  denied  { read write } for  pid=502 comm="sh" path="/dev/ 
> console" dev=tmpfs ino=230 scontext=system_u:system_r:sysadm_t:s0- 
> s15:c0.c1023 tcontext=system_u:object_r:tmpfs_t:s15:c0.c1023  
> tclass=chr_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884961.937:4):  
> avc:  denied  { ioctl } for  pid=502 comm="sh" path="/dev/console"  
> dev=tmpfs ino=230 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:tmpfs_t:s15:c0.c1023 tclass=chr_file

I can't say that I saw the rest of these, but I was using refpolicy, not
the fedora mls policy.

> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.239:5):  
> avc:  denied  { signal } for  pid=502 comm="rc.sysinit"  
> scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=process
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.511:6):  
> avc:  denied  { setattr } for  pid=542 comm="MAKEDEV" name="tty1-"  
> dev=tmpfs ino=1803 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.557:7):  
> avc:  denied  { create } for  pid=542 comm="MAKEDEV" name="loop0-"  
> scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023  
> tclass=blk_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.557:8):  
> avc:  denied  { setattr } for  pid=542 comm="MAKEDEV" name="loop0-"  
> dev=tmpfs ino=1822 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023  
> tclass=blk_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.557:9):  
> avc:  denied  { rename } for  pid=542 comm="MAKEDEV" name="loop0-"  
> dev=tmpfs ino=1822 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023  
> tclass=blk_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.658:10):  
> avc:  denied  { setattr } for  pid=542 comm="MAKEDEV" name="parport0-"  
> dev=tmpfs ino=1847 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:printer_device_t:s0 tclass=chr_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884963.680:11):  
> avc:  denied  { setattr } for  pid=542 comm="MAKEDEV" name="tun-"  
> dev=tmpfs ino=1862 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:tun_tap_device_t:s0 tclass=chr_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884967.023:30):  
> avc:  denied  { unlink } for  pid=785 comm="udevd" name=".tmp-8-0"  
> dev=tmpfs ino=2965 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:device_t:s0 tclass=blk_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884971.907:52):  
> avc:  denied  { write } for  pid=1395 comm="rc.sysinit" name="urandom"  
> dev=tmpfs ino=3788 scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:object_r:urandom_device_t:s0 tclass=chr_file
> Mar  7 04:16:21 rawhide kernel: type=1400 audit(1204884980.089:55):  
> avc:  denied  { listen } for  pid=2051 comm="rpcbind" lport=955  
> scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
> tcontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023 tclass=udp_socket
> 
> joe
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
