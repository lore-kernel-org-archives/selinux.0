Subject: Re: security_context_to_sid failed - mounting from /etc/rc.d
From: Stephen Smalley <sds@tycho.nsa.gov>
To: M Macnair <mmacnair@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <de6d2b4f0607250253g46e392d1lfa7ba0c3aadcabd@mail.gmail.com>
References: <de6d2b4f0607250253g46e392d1lfa7ba0c3aadcabd@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 08:44:34 -0400
Message-Id: <1153831474.7104.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-25 at 10:53 +0100, M Macnair wrote:
> I discovered this whilst trying to mount removable devices on boot.
> There is the following line in /etc/rc.d/rc.local (FC5):
> mount -a -t nonfs,nfs4,smbfs,ncpfs,cifs,gfs -O
> no_netdev,context=system_u:object_r:removable_t

Add :s0 to the end of that context.  IIRC, the problem is that mount
just directly passes the context to the kernel without going through
libselinux, so it never undergoes "label translation".

> When executed, this fails with the error:
> mount: wrong fs type, bad option, bad superblock on /dev/store/music,
>        missing codepage or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> 
> /var/log/messages says:
>  kernel: SELinux:
> security_context_to_sid(system_u:object_r:removable_t) failed for (dev
> dm-3, type ext2) errno=-22
> 
> /dev/store/music is an unmounted lvm ext2 formatted logical volume,
> with fstab entry:
> /dev/store/music  /mnt/music  ext2
> defaults,user,context=system_u:object_r:removable_t
> 
> 
> This error is dependent on the context of the script that is executing
> it - cp rc.local into /etc/ (from /etc/rc.d) and execute it there, and
> it works perfectly.  Executing the mount command from a terminal also
> works.
> 
> # ls -Z /etc/rc.d/rc.local /etc/rc.local.cp
> -rwxr-xr-x  root root system_u:object_r:initrc_exec_t  /etc/rc.d/rc.local
> -rwxr-xr-x  root root user_u:object_r:etc_t            /etc/rc.local.cp
> 
> 
> Any ideas on what's going on / how to work around it?

I don't understand why that would make a difference; the error has to do
with validity of the context, not a permission denial.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
