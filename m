MIME-Version: 1.0
In-Reply-To: <20170405145739.GA18110@t450.enp8s0.d30>
References: <CAJ2a_DeZ+7yTWgipgvbXeymZwYyz0RrwanRWSszQtjCVgnWW6w@mail.gmail.com>
 <1491404048.15479.13.camel@tycho.nsa.gov>
 <20170405145739.GA18110@t450.enp8s0.d30>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sat, 4 Nov 2017 11:36:55 +0100
Message-ID: <CAJ2a_DcV4E7j0q51xBn5ryC=SV_QNf3E_SvQs9oLeENYFdA54w@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: security_bounded_transition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Now that nnp transitions are available in kernel v4.14, can the
selinux_err message be skipped? (maybe conditional if the policy
capability for nnp transitions is enabled)

Cause now I am getting these logs:

time->Sat Nov  4 11:30:21 2017
type=PROCTITLE msg=audit(1509791421.220:2221):
proctitle=2F7573722F62696E2F64706B67002D2D7072696E742D666F726569676E2D61726368697465637475726573
type=PATH msg=audit(1509791421.220:2221): item=1
name="/lib64/ld-linux-x86-64.so.2" inode=131141 dev=08:01 mode=0100755
ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
nametype=NORMAL cap_fp=0000000000000000 cap_fi=000000000000
0000 cap_fe=0 cap_fver=0
type=PATH msg=audit(1509791421.220:2221): item=0 name="/usr/bin/dpkg"
inode=394494 dev=08:01 mode=0100755 ouid=0 ogid=0 rdev=00:00
obj=system_u:object_r:dpkg_exec_t:s0 nametype=NORMAL
cap_fp=0000000000000000 cap_fi=0000000000000000 cap_f
e=0 cap_fver=0
type=CWD msg=audit(1509791421.220:2221): cwd="/root/workspace/selinux/policy"
type=EXECVE msg=audit(1509791421.220:2221): argc=2 a0="/usr/bin/dpkg"
a1="--print-foreign-architectures"
type=SYSCALL msg=audit(1509791421.220:2221): arch=c000003e syscall=59
success=yes exit=0 a0=564d70b9cea0 a1=564d70b977f0 a2=7fffa1d32450
a3=2 items=2 ppid=20592 pid=20593 auid=0 uid=109 gid=65534 euid=109
suid=109 fsuid=109 egid=65534 sg
id=65534 fsgid=65534 tty=pts1 ses=1 comm="dpkg" exe="/usr/bin/dpkg"
subj=root:sysadm_r:apt_t:s0-s0:c0.c1023 key=(null)
type=SELINUX_ERR msg=audit(1509791421.220:2221):
op=security_bounded_transition seresult=denied
oldcontext=root:sysadm_r:apt_t:s0-s0:c0.c1023
newcontext=root:sysadm_r:dpkg_t:s0-s0:c0.c1023
type=AVC msg=audit(1509791421.220:2221): avc:  denied  {
nnp_transition } for  pid=20593 comm="apt-config"
scontext=root:sysadm_r:apt_t:s0-s0:c0.c1023
tcontext=root:sysadm_r:dpkg_t:s0-s0:c0.c1023 tclass=process2
permissive=0

I like to dontaudit the transition (and let apt stay in the apt_t
domain for these operations) but the selinux_err message will keep
showing up.


2017-04-05 16:57 GMT+02:00 Dominick Grift <dac.override@gmail.com>:
> On Wed, Apr 05, 2017 at 10:54:08AM -0400, Stephen Smalley wrote:
>> On Wed, 2017-04-05 at 14:58 +0200, cgzones wrote:
>> > Hi list,
>> >
>> > when running `apt update` i'm getting a bunch of the following
>> > security_bounded_transition audits:
>> >
>> > type=PROCTITLE msg=audit(05/04/17 14:47:20.268:219) :
>> > proctitle=/usr/bin/dpkg --print-foreign-architectures
>> > type=PATH msg=audit(05/04/17 14:47:20.268:219) : item=1
>> > name=/lib64/ld-linux-x86-64.so.2 inode=132140 dev=08:01 mode=file,755
>> > ouid=root ogid=root rdev=00:00 obj=system_u:object_r:ld_so_t:s0
>> > nametype=NORMAL
>> > type=PATH msg=audit(05/04/17 14:47:20.268:219) : item=0
>> > name=/usr/bin/dpkg inode=131862 dev=08:01 mode=file,755 ouid=root
>> > ogid=root rdev=00:00 obj=system_u:object_r:dpkg_exec_t:s0
>> > nametype=NORMAL
>> > type=CWD msg=audit(05/04/17 14:47:20.268:219) :
>> > cwd=/root/selinux/policy
>> > type=EXECVE msg=audit(05/04/17 14:47:20.268:219) : argc=2
>> > a0=/usr/bin/dpkg a1=--print-foreign-architectures
>> > type=SYSCALL msg=audit(05/04/17 14:47:20.268:219) : arch=x86_64
>> > syscall=execve success=yes exit=0 a0=0x56455b39a820 a1=0x56455b39e6d0
>> > a2=0x7ffdfaf43cd0 a3=0x2 items=2 ppid=2328 pid=2329 auid=debianuser
>> > uid=_apt gid=nogroup euid=_apt suid
>> > =_apt fsuid=_apt egid=nogroup sgid=nogroup fsgid=nogroup tty=pts0
>> > ses=1 comm=dpkg exe=/usr/bin/dpkg
>> > subj=staff_u:sysadm_r:apt_t:s0-s0:c0.c1023 key=(null)
>> > type=SELINUX_ERR msg=audit(05/04/17 14:47:20.268:219) :
>> > op=security_bounded_transition seresult=denied
>> > oldcontext=staff_u:sysadm_r:apt_t:s0-s0:c0.c1023
>> > newcontext=staff_u:sysadm_r:dpkg_t:s0-s0:c0.c1023
>> >
>> > I do not use any type-/role-bounds rules, and apt and dpkg are
>> > working
>> > without (noticeable) issues.
>>
>> This means that the process or one of its ancestors had set
>> NO_NEW_PRIVS, and then tried to execve a program that normally would
>> have triggered a domain transition.  Domain transitions are only
>> allowed under NO_NEW_PRIVS if the new domain is bounded by the calling
>> domain, since this ensures that no privilege escalation is possible
>> (originally we did not allow domain transitions at all under
>> NO_NEW_PRIVS; this was relaxed to allow them if bounded to support the
>> SELinux sandbox when it began using NO_NEW_PRIVS).  Unless the program
>> explicitly requested the domain transition (via setexeccon), this is
>> treated as a non-fatal error and the process just stays in the calling
>> domain.
>>
>> Hence, at present, apt will continue running in apt_t rather than
>> transitioning into dpkg_t when running dpkg (at least in cases where
>> apt has set NO_NEW_PRIVS prior to execve - I do not know whether it
>> does this universally when running dpkg or only in specific instances).
>> This could be a problem for labeling of any files created by dpkg if
>> relying on type transitions or it could prevent dpkg from performing
>> operations only allowed to dpkg_t (or it could expose dpkg to
>> performing operations only allowed to apt_t).
>>
>> Adding typebounds rules (ala typebounds apt_t dpkg_t; typebounds
>> apt_exec_t dpkg_exec_t; typebounds apt_tmp_t dpkg_tmp_t; ...) would
>> allow the transition to occur, but would then require dpkg_t to be a
>> strict subset of permissions allowed to apt_t.  This does not appear to
>> be the case in current policy, so it would likely break other uses of
>> dpkg.
>>
>> This is an issue for the Debian SELinux maintainers to resolve.
>
> Also note that the NNP flag is inherited. So if dpkg_t also in turn runs things with domain transitions then you will have to bound those types to the parents as well and so forth and so forth.
>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
