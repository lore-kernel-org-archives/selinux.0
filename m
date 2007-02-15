Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Eric Paris <eparis@parisplace.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
In-Reply-To: <1171572980.18488.30.camel@localhost.localdomain>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
	 <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1171571029.4569.18.camel@desk.netwosix.org>
	 <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1171572168.5239.0.camel@desk.netwosix.org>
	 <1171572980.18488.30.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 22:47:39 +0100
Message-Id: <1171576059.5239.13.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno gio, 15/02/2007 alle 15.56 -0500, Eric Paris ha scritto:

> Maybe someone else can chime in with the best way to try this again
> since it doesn't look to me like the make relabel really got everything
> you needed (and I have no idea if you rc.sysinit is patched to pay
> attention to /.autorelabel)

Ok, fixed!
In the attach the SELINUX portion of my /etc/rc. I think it's ok but
actually it's just working.

Here the result:
# ls -Z
-rw-r--r--  root root system_u:object_r:default_t      System.map
drwxr-xr-x  root root system_u:object_r:bin_t          bin
drwxr-xr-x  root root system_u:object_r:boot_t         boot
drwxr-xr-x  root root system_u:object_r:default_t      cdrom
drwxr-xr-x  root root system_u:object_r:device_t       dev
drwxr-xr-x  root root system_u:object_r:etc_t          etc
drwxr-xr-x  root root system_u:object_r:home_root_t    home
drwxr-xr-x  root root system_u:object_r:default_t      include
drwxr-xr-x  root root system_u:object_r:default_t      info
drwxr-xr-x  root root system_u:object_r:lib_t          lib
drwxr-xr-x  root root system_u:object_r:default_t      libexec
drwx------  root root system_u:object_r:lost_found_t   lost+found
drwxr-xr-x  root root system_u:object_r:default_t      man
drwxr-xr-x  root root system_u:object_r:mnt_t          mnt
drwxr-xr-x  root root system_u:object_r:usr_t          opt
dr-xr-xr-x  root root system_u:object_r:proc_t         proc
drwxr-x---  root root root:object_r:user_home_dir_t    root
drwxr-xr-x  root root system_u:object_r:sbin_t         sbin
drwxr-xr-x  root root system_u:object_r:security_t     selinux
drwxr-xr-x  root root system_u:object_r:default_t      share
drwxr-xr-x  root root system_u:object_r:sysfs_t        sys
drwxrwxrwt  root root system_u:object_r:tmp_t          tmp
drwxr-xr-x  root root system_u:object_r:usr_t          usr
drwxr-xr-x  root root system_u:object_r:var_t          var
-rw-r--r--  root root system_u:object_r:default_t      vmlinuz

However i rebuilt the refpolicy with "strict" options and now i get
this:

# newrole -r sysadm_r
Authenticating root.
newrole: incorrect password for root
#

I'm working no stop from almost 9 hours, so i'm in crash and
unfortunately i have to stop.

Tomorrow i'll restart working on and maybe i'll fix this. 

Of course if you want to save my time any help would be appreciated.

Thank you.

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
