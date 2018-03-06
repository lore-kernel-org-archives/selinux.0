Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26MdsVJ019426
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 17:39:54 -0500
Received: by mail-lf0-f66.google.com with SMTP id r80-v6so315064lfe.13
 for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2018 14:31:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a85fef8d-09ee-e62f-1a28-1736c450ae77@tycho.nsa.gov>
References: <20180228092708.GA28719@julius.enp8s0.d30>
 <20180228095317.GB28719@julius.enp8s0.d30>
 <2b189acf-1ee4-d6d4-0188-1333582127be@tycho.nsa.gov>
 <a85fef8d-09ee-e62f-1a28-1736c450ae77@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Mar 2018 17:31:11 -0500
Message-ID: <CAHC9VhRLxcnNf=Rpvos7eiUV0RhXPjZqWPxM_ahwq8KrTgp1xg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Dominick Grift <dac.override@gmail.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Linux 4.16 cap_sys_module
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 28, 2018 at 9:18 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/28/2018 08:53 AM, Stephen Smalley wrote:
>> On 02/28/2018 04:53 AM, Dominick Grift wrote:
>>> On Wed, Feb 28, 2018 at 10:27:08AM +0100, Dominick Grift wrote:
>>>> Since Linux 4.16 (to atleast RC2) user space started to excessively trigger cap_sys_module
>>>>
>>>> Here is one example of such and event:
>>>>
>>>> type=SYSCALL msg=audit(02/27/2018 08:06:40.017:74) : arch=x86_64 syscall=ioctl success=no exit=ENOTTY(Inappropriate ioctl for device) a0=0x2 a1=TCGETS a2=0x7fff2d89f8f0 a3=0x55ba203a9010 items=0 ppid=1 pid=423 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=systemd-user-se exe=/usr/lib/systemd/systemd-user-sessions subj=sys.id:sys.role:user_sessions.subj:s0 key=(null)
>>>> type=AVC msg=audit(02/27/2018 08:06:40.017:74) : avc:  denied  { sys_module } for  pid=423 comm=systemd-user-se capability=sys_module  scontext=sys.id:sys.role:user_sessions.subj:s0 tcontext=sys.id:sys.role:user_sessions.subj:s0 tclass=capability permissive=1
>>>> type=AVC msg=audit(02/27/2018 08:06:40.017:74) : avc:  denied  { module_request } for  pid=423 comm=systemd-user-se kmod=6E65746465762D80E72A05257F scontext=sys.id:sys.role:user_sessions.subj:s0 tcontext=sys.id:sys.role:sys.isid:s0 tclass=system permissive=1
>>>>
>>>> Any idea what causes this and how to fix it?
>>>
>>> For reference: https://github.com/fedora-selinux/selinux-policy/commit/2c13be1fb543c51935785e7a43b798a9f35f5aa0#comments
>>
>> Looks like this might be caused by:
>>
>> commit 44c02a2c3dc55835e9f0d8ef73966406cd805001
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Thu Oct 5 12:59:44 2017 -0400
>>
>>     dev_ioctl(): move copyin/copyout to callers
>>
>>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>
>>
>> It moves the dev_load() call out of the switch statement, which was only
>> conditionally called in the default case if the cmd had certain values,
>> and unconditionally calls it.  So we trigger module load denials on
>> simple TCGETS (isatty) probes on a socket.  We need it moved back.
>
> (expanded cc list since this affects more than just SELinux)

Just in case any of you on the To/CC line missed the patch:

* https://marc.info/?l=linux-netdev&m=152037526927844&w=2

-- 
paul moore
www.paul-moore.com
