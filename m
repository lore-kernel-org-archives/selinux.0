MIME-Version: 1.0
In-Reply-To: <4B40ED4D-BDE5-447D-A374-FDFF3B9CE634@gmail.com>
References: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
	 <200902211351.28303.linuxweb@gmx.net>
	 <dd18b0c30902210155q1ff4e0c3hcb2cea0bdfdf6dca@mail.gmail.com>
	 <200902211806.55864.linuxweb@gmx.net>
	 <4B40ED4D-BDE5-447D-A374-FDFF3B9CE634@gmail.com>
Date: Sat, 21 Feb 2009 11:49:52 -0800
Message-ID: <dd18b0c30902211149x3eb6f642w5bc6b8ec890b3f4@mail.gmail.com>
Subject: Re: ext3 security labels missing
From: Justin Mattock <justinmattock@gmail.com>
To: Dennis Wronka <linuxweb@gmx.net>, SE-Linux <selinux@tycho.nsa.gov>,
        tresys <refpolicy@oss.tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Feb 21, 2009 at 2:50 AM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> Thanks for  help.
> You're probably right with the coreutils
> Package. I'll look at it after I get some rest.
>
> Regards;
>
> justin P. Mattock
>
>
>
> On Feb 21, 2009, at 2:06 AM, Dennis Wronka <linuxweb@gmx.net> wrote:
>
>> On Saturday 21 February 2009 17:55:03 you wrote:
>>>
>>> On Fri, Feb 20, 2009 at 9:51 PM, Dennis Wronka <linuxweb@gmx.net> wrote:
>>>>
>>>> If you don't have the system-auth file and you're still able to login
>>>> then either your system is not really using PAM or login doesn't
>>>> reference system- auth.
>>>> But from what I remember system-auth is not installed by default and you
>>>> have to write it yourself.
>>>> The default login-PAM-config, from the shadow-package, does reference
>>>> system- auth, so I think login should fail if your system really uses
>>>> PAM.
>>>>
>>>> When did you compile PAM? It should be compiled before shadow, so that
>>>> shadow can be compiled with PAM-support.
>>>>
>>>> Also, which getty are you using? You should install mingetty, or you'll
>>>> run into lots of problems that are caused by agetty under SELinux.
>>>>
>>>> As said, check your coreutils, notably id and ls, if they reference the
>>>> SELinux-libs. If not you'll need to compile them again.
>>>>
>>>> Plugging SELinux into LFS is a bit tricky. In order not to have to
>>>> compile too much twice you got to compile stuff in the right place
>>>> during
>>>> the process.
>>>>
>>>> I have attached my stage2-script for your reference. This is the order I
>>>> compile my system in.
>>>> I've got a lot of optional stuff in there, so simply disregard anything
>>>> you don't need.
>>>>
>>>> Also, just out of curiosity: You're doing LFS to learn about the
>>>> internals or do you just want to get an LFS-system with SELinux?
>>>> In the latter case maybe I could interest you in my project, which also
>>>> the attached script is taken from, EasyLFS.
>>>>
>>>> Regards,
>>>> Dennis
>>>>
>>>> On Saturday 21 February 2009 07:10:37 Justin Mattock wrote:
>>>>>
>>>>> On Fri, Feb 20, 2009 at 7:20 AM, Dennis Wronka <linuxweb@gmx.net>
>>>>> wrote:
>>>>>>
>>>>>> Are the coreutils compiled with SELinux-support?
>>>>>> I just gave it a quick check and found that the -Z option is available
>>>>>> in both id and ls without coreutils having actually been built without
>>>>>> SELinux- libraries actually available.
>>>>>>
>>>>>> Could you check this:
>>>>>> ldd $(which ls)
>>>>>>
>>>>>> This should show up a reference to libselinux.so.1
>>>>>> If this reference is missing then I'd suggest recompiling the
>>>>>> coreutils.
>>>>>>
>>>>>> On Friday 20 February 2009 23:03:37 you wrote:
>>>>>>>
>>>>>>> On Fri, Feb 20, 2009 at 6:14 AM, Stephen Smalley <sds@tycho.nsa.gov>
>>>>
>>>> wrote:
>>>>>>>>
>>>>>>>> On Thu, 2009-02-19 at 23:04 -0800, Justin Mattock wrote:
>>>>>>>>>
>>>>>>>>> I've a strange issue.
>>>>>>>>> with my experimental learning machine(LFS)
>>>>>>>>> I'm able to load the policy etc.. but have no labels
>>>>>>>>> on my files.(just a question mark);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ls -lZ shows
>>>>>>>>>
>>>>>>>>> drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
>>>>>>>>> drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
>>>>>>>>> lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
>>>>>>>>> drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
>>>>>>>>> drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
>>>>>>>>> drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
>>>>>>>>> drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
>>>>>>>>> drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
>>>>>>>>> drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
>>>>>>>>> drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
>>>>>>>>> drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
>>>>>>>>> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
>>>>>>>>> dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
>>>>>>>>> drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
>>>>>>>>> drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
>>>>>>>>> drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
>>>>>>>>> drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
>>>>>>>>> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
>>>>>>>>> drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
>>>>>>>>> drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
>>>>>>>>> drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
>>>>>>>>> drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
>>>>>>>>> drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
>>>>>>>>> lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
>>>>>>>>> /boot/vmlinuz-2.6.29-rc4
>>>>>>>>>
>>>>>>>>> if I do a id -Z I get:
>>>>>>>>> id: --context (-Z) works only on an SELinux-enabled kernel
>>>>>>>>> (but it is enabled in the kernel)
>>>>>>>>
>>>>>>>> sestatus shows what?
>>>>>>>>
>>>>>>>> To be fully "enabled" as far as userspace is concerned, SELinux has
>>>>>>>> to be:
>>>>>>>> - enabled in your kernel build,
>>>>>>>> - enabled at boot,
>>>>>>>> - policy has to be loaded
>>>>>>>>
>>>>>>>> grep SELINUX .config
>>>>>>>> cat /etc/selinux/config
>>>>>>>> dmesg | grep SELinux
>>>>>>>>
>>>>>>>>>> From looking back, I enabled as much as possible in any app/lib I
>>>>>>>>>> was compiling
>>>>>>>>>
>>>>>>>>> that provided selinux support.(libc,xserver,hal,dbus, etc..);
>>>>>>>>> But could be missing an important app/lib that might make the
>>>>>>>>> security labels give the proper label. by chance if anybody had
>>>>>>>>> experienced this and/or knows what might be going on,(would be
>>>>>>>>> really appreciated).
>>>>>>>>>
>>>>>>>>> regards;
>>>>>>>>
>>>>>>>> --
>>>>>>>> Stephen Smalley
>>>>>>>> National Security Agency
>>>>>>>
>>>>>>> Thanks for the reply.
>>>>>>> here's what /usr/sbin/sestatus -vv (says);
>>>>>>>
>>>>>>> SELinux status:                 enabled
>>>>>>> SELinuxfs mount:                /selinux
>>>>>>> Current mode:                   permissive
>>>>>>> Mode from config file:          permissive
>>>>>>> Policy version:                 22
>>>>>>> Policy from config file:        refpolicy
>>>>>>>
>>>>>>> Process contexts:
>>>>>>> Current context:                system_u:system_r:local_login_t
>>>>>>> Init context:                   system_u:system_r:init_t
>>>>>>>
>>>>>>> File contexts:
>>>>>>> Controlling term:               system_u:object_r:devpts_t
>>>>>>> /etc/passwd                     system_u:object_r:etc_t
>>>>>>> /bin/bash                       system_u:object_r:shell_exec_t
>>>>>>> /bin/login                      system_u:object_r:login_exec_t
>>>>>>> /bin/sh                         system_u:object_r:bin_t ->
>>>>>>> system_u:object_r:shell_exec_t
>>>>>>> /sbin/agetty                    system_u:object_r:getty_exec_t
>>>>>>> /sbin/init                      system_u:object_r:init_exec_t
>>>>>>> /lib/libc.so.6                  system_u:object_r:lib_t ->
>>>>>>> system_u:object_r:lib_t
>>>>>>> /lib/ld-linux.so.2              system_u:object_r:lib_t ->
>>>>>>> system_u:object_r:ld_so_t
>>>>>>>
>>>>>>> I think this is some aterm,xproto,etc.. library/app(that I forgot to
>>>>>>> install) that's responsible for displaying the security label info in
>>>>>>> the shell.(example) when I use
>>>>>>> audit2allow -d, I generate the correct security allow rules.
>>>>>>> when running make relabel in the policy source directory, reacts as
>>>>>>> it should.
>>>>>>>
>>>>>>> As for setting any options in the kernel. no
>>>>>>> left everything as I've had in the past.
>>>>>>> as for enabling everything. yes
>>>>>>> - enabled in your kernel build,
>>>>>>> - enabled at boot,
>>>>>>> - policy has to be loaded
>>>>>>>
>>>>>>> I'll try adding these rules into the policy irregardless of a
>>>>>>> broken proto/low level communications thing.
>>>>>>> didn't mean to causing any heat.
>>>>>>>
>>>>>>> regards;
>>>>>
>>>>> After looking at the situation, and looking at the
>>>>> (LFS)manual at first you setup shadow with a root
>>>>> password(to get things going); then later once you're up
>>>>> and running you move from using shadow to useing pam.
>>>>> well I've managed to do that.
>>>>> but  I'm not seeing a /etc/pam.d/system-auth file
>>>>> generated by the installer(probably have to manually pick my
>>>>> session,password, account modules);
>>>>> (positive side)
>>>>> under ps aux (Ill have to attach them(before/after) as soon as I get a
>>>>> chance); I finally see:   /bin/login --
>>>>> So hopefully once I get /etc/pam.d cleaned up(hopefully) I
>>>>> should be logged into my SELinux user and have the right context.
>>>>> keep in mind "hopefully".
>>>>> regards;
>>>
>>> As promised here is the attached
>>> ps auxZ
>>>
>>> as it seems I do have pam up and running, but am still
>>> (unfortunately) seeing no security labels.
>>> must have a missing protocol somewhere.
>>>
>>> regards;
>>
>> Just before, resulting from your description of a missing system-auth
>> file, I
>> tested what will happen when I remove my system-auth file.
>> As expected it prevents me from logging into my system.
>>
>> Please also check this:
>> ldd $(which login)
>>
>> This should show references to the PAM-libraries. If this is not the case
>> I
>> guess your shadow may lack PAM-support.
>>
>> Also, as said before, please check is your coreutils have SELinux-support.
>> ldd $(which id)
>> ldd $(which ls)
>>
>> Those should show references to SELinux-libraries. If not, there's
>> something
>> missing. The existence of the -Z-option is no giveaway for
>> SELinux-support. I
>> have checked and those also exist on a system that has been compiled
>> without
>> SELinux-support and even without the SELinux-libraries present.
>

Ahh..
Thanks for the info.
when building coreutils for the first time I
had no SELinux headers:(below said all no when building the first go at it);
(example of ./configure with SELinux headers in place);

checking selinux/flask.h usability... yes
checking selinux/flask.h presence... yes
checking for selinux/flask.h... yes
checking for library containing setfilecon... -lselinux
checking selinux/selinux.h usability... yes
checking selinux/selinux.h presence... yes
checking for selinux/selinux.h... yes
checking selinux/context.h usability... yes
checking selinux/context.h presence... yes
checking for selinux/context.h... yes

Now ls -lZ shows all of the beautiful labels.
Thanks again for the info
(I would of been running around in circles for days
if you didn't mention coreutils);

regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
