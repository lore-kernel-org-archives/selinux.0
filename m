Subject: Re: [ PATCH ] hal - create netlink socket
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 11:08:49 -0500
Message-Id: <1112026129.3040.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 08:27 -0500, Stephen Smalley wrote:
> On Sun, 2005-03-27 at 01:32 -0500, Ivan Gyurdiev wrote:
> > Makes hal work again on my system....sort of
> > 
> > /usr/libexec/hald-probe-input denied { read } on mouse_device_t:chr_file
> > /usr/libexec/hald-addon-acpi denied { write } on acpid.socket
> > (apmd_var_run_t)
> > /usr/libexec/hald-add-selinux-mount-option denied { search } on /selinux
> > (security_t)
> > /usr/sbin/hald denied { getattr } on /dev/mapper/control (lvm_control_t)
> > /usr/sbin/dmidecode denied { read } on /dev/mem (memory_device_t)
> 
> Class 'netlink_socket' is the catch-all for netlink protocols that have
> no individual security class.  Can you remove this permission from your
> policy and enable syscall auditing via auditctl (or boot with audit=1)
> and try again so we can see the actual netlink protocol value that was
> used?

Interesting, I hadn't actually used auditd until now. Is the daemon
supposed to be on or off by default?

type=DAEMON msg=auditd(1112025664) auditd start, ver=0.6.9, format=raw,
pid=2130, uid=0
type=KERNEL msg=audit(1112025664.871:799895): syscall=102 exit=48 a0=b
a1=bfeb0150 a2=8050248 a3=0 items=0 pid=2130 loginuid=-1 uid=0 gid=0
euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
type=KERNEL msg=audit(1112025664.871:799895): audit_enabled=1 old=1
type=KERNEL msg=audit(1112025664.667:799550): syscall=102 exit=48 a0=b
a1=bfeafc60 a2=8050248 a3=0 items=0 pid=2130 loginuid=-1 uid=0 gid=0
euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
type=KERNEL msg=audit(1112025683.444:848288): syscall=125 exit=-13
a0=bfb76000 a1=1000 a2=1000007 a3=f8c000 items=0 pid=2355 loginuid=-1
uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
type=KERNEL msg=audit(1112025683.444:848288): avc:  denied  { execmem }
for  pid=2355 comm=httpd scontext=system_u:system_r:httpd_t
tcontext=system_u:system_r:httpd_t tclass=process
type=KERNEL msg=audit(1112025688.522:863505): syscall=102 exit=-13 a0=1
a1=bfa3acf0 a2=80712ac a3=8075a60 items=0 pid=2512 loginuid=-1 uid=0
gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
type=KERNEL msg=audit(1112025688.522:863505): avc:  denied  { create }
for  pid=2512 exe=/usr/sbin/hald scontext=system_u:system_r:hald_t
tcontext=system_u:system_r:hald_t tclass=netlink_socket


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
