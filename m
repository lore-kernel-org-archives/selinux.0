Message-ID: <1491404048.15479.13.camel@tycho.nsa.gov>
Subject: Re: security_bounded_transition
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cgzones <cgzones@googlemail.com>, selinux <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Date: Wed, 05 Apr 2017 10:54:08 -0400
In-Reply-To: <CAJ2a_DeZ+7yTWgipgvbXeymZwYyz0RrwanRWSszQtjCVgnWW6w@mail.gmail.com>
References: <CAJ2a_DeZ+7yTWgipgvbXeymZwYyz0RrwanRWSszQtjCVgnWW6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-05 at 14:58 +0200, cgzones wrote:
> Hi list,
> 
> when running `apt update` i'm getting a bunch of the following
> security_bounded_transition audits:
> 
> type=PROCTITLE msg=audit(05/04/17 14:47:20.268:219) :
> proctitle=/usr/bin/dpkg --print-foreign-architectures
> type=PATH msg=audit(05/04/17 14:47:20.268:219) : item=1
> name=/lib64/ld-linux-x86-64.so.2 inode=132140 dev=08:01 mode=file,755
> ouid=root ogid=root rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL
> type=PATH msg=audit(05/04/17 14:47:20.268:219) : item=0
> name=/usr/bin/dpkg inode=131862 dev=08:01 mode=file,755 ouid=root
> ogid=root rdev=00:00 obj=system_u:object_r:dpkg_exec_t:s0
> nametype=NORMAL
> type=CWD msg=audit(05/04/17 14:47:20.268:219) :
> cwd=/root/selinux/policy
> type=EXECVE msg=audit(05/04/17 14:47:20.268:219) : argc=2
> a0=/usr/bin/dpkg a1=--print-foreign-architectures
> type=SYSCALL msg=audit(05/04/17 14:47:20.268:219) : arch=x86_64
> syscall=execve success=yes exit=0 a0=0x56455b39a820 a1=0x56455b39e6d0
> a2=0x7ffdfaf43cd0 a3=0x2 items=2 ppid=2328 pid=2329 auid=debianuser
> uid=_apt gid=nogroup euid=_apt suid
> =_apt fsuid=_apt egid=nogroup sgid=nogroup fsgid=nogroup tty=pts0
> ses=1 comm=dpkg exe=/usr/bin/dpkg
> subj=staff_u:sysadm_r:apt_t:s0-s0:c0.c1023 key=(null)
> type=SELINUX_ERR msg=audit(05/04/17 14:47:20.268:219) :
> op=security_bounded_transition seresult=denied
> oldcontext=staff_u:sysadm_r:apt_t:s0-s0:c0.c1023
> newcontext=staff_u:sysadm_r:dpkg_t:s0-s0:c0.c1023
> 
> I do not use any type-/role-bounds rules, and apt and dpkg are
> working
> without (noticeable) issues.

This means that the process or one of its ancestors had set
NO_NEW_PRIVS, and then tried to execve a program that normally would
have triggered a domain transition.  Domain transitions are only
allowed under NO_NEW_PRIVS if the new domain is bounded by the calling
domain, since this ensures that no privilege escalation is possible
(originally we did not allow domain transitions at all under
NO_NEW_PRIVS; this was relaxed to allow them if bounded to support the
SELinux sandbox when it began using NO_NEW_PRIVS).  Unless the program
explicitly requested the domain transition (via setexeccon), this is
treated as a non-fatal error and the process just stays in the calling
domain.

Hence, at present, apt will continue running in apt_t rather than
transitioning into dpkg_t when running dpkg (at least in cases where
apt has set NO_NEW_PRIVS prior to execve - I do not know whether it
does this universally when running dpkg or only in specific instances).
This could be a problem for labeling of any files created by dpkg if
relying on type transitions or it could prevent dpkg from performing
operations only allowed to dpkg_t (or it could expose dpkg to
performing operations only allowed to apt_t).

Adding typebounds rules (ala typebounds apt_t dpkg_t; typebounds
apt_exec_t dpkg_exec_t; typebounds apt_tmp_t dpkg_tmp_t; ...) would
allow the transition to occur, but would then require dpkg_t to be a
strict subset of permissions allowed to apt_t.  This does not appear to
be the case in current policy, so it would likely break other uses of
dpkg.

This is an issue for the Debian SELinux maintainers to resolve.
