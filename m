Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1GI4Zfk008494
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 13:04:35 -0500
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1GI4KvF015123
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 18:04:20 GMT
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o1GI6EQt017106
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 12:06:19 -0600
From: Alan Rouse <alan.rouse@ericsson.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Tue, 16 Feb 2010 13:04:29 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
 <4B7AB835.5080008@gmail.com>
In-Reply-To: <4B7AB835.5080008@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick, thanks for the reply.   These AVC messages occur during normal bootup (not from a command line), so it is the boot process which is starting these in the wrong context.  

OpenSuSE 11.2 is still using System V init startup, but Fedora 12 is using upstart.  Perhaps that explains why the recent refpolicy is not starting OpenSuse processes in the right context.  Is the current refpolicy known to work in System V init -based systems?

-----Original Message-----
From: Dominick Grift [mailto:domg472@gmail.com] 
Sent: Tuesday, February 16, 2010 10:22 AM
To: Alan Rouse
Cc: 'selinux@tycho.nsa.gov'
Subject: Re: SELinux Policy in OpenSUSE 11.2

On 02/16/2010 03:55 PM, Alan Rouse wrote:
le
> type=AVC msg=audit(1265904613.689:203): avc:  denied  { execstack } 
> for  pid=2382 comm="cupsd" scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:system_r:sysadm_t tclass=process type=AVC 
> msg=audit(1265904613.690:204): avc:  denied  { execmem } for  pid=2382 
> comm="cupsd" scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:system_r:sysadm_t tclass=process type=AVC 
> msg=audit(1265904614.260:205): avc:  denied  { read write } for  
> pid=2448 comm="smartd" name="sda" dev=tmpfs ino=1749 
> scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file 
> type=AVC msg=audit(1265904614.260:206): avc:  denied  { open } for  
> pid=2448 comm="smartd" name="sda" dev=tmpfs ino=1749 
> scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file 
> type=AVC msg=audit(1265904614.261:207): avc:  denied  { ioctl } for  
> pid=2448 comm="smartd" path="/dev/sda" dev=tmpfs ino=1749 
> scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file 
> type=AVC msg=audit(1265904615.964:209): avc:  denied  { read } for  
> pid=2337 comm="auditd" scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:system_r:sysadm_t tclass=netlink_audit_socket 
> type=AVC msg=audit(1265904616.063:212): avc:  denied  { read } for  
> pid=308 comm="udevd" scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:system_r:sysadm_t 
> tclass=netlink_kobject_uevent_socket
> type=AVC msg=audit(1265904616.063:213): avc:  denied  { write } for  
> pid=308 comm="udevd" scontext=system_u:system_r:sysadm_t 
> tcontext=system_u:system_r:sysadm_t 
> tclass=netlink_kobject_uevent_socket

With regard to the AVC denials above it seems that these services (cupsd, smartd, auditd and udevd) run in the wrong domain. When you restart services manually, you should use "run_init".

run_init /etc/rc.d/init.d/cupsd start

Besides that some if this might still not work. For example execstack and execmem permissions for cupsd, but start by executing these daemons in the proper domains first.

As for dbus i have not noticed any dbus specific AVC denials. It may be the dbus denials are directed to /var/log/messages, /var/log/audit/audit.log or dmesg.

> 
> 
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
