MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Clip] Unexpected role change from custom role back to user_r
Date: Thu, 28 May 2009 12:24:25 -0700
Message-ID: <FA8938DBA959E546BF6527F085F22FF804C17071@AZ25EXM04.gddsi.com>
In-Reply-To: <001201c9df27$4e1dbc60$ea593520$@com>
References: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com> <1243446033.2752.19.camel@localhost.localdomain> <000901c9deff$a7c08a90$f7419fb0$@com> <FA8938DBA959E546BF6527F085F22FF804C16C93@AZ25EXM04.gddsi.com> <1243453645.2752.33.camel@localhost.localdomain> <FA8938DBA959E546BF6527F085F22FF804C16CEC@AZ25EXM04.gddsi.com> <001201c9df27$4e1dbc60$ea593520$@com>
From: "West, Gary-P55389" <Gary.West@gdc4s.com>
To: "Brian Williams" <brian@bri3001.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <clip@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 

> -----Original Message-----
> From: Brian Williams [mailto:brian@bri3001.com] 
> Sent: Wednesday, May 27, 2009 5:00 PM
> To: West, Gary-P55389; 'Stephen Smalley'
> Cc: clip@oss1.tresys.com; selinux@tycho.nsa.gov
> Subject: RE: [Clip] Unexpected role change from custom role 
> back to user_r
> 
> > -----Original Message-----
> > From: West, Gary-P55389 [mailto:Gary.West@gdc4s.com]
> > Sent: Wednesday, May 27, 2009 4:45 PM
> > To: Stephen Smalley
> > Cc: Brian Williams; clip@oss1.tresys.com; selinux@tycho.nsa.gov
> > Subject: RE: [Clip] Unexpected role change from custom role back to 
> > user_r
> > 
> > I believe the selinux default context overrides the default context 
> > without the user.
> 
> The app_pso_u_default_contexts file should automagically 
> change to app_pso_u on the installed system, if that works 
> than any linux user that gets that SELinux user should get 
> the correct role.  If that fails I think it dumps to 
> default_contexts to try those next.  I am fairly sure it 
> doesn't just try user_r as a fallback, but it might.  So in 
> all, it checks 
> /etc/selinux/clip/contexts/users/SELinux_user_name, then 
> /etc/selinux/clip/contexts/default_contexts.  I am not 100% 
> on the order if that fails.  Honestly I find it easier to 
> just throw everything in default_contexts, I find it rare 
> that there is more than one role per SELinux user, at least 
> for logging in.
> 
> > 
> > While trying to generate logs. I have noticed that sometimes the 
> > processes come up with the correct selinux user (app_pso_u) and 
> > sometimes it comes up with user_u. It is consistant across 
> reboots but 
> > when ever I update a policy, it may or may not change.
> 
> Sounds odd, check semanage to see what users should be 
> picked. Also are the user_r logins getting user_u or 
> app_pso_u?  Also I normally use monolithic policy, if all of 
> your modules are in base why are you using modular?  Do you 
> intend on users adding modules on the fly or do you just want 
> to use semanage at runtime?
> 
Semanage shows the correct SELinux user
# semanage login -l
...
Pso	hap_pso_u	SystemLow:SystemLow-SystemHigh
...

> > 
> > The same policy rpm when loaded with the current policy 
> files removed 
> > before the install may produce different results.
> > 
> > I have several policy rpm files on the target. I am trying 
> to get some 
> > consistant results.
> > 
> 
> If you can do a build on the actual system, I'd suggest 
> trying that to rule out any rpm/time madness.  I am not 100% 
> clear what you mean by several policy RPMs. I do know that 
> sometimes you can run into the install process not 
> overwriting files that are currently on the system.  I 
> believe this is on purpose because if you want to update a 
> policy on RHEL and do a yum update, you might want it to keep 
> the current default_contexts and local_users since they might 
> be custom for the system.  It's just important to make sure 
> the files on the system are the ones that were supposed to 
> install, switching the policy name to something different 
> makes sure of that but is also a huge hassle.  Also I have 
> seen policy files not being overwritten because of timestamp 
> problems where the time on the build system was so far in the 
> past it always thought the files on the target system were 
> newer and didn't install them.
> 

I have not tried to compile the policy on the traget system. None of the
build tools are on the target.

> > Gary
> > 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Wednesday, May 27, 2009 12:47 PM
> > To: West, Gary-P55389
> > Cc: Brian Williams; clip@oss1.tresys.com; selinux@tycho.nsa.gov
> > Subject: RE: [Clip] Unexpected role change from custom role back to 
> > user_r
> > 
> > On Wed, 2009-05-27 at 12:44 -0700, West, Gary-P55389 wrote:
> > > System is mls
> > > System is currently in permissive mode Policy is modular but all 
> > > modules are in the base policy
> > >
> > > Files changed with custom role:
> > >
> > > src/config/appconfig-mls/default_type -------------------- 
> > > app_pso_r:app_pso_t
> > >
> > > src/config/appconfig-mls/default_contexts ----------------
> > > system_r:xdm_t:s0	user_r:user_t:s0 staff_r:staff_t:s0
> > > sysadm_r:sysadm_t:s0 unconfined_r:unconfined_t:s0 
> > > app_pso_r:app_pso_t:s0
> > 
> > Doesn't this cause you to still default to user_r (if the user is 
> > authorized for both user_r and app_pso_r), since user_r is listed 
> > first?
> > 
> > --
> > Stephen Smalley
> > National Security Agency
> 
> 
> 
> 

Attached is an audit log that shows a login with the correct selinux
user but when gdm-binary executes Xsession, the user/role/type switch to
user.

I added an auditallow rule
	auditallow $1 $3:process transition;
to the domain_transition_pattern macro

type=AVC msg=audit(1243536524.784:790): avc:  granted  { transition }
for  pid=5352 comm="gdm-binary" path="/usr/bin/Xorg" dev=sda3 ino=949303
scontext=system_u:system_r:xdm_t:s0-s15:c0.c255
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c255 tclass=process
type=SYSCALL msg=audit(1243536524.784:790): arch=40000003 syscall=11
success=yes exit=0 a0=9d35dc0 a1=9d35dd8 a2=9d35d28 a3=9d37508 items=0
ppid=5348 pid=5352 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="X"
exe="/usr/bin/Xorg" subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c255
key=(null)
type=UNKNOWN[1320] msg=audit(1243536524.784:790): 
type=USER_AUTH msg=audit(1243536540.162:791): user pid=5348 uid=0
auid=4294967295 subj=system_u:system_r:xdm_t:s0-s15:c0.c255 msg='PAM:
authentication acct="pso" : exe="/usr/sbin/gdm-binary" (hostname=?,
addr=?, terminal=:0 res=success)'
type=USER_ACCT msg=audit(1243536540.404:792): user pid=5348 uid=0
auid=4294967295 subj=system_u:system_r:xdm_t:s0-s15:c0.c255 msg='PAM:
accounting acct="pso" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
terminal=:0 res=success)'
type=CRED_ACQ msg=audit(1243536540.405:793): user pid=5348 uid=0
auid=4294967295 subj=system_u:system_r:xdm_t:s0-s15:c0.c255 msg='PAM:
setcred acct="pso" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
terminal=:0 res=success)'
type=LOGIN msg=audit(1243536540.406:794): login pid=5348 uid=0 old
auid=4294967295 new auid=500 old ses=4294967295 new ses=1
type=AVC msg=audit(1243536540.423:795): avc:  granted  { transition }
for  pid=5391 comm="gdm-binary" path="/sbin/pam_console_apply" dev=sda3
ino=407563 scontext=system_u:system_r:xdm_t:s0-s15:c0.c255
tcontext=system_u:system_r:pam_console_t:s0-s15:c0.c255 tclass=process
type=SYSCALL msg=audit(1243536540.423:795): arch=40000003 syscall=11
success=yes exit=0 a0=a1ee4d0 a1=a1eedc0 a2=9d35d28 a3=a1ee4fd items=0
ppid=5348 pid=5391 auid=500 uid=0 gid=30000 euid=0 suid=0 fsuid=0
egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1
comm="pam_console_app" exe="/sbin/pam_console_apply"
subj=system_u:system_r:pam_console_t:s0-s15:c0.c255 key=(null)
type=UNKNOWN[1320] msg=audit(1243536540.423:795): 
type=USER_ROLE_CHANGE msg=audit(1243536540.456:796): user pid=5348 uid=0
auid=500 subj=system_u:system_r:xdm_t:s0-s15:c0.c255 msg='pam:
default-context=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255
selected-context=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255:
exe="/usr/sbin/gdm-binary" (hostname=?, addr=?, terminal=? res=success)'
type=USER_START msg=audit(1243536540.457:797): user pid=5348 uid=0
auid=500 subj=system_u:system_r:xdm_t:s0-s15:c0.c255 msg='PAM: session
open acct="pso" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
terminal=:0 res=success)'
type=USER_LOGIN msg=audit(1243536540.457:798): user pid=5348 uid=0
auid=500 subj=system_u:system_r:xdm_t:s0-s15:c0.c255 msg='uid=500:
exe="/usr/sbin/gdm-binary" (hostname=target.gdc4s.com, addr=127.0.0.1,
terminal=:0 res=success)'
type=AVC msg=audit(1243536540.570:799): avc:  granted  { transition }
for  pid=5393 comm="gdm-binary" path="/etc/gdm/PreSession/:0" dev=sda3
ino=817206 scontext=system_u:system_r:xdm_t:s0-s15:c0.c255
tcontext=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255 tclass=process
type=SYSCALL msg=audit(1243536540.570:799): arch=40000003 syscall=11
success=yes exit=0 a0=a1f2df0 a1=a1ef8a8 a2=a1f2d48 a3=9d3bf40 items=0
ppid=5392 pid=5393 auid=500 uid=0 gid=30000 euid=0 suid=0 fsuid=0
egid=42 sgid=42 fsgid=42 tty=(none) ses=1 comm=":0" exe="/bin/bash"
subj=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255 key=(null)
type=UNKNOWN[1320] msg=audit(1243536540.570:799): 
type=AVC msg=audit(1243536540.610:800): avc:  denied  { setuid } for
pid=5393 comm=":0" capability=7
scontext=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255
tcontext=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255 tclass=capability
type=SYSCALL msg=audit(1243536540.610:800): arch=40000003 syscall=213
success=yes exit=0 a0=0 a1=28eff4 a2=0 a3=bfb46d64 items=0 ppid=5392
pid=5393 auid=500 uid=0 gid=30000 euid=0 suid=0 fsuid=0 egid=42 sgid=42
fsgid=42 tty=(none) ses=1 comm=":0" exe="/bin/bash"
subj=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255 key=(null)
type=UNKNOWN[1320] msg=audit(1243536540.610:800): 
type=AVC msg=audit(1243536540.670:801): avc:  denied  { signull } for
pid=5395 comm="gdmflexiserver"
scontext=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255
tcontext=system_u:system_r:xdm_t:s0-s15:c0.c255 tclass=process
type=SYSCALL msg=audit(1243536540.670:801): arch=40000003 syscall=37
success=yes exit=0 a0=1498 a1=0 a2=b7fbb68c a3=bfcfd2c0 items=0
ppid=5393 pid=5395 auid=500 uid=0 gid=30000 euid=0 suid=0 fsuid=0
egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1 comm="gdmflexiserver"
exe="/usr/bin/gdmflexiserver"
subj=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255 key=(null)
type=UNKNOWN[1320] msg=audit(1243536540.670:801): 
type=AVC msg=audit(1243536540.676:802): avc:  denied  { read } for
pid=5402 comm="xsetroot" name=":0.Xauth" dev=sda3 ino=1214817
scontext=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255
tcontext=system_u:object_r:xserver_log_t:s0 tclass=file
type=SYSCALL msg=audit(1243536540.676:802): arch=40000003 syscall=33
success=yes exit=0 a0=bfc19fc4 a1=4 a2=3ce9a4 a3=bfc19fc4 items=0
ppid=5393 pid=5402 auid=500 uid=0 gid=30000 euid=0 suid=0 fsuid=0
egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1 comm="xsetroot"
exe="/usr/bin/xsetroot"
subj=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255 key=(null)
type=UNKNOWN[1320] msg=audit(1243536540.676:802): 
type=AVC msg=audit(1243536540.831:803): avc:  denied  { lock } for
pid=5405 comm="lchage" path="/etc/shadow" dev=sda3 ino=813507
scontext=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255
tcontext=system_u:object_r:shadow_t:s0 tclass=file
type=SYSCALL msg=audit(1243536540.831:803): arch=40000003 syscall=221
success=yes exit=0 a0=3 a1=6 a2=86c1c54 a3=86c1c54 items=0 ppid=5404
pid=5405 auid=500 uid=0 gid=30000 euid=0 suid=0 fsuid=0 egid=30000
sgid=30000 fsgid=30000 tty=(none) ses=1 comm="lchage"
exe="/usr/sbin/lchage" subj=app_pso_u:app_pso_r:app_pso_t:s0-s15:c0.c255
key=(null)
type=UNKNOWN[1320] msg=audit(1243536540.831:803): 
type=AVC msg=audit(1243536544.070:804): avc:  granted  { transition }
for  pid=5392 comm="gdm-binary" path="/etc/X11/xinit/Xsession" dev=sda3
ino=814181 scontext=system_u:system_r:xdm_t:s0-s15:c0.c255
tcontext=user_u:user_r:user_t:s0 tclass=process
type=SYSCALL msg=audit(1243536544.070:804): arch=40000003 syscall=11
success=yes exit=0 a0=9d3b2c8 a1=bf88973c a2=a1f2c10 a3=9d3c091 items=0
ppid=5348 pid=5392 auid=500 uid=500 gid=30000 euid=500 suid=500
fsuid=500 egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1
comm="Xsession" exe="/bin/bash" subj=user_u:user_r:user_t:s0 key=(null)
type=UNKNOWN[1320] msg=audit(1243536544.070:804): 
type=AVC msg=audit(1243536544.186:805): avc:  denied  { read } for
pid=5392 comm="bash" name=".bash_profile" dev=sda3 ino=1284106
scontext=user_u:user_r:user_t:s0
tcontext=app_pso_u:object_r:app_pso_home_t:s0 tclass=file
type=SYSCALL msg=audit(1243536544.186:805): arch=40000003 syscall=5
success=yes exit=3 a0=86739c0 a1=8000 a2=0 a3=8000 items=0 ppid=5348
pid=5392 auid=500 uid=500 gid=30000 euid=500 suid=500 fsuid=500
egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1 comm="bash"
exe="/bin/bash" subj=user_u:user_r:user_t:s0 key=(null)
type=UNKNOWN[1320] msg=audit(1243536544.186:805): 
type=AVC msg=audit(1243536544.258:806): avc:  denied  { write } for
pid=5392 comm="Xclients" name=".xsess-log" dev=sda3 ino=1284111
scontext=user_u:user_r:user_t:s0
tcontext=app_pso_u:object_r:app_pso_home_t:s0 tclass=file
type=SYSCALL msg=audit(1243536544.258:806): arch=40000003 syscall=5
success=yes exit=3 a0=8c7c818 a1=8241 a2=1b6 a3=8241 items=0 ppid=5348
pid=5392 auid=500 uid=500 gid=30000 euid=500 suid=500 fsuid=500
egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1 comm="Xclients"
exe="/bin/bash" subj=user_u:user_r:user_t:s0 key=(null)
type=UNKNOWN[1320] msg=audit(1243536544.258:806): 
type=AVC msg=audit(1243536544.456:807): avc:  denied  { write } for
pid=5392 comm="fvwm2" name=".fvwm" dev=sda3 ino=1284100
scontext=user_u:user_r:user_t:s0
tcontext=app_pso_u:object_r:app_pso_home_t:s0 tclass=dir
type=SYSCALL msg=audit(1243536544.456:807): arch=40000003 syscall=33
success=yes exit=0 a0=9023bb8 a1=2 a2=9023bd0 a3=bfbe9b04 items=0
ppid=5348 pid=5392 auid=500 uid=500 gid=30000 euid=500 suid=500
fsuid=500 egid=30000 sgid=30000 fsgid=30000 tty=(none) ses=1
comm="fvwm2" exe="/usr/bin/fvwm" subj=user_u:user_r:user_t:s0 key=(null)
type=UNKNOWN[1320] msg=audit(1243536544.456:807): 


Gary


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
