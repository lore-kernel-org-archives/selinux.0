Subject: RE: Bootup problem with refpolicy-2.20091117 - rules found but
 still can't login
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: justinmattock@gmail.com, selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy@oss1.tresys.com,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>
	 ,,<4B53CEB9.3050207@gmail.com> <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>
	 ,,<4B543977.40007@gmail.com> <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>
	 ,,<4B550EB9.50806@gmail.com> <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
	 ,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>
	 <BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>
Content-Type: text/plain
Date: Fri, 22 Jan 2010 11:14:07 -0500
Message-Id: <1264176847.22211.16.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-22 at 10:13 +0000, TaurusHarry wrote:
> Exactly! Aside from missing necessary TE rules another possible reason
> program can't run normally is that the file accessed has not been
> properly labeled. My above findings that many types have no "search"
> privilege against the tmpfs_t is a good example of this: none
> of /dev/* should  be labeled as tmpfs_t. From my below findings we can
> see that tmpfs have been mounted to both /dev and /dev/shm, and after
> booting with enforcing=0,  /dev/stderr and etc are labeled as tmpfs_t,
> but after I manually do restorecon -R /dev, they will all reclaim
> their correct labels:
> 
> root@cp3020:/root> cat /proc/cmdline 
> root=/dev/sda1 rw console=ttyS0,115200n8 ip=dhcp selinux=1 enforcing=0
> BOOT_IMAGE=/vlm-boards/12885/qcao/kernel 
> root@cp3020:/root> cat /proc/mounts
> rootfs / rootfs rw 0 0
> /dev/root / ext2 rw,errors=continue 0 0
> none /selinux selinuxfs rw 0 0
> /proc /proc proc rw 0 0
> /sys /sys sysfs rw 0 0
> none /dev tmpfs rw,mode=755 0 0
> devpts ! /dev/pts devpts rw,mode=600 0 0
> tmpfs /dev/shm tmpfs rw 0 0
> none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0
> root@cp3020:/root> ls -Z /dev/ | grep tmpfs_t
> lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     MAKEDEV
> drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     bsg
> lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     core
> drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     cpu
> drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     disk
> lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     fd
> crw-------  root root system_u:object_r:tmpfs_t:s0     ipmi0
> srw-rw-rw-  root root system_u:object_r:tmpfs_t:s15:c0.c255 log
> drwxrwxrwt  root root system_u:object_r:tmpfs_t:s0     shm
> lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     stderr
> lrwxrwxrwx  root ro! ot system_u:object_r:tmpfs_t:s0     stdin
> lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     stdout
> root@cp3020:/root> /sbin/restorecon -R /dev
> root@cp3020:/root> ls -Z /dev | grep tmpfs_t
> root@cp3020:/root> ls -Z /dev | grep -v device_t
> prw-------  root root system_u:object_r:initctl_t:s0   initctl
> srw-rw-rw-  root root system_u:object_r:devlog_t:s0    log
> crw-rw-rw-  root tty  system_u:object_r:ptmx_t:s0      ptmx
> drwxr-xr-x  root root system_u:object_r:devpts_t:s0-s15:c0.c255 pts
> crw-rw-rw-  root tty  system_u:object_r:devtty_t:s0    tty
> root@cp3020:/root>
> 
> However, after reboot the console still hangs. I think many files
> under /dev/ are created by udev on-the-fly so we have to label them
> after creation. Then I modified rc.sysinit to move "/sbin/restorecon
> -R /dev" out of the c! ontrol of the if statement and thus always be
> conducted, but the probl em is still there. I even went on to
> touch /.autorelabel and changed "/sbin/fixfiles restore > /dev/null
> 2>&1" to "/sbin/restorecon -R /" in the relabel_selinux() function(so
> that the whole filesystem is relabeled once again during bootup), but
> the problem still persists.
> 
> Any further comments?

The restorecon -R /dev has to be done on every boot since tmpfs is
ephemeral.

There are certain allow rules that are only included if DISTRO=redhat
related to relabeling of the tmpfs /dev I believe, as some other distros
took a different approach (mounting with rootcontext=?)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
