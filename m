MIME-Version: 1.0
In-Reply-To: <200902211351.28303.linuxweb@gmx.net>
References: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
	 <200902202320.16356.linuxweb@gmx.net>
	 <dd18b0c30902201510n105c5c0kc1791b9ba1741aea@mail.gmail.com>
	 <200902211351.28303.linuxweb@gmx.net>
Date: Sat, 21 Feb 2009 01:55:03 -0800
Message-ID: <dd18b0c30902210155q1ff4e0c3hcb2cea0bdfdf6dca@mail.gmail.com>
Subject: Re: ext3 security labels missing
From: Justin Mattock <justinmattock@gmail.com>
To: Dennis Wronka <linuxweb@gmx.net>, russell@coker.com.au,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=000e0cd18192743e6c04636ac3a6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd18192743e6c04636ac3a6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Feb 20, 2009 at 9:51 PM, Dennis Wronka <linuxweb@gmx.net> wrote:
> If you don't have the system-auth file and you're still able to login then
> either your system is not really using PAM or login doesn't reference system-
> auth.
> But from what I remember system-auth is not installed by default and you have
> to write it yourself.
> The default login-PAM-config, from the shadow-package, does reference system-
> auth, so I think login should fail if your system really uses PAM.
>
> When did you compile PAM? It should be compiled before shadow, so that shadow
> can be compiled with PAM-support.
>
> Also, which getty are you using? You should install mingetty, or you'll run
> into lots of problems that are caused by agetty under SELinux.
>
> As said, check your coreutils, notably id and ls, if they reference the
> SELinux-libs. If not you'll need to compile them again.
>
> Plugging SELinux into LFS is a bit tricky. In order not to have to compile too
> much twice you got to compile stuff in the right place during the process.
>
> I have attached my stage2-script for your reference. This is the order I
> compile my system in.
> I've got a lot of optional stuff in there, so simply disregard anything you
> don't need.
>
> Also, just out of curiosity: You're doing LFS to learn about the internals or
> do you just want to get an LFS-system with SELinux?
> In the latter case maybe I could interest you in my project, which also the
> attached script is taken from, EasyLFS.
>
> Regards,
> Dennis
>
> On Saturday 21 February 2009 07:10:37 Justin Mattock wrote:
>> On Fri, Feb 20, 2009 at 7:20 AM, Dennis Wronka <linuxweb@gmx.net> wrote:
>> > Are the coreutils compiled with SELinux-support?
>> > I just gave it a quick check and found that the -Z option is available in
>> > both id and ls without coreutils having actually been built without
>> > SELinux- libraries actually available.
>> >
>> > Could you check this:
>> > ldd $(which ls)
>> >
>> > This should show up a reference to libselinux.so.1
>> > If this reference is missing then I'd suggest recompiling the coreutils.
>> >
>> > On Friday 20 February 2009 23:03:37 you wrote:
>> >> On Fri, Feb 20, 2009 at 6:14 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>> >> > On Thu, 2009-02-19 at 23:04 -0800, Justin Mattock wrote:
>> >> >> I've a strange issue.
>> >> >> with my experimental learning machine(LFS)
>> >> >> I'm able to load the policy etc.. but have no labels
>> >> >> on my files.(just a question mark);
>> >> >>
>> >> >>
>> >> >> ls -lZ shows
>> >> >>
>> >> >> drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
>> >> >> drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
>> >> >> lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
>> >> >> drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
>> >> >> drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
>> >> >> drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
>> >> >> drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
>> >> >> drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
>> >> >> drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
>> >> >> drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
>> >> >> drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
>> >> >> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
>> >> >> dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
>> >> >> drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
>> >> >> drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
>> >> >> drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
>> >> >> drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
>> >> >> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
>> >> >> drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
>> >> >> drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
>> >> >> drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
>> >> >> drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
>> >> >> drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
>> >> >> lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
>> >> >> /boot/vmlinuz-2.6.29-rc4
>> >> >>
>> >> >> if I do a id -Z I get:
>> >> >> id: --context (-Z) works only on an SELinux-enabled kernel
>> >> >> (but it is enabled in the kernel)
>> >> >
>> >> > sestatus shows what?
>> >> >
>> >> > To be fully "enabled" as far as userspace is concerned, SELinux has to
>> >> > be:
>> >> > - enabled in your kernel build,
>> >> > - enabled at boot,
>> >> > - policy has to be loaded
>> >> >
>> >> > grep SELINUX .config
>> >> > cat /etc/selinux/config
>> >> > dmesg | grep SELinux
>> >> >
>> >> >> >From looking back, I enabled as much as possible in any app/lib I
>> >> >> > was compiling
>> >> >>
>> >> >> that provided selinux support.(libc,xserver,hal,dbus, etc..);
>> >> >> But could be missing an important app/lib that might make the
>> >> >> security labels give the proper label. by chance if anybody had
>> >> >> experienced this and/or knows what might be going on,(would be really
>> >> >> appreciated).
>> >> >>
>> >> >> regards;
>> >> >
>> >> > --
>> >> > Stephen Smalley
>> >> > National Security Agency
>> >>
>> >> Thanks for the reply.
>> >> here's what /usr/sbin/sestatus -vv (says);
>> >>
>> >> SELinux status:                 enabled
>> >> SELinuxfs mount:                /selinux
>> >> Current mode:                   permissive
>> >> Mode from config file:          permissive
>> >> Policy version:                 22
>> >> Policy from config file:        refpolicy
>> >>
>> >> Process contexts:
>> >> Current context:                system_u:system_r:local_login_t
>> >> Init context:                   system_u:system_r:init_t
>> >>
>> >> File contexts:
>> >> Controlling term:               system_u:object_r:devpts_t
>> >> /etc/passwd                     system_u:object_r:etc_t
>> >> /bin/bash                       system_u:object_r:shell_exec_t
>> >> /bin/login                      system_u:object_r:login_exec_t
>> >> /bin/sh                         system_u:object_r:bin_t ->
>> >> system_u:object_r:shell_exec_t
>> >> /sbin/agetty                    system_u:object_r:getty_exec_t
>> >> /sbin/init                      system_u:object_r:init_exec_t
>> >> /lib/libc.so.6                  system_u:object_r:lib_t ->
>> >> system_u:object_r:lib_t
>> >> /lib/ld-linux.so.2              system_u:object_r:lib_t ->
>> >> system_u:object_r:ld_so_t
>> >>
>> >> I think this is some aterm,xproto,etc.. library/app(that I forgot to
>> >> install) that's responsible for displaying the security label info in
>> >> the shell.(example) when I use
>> >> audit2allow -d, I generate the correct security allow rules.
>> >> when running make relabel in the policy source directory, reacts as it
>> >> should.
>> >>
>> >> As for setting any options in the kernel. no
>> >> left everything as I've had in the past.
>> >> as for enabling everything. yes
>> >> - enabled in your kernel build,
>> >> - enabled at boot,
>> >> - policy has to be loaded
>> >>
>> >> I'll try adding these rules into the policy irregardless of a
>> >> broken proto/low level communications thing.
>> >> didn't mean to causing any heat.
>> >>
>> >> regards;
>>
>> After looking at the situation, and looking at the
>> (LFS)manual at first you setup shadow with a root
>> password(to get things going); then later once you're up
>> and running you move from using shadow to useing pam.
>> well I've managed to do that.
>> but  I'm not seeing a /etc/pam.d/system-auth file
>> generated by the installer(probably have to manually pick my
>> session,password, account modules);
>> (positive side)
>> under ps aux (Ill have to attach them(before/after) as soon as I get a
>> chance); I finally see:   /bin/login --
>> So hopefully once I get /etc/pam.d cleaned up(hopefully) I
>> should be logged into my SELinux user and have the right context.
>> keep in mind "hopefully".
>> regards;
>
>
>

As promised here is the attached
ps auxZ

as it seems I do have pam up and running, but am still
(unfortunately) seeing no security labels.
must have a missing protocol somewhere.

regards;

-- 
Justin P. Mattock

--000e0cd18192743e6c04636ac3a6
Content-Type: application/octet-stream; name=beforeafterpsauxZ
Content-Disposition: attachment; filename=beforeafterpsauxZ
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frg471iu2

CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC8qdXNpbmcgYSBzaGFkb3cgbWVjaGFuaXNtICovCgpMQUJFTCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFVTRVIgICAgICAgUElEICVDUFUgJU1FTSAgICBWU1ogICBSU1MgVFRZICAgICAgU1RB
VCBTVEFSVCAgIFRJTUUgQ09NTUFORApzeXN0ZW1fdTpzeXN0ZW1fcjppbml0X3QgICAgICAgIHJv
b3QgICAgICAgICAxICAwLjEgIDAuMCAgIDIwNTYgICA3MDQgPyAgICAgICAgU3MgICAwOToyMSAg
IDA6MDEgaW5pdCBbM10gIApzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAg
ICAgICAyICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAg
W2t0aHJlYWRkXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgICAz
ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW21pZ3Jh
dGlvbi8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgICA0ICAw
LjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2tzb2Z0aXJx
ZC8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgICA1ICAwLjAg
IDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW3dhdGNoZG9nLzBd
CnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAgIDYgIDAuMCAgMC4w
ICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbbWlncmF0aW9uLzFdCnN5
c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAgIDcgIDAuMCAgMC4wICAg
ICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBba3NvZnRpcnFkLzFdCnN5c3Rl
bV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAgIDggIDAuMCAgMC4wICAgICAg
MCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbd2F0Y2hkb2cvMV0Kc3lzdGVtX3U6
c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgICAgOSAgMC4wICAwLjAgICAgICAwICAg
ICAwID8gICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtldmVudHMvMF0Kc3lzdGVtX3U6c3lzdGVt
X3I6a2VybmVsX3QgICAgICByb290ICAgICAgICAxMCAgMC4wICAwLjAgICAgICAwICAgICAwID8g
ICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtldmVudHMvMV0Kc3lzdGVtX3U6c3lzdGVtX3I6a2Vy
bmVsX3QgICAgICByb290ICAgICAgICAxMSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAg
IFM8ICAgMDk6MjEgICAwOjAwIFt3b3JrX29uX2NwdS8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJu
ZWxfdCAgICAgIHJvb3QgICAgICAgIDEyICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAg
UzwgICAwOToyMSAgIDA6MDAgW3dvcmtfb25fY3B1LzFdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5l
bF90ICAgICAgcm9vdCAgICAgICAgMTMgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBT
PCAgIDA5OjIxICAgMDowMCBba2hlbHBlcl0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAg
ICByb290ICAgICAgIDEzMSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDk6
MjEgICAwOjAwIFtrYmxvY2tkLzBdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9v
dCAgICAgICAxMzIgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAg
MDowMCBba2Jsb2NrZC8xXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAg
ICAgMTM0ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAg
W2thY3BpZF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDEzNSAg
MC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtrYWNwaV9u
b3RpZnldCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAyMDUgIDAu
MCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbY3F1ZXVlXQpz
eXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjA5ICAwLjAgIDAuMCAg
ICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2F0YS8wXQpzeXN0ZW1fdTpz
eXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjEwICAwLjAgIDAuMCAgICAgIDAgICAg
IDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2F0YS8xXQpzeXN0ZW1fdTpzeXN0ZW1fcjpr
ZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjExICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAg
ICAgUzwgICAwOToyMSAgIDA6MDAgW2F0YV9hdXhdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90
ICAgICAgcm9vdCAgICAgICAyMTIgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAg
IDA5OjIxICAgMDowMCBba3N1c3BlbmRfdXNiZF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3Qg
ICAgICByb290ICAgICAgIDIxOCAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAg
MDk6MjEgICAwOjAwIFtraHViZF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290
ICAgICAgIDIyMSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDk6MjEgICAw
OjAwIFtrc2VyaW9kXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAg
MjQ0ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2tv
bmRlbWFuZC8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjQ1
ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2tvbmRl
bWFuZC8xXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjc3ICAw
LjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW3J0LXRlc3Qt
MF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI3OSAgMC4wICAw
LjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtydC10ZXN0LTFdCnN5
c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAyODEgIDAuMCAgMC4wICAg
ICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbcnQtdGVzdC0yXQpzeXN0ZW1f
dTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjgzICAwLjAgIDAuMCAgICAgIDAg
ICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW3J0LXRlc3QtM10Kc3lzdGVtX3U6c3lz
dGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI4NSAgMC4wICAwLjAgICAgICAwICAgICAw
ID8gICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtydC10ZXN0LTRdCnN5c3RlbV91OnN5c3RlbV9y
Omtlcm5lbF90ICAgICAgcm9vdCAgICAgICAyODcgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAg
ICAgICBTPCAgIDA5OjIxICAgMDowMCBbcnQtdGVzdC01XQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJu
ZWxfdCAgICAgIHJvb3QgICAgICAgMjg5ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAg
UzwgICAwOToyMSAgIDA6MDAgW3J0LXRlc3QtNl0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3Qg
ICAgICByb290ICAgICAgIDI5MSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAg
MDk6MjEgICAwOjAwIFtydC10ZXN0LTddCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAg
cm9vdCAgICAgICAyOTQgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTICAgIDA5OjIx
ICAgMDowMCBbcGRmbHVzaF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAg
ICAgIDI5NSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFMgICAgMDk6MjEgICAwOjAw
IFtwZGZsdXNoXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjk2
ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2tzd2Fw
ZDBdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAzOTAgIDAuMCAg
MC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbYWlvLzBdCnN5c3Rl
bV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAzOTEgIDAuMCAgMC4wICAgICAg
MCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbYWlvLzFdCnN5c3RlbV91OnN5c3Rl
bV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICA1NTQgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/
ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbc2NzaV9laF8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjpr
ZXJuZWxfdCAgICAgIHJvb3QgICAgICAgNTU4ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAg
ICAgUzwgICAwOToyMSAgIDA6MDAgW3Njc2lfZWhfMV0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVs
X3QgICAgICByb290ICAgICAgIDU2NiAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8
ICAgMDk6MjEgICAwOjAwIFtzY3NpX2VoXzJdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAg
ICAgcm9vdCAgICAgICA1NjggIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5
OjIxICAgMDowMCBbc2NzaV9laF8zXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJv
b3QgICAgICAgNTkzICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAg
IDA6MDAgW2tzdHJpcGVkXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAg
ICAgNTk4ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAg
W2VkYWMtcG9sbGVyXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAg
NjAxICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2hp
ZF9jb21wYXRdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICA2MzMg
IDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBba2pvdXJu
YWxkXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgNjkxICAwLjAg
IDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwOToyMSAgIDA6MDAgW2FwcGxlc21jLWxl
ZF0Kc3lzdGVtX3U6c3lzdGVtX3I6dWRldl90ICAgICAgICByb290ICAgICAgIDgwMCAgMC4wICAw
LjAgICAyMTQ4ICAgODkyID8gICAgICAgIFM8cyAgMDk6MjEgICAwOjAwIC9zYmluL3VkZXZkIC0t
ZGFlbW9uCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgIDEyMzMgIDAu
MCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBba2hwc2Jwa3Rd
CnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgIDEyNTcgIDAuMCAgMC4w
ICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDA5OjIxICAgMDowMCBbcGh5MF0Kc3lzdGVtX3U6
c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgMTMwOSAgMC4wICAwLjAgICAgICAwICAg
ICAwID8gICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtrbm9kZW1ncmRfMF0Kc3lzdGVtX3U6c3lz
dGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgMTMyNCAgMC4wICAwLjAgICAgICAwICAgICAw
ID8gICAgICAgIFM8ICAgMDk6MjEgICAwOjAwIFtoZC1hdWRpbzBdCnN5c3RlbV91OnN5c3RlbV9y
OnN5c2xvZ2RfdCAgICAgcm9vdCAgICAgIDE1MDUgIDAuMCAgMC4wICAgMTcxNiAgIDU2NCA/ICAg
ICAgICBTTnMgIDA5OjIxICAgMDowMCBzeXNsb2dkIC1tIDAKc3lzdGVtX3U6c3lzdGVtX3I6a2xv
Z2RfdCAgICAgICByb290ICAgICAgMTUwOCAgMC4wICAwLjEgICAzMTYwICAxOTg0ID8gICAgICAg
IFNOcyAgMDk6MjEgICAwOjAwIGtsb2dkCnN5c3RlbV91OnN5c3RlbV9yOnN5c3RlbV9kYnVzZF90
IG5hbWUgICAgMTUyNCAgMC4wICAwLjAgIDEwNTU2ICAgOTkyID8gICAgICAgIFNOc2wgMDk6MjEg
ICAwOjAwIC91c3IvYmluL2RidXMtZGFlbW9uIC0tc3lzdGVtCnN5c3RlbV91OnN5c3RlbV9yOmhh
bGRfdCAgICAgICAgbmFtZSAgICAgIDE1NjkgIDAuMCAgMC4zICAgNTY3NiAgMzYwOCA/ICAgICAg
ICBTTnMgIDA5OjIxICAgMDowMCAvdXNyL3NiaW4vaGFsZCAtLXVzZS1zeXNsb2cKc3lzdGVtX3U6
c3lzdGVtX3I6aGFsZF90ICAgICAgICByb290ICAgICAgMTU3MCAgMC4wICAwLjEgICAzMTIwICAx
MDMyID8gICAgICAgIFNOICAgMDk6MjEgICAwOjAwIGhhbGQtcnVubmVyCnN5c3RlbV91OnN5c3Rl
bV9yOmhhbGRfdCAgICAgICAgcm9vdCAgICAgIDE1NzQgIDAuMCAgMC4wICAgMzE4NCAgIDk4MCA/
ICAgICAgICBTTiAgIDA5OjIxICAgMDowMCBoYWxkLWFkZG9uLWlucHV0OiBMaXN0ZW5pbmcgb24g
Ly9kZXYvaW5wdXQvZXZlbnQ5IC8vZGV2L2lucHV0L2V2ZW50NSAvL2Rldi9pbnB1dC9ldmVudDQg
Ly9kZXYvaW5wdXQvZXZlbnQyIC8vZGV2L2lucHV0L2V2ZW50MTIgLy9kZXYvaW5wdXQvZXZlbnQx
MSAvL2Rldi9pbnB1dC9ldmVudDMgLy9kZXYvaW5wdXQvZXZlbnQ3CnN5c3RlbV91OnN5c3RlbV9y
OmhhbGRfdCAgICAgICAgcm9vdCAgICAgIDE1ODAgIDAuMCAgMC4wICAgMzE4NCAgIDk0OCA/ICAg
ICAgICBTTiAgIDA5OjIxICAgMDowMCAvdXNyL2xpYmV4ZWMvaGFsZC1hZGRvbi1sZWRzCnN5c3Rl
bV91OnN5c3RlbV9yOmhhbGRfbWFjX3QgICAgcm9vdCAgICAgIDE1OTIgIDAuMCAgMC4xICAgMzIw
MCAgMTA0NCA/ICAgICAgICBTTiAgIDA5OjIxICAgMDowMCAvdXNyL2xpYmV4ZWMvaGFsZC1hZGRv
bi1tYWNib29rcHJvLWJhY2tsaWdodApzeXN0ZW1fdTpzeXN0ZW1fcjpoYWxkX3QgICAgICAgIHJv
b3QgICAgICAxNTk5ICAwLjAgIDAuMCAgIDMxODggICA5NzIgPyAgICAgICAgU04gICAwOToyMSAg
IDA6MDAgaGFsZC1hZGRvbi1zdG9yYWdlOiBubyBwb2xsaW5nIG9uIC8vZGV2L3NyMCBiZWNhdXNl
IGl0IGlzIGV4cGxpY2l0bHkgZGlzYWJsZWQKc3lzdGVtX3U6c3lzdGVtX3I6bG9jYWxfbG9naW5f
dCBuYW1lICAgICAxNjAwICAwLjAgIDAuMSAgIDMwOTIgIDE0OTIgdHR5MSAgICAgU3MgICAwOToy
MSAgIDA6MDAgLWJhc2gKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0dHlfdCAgICAgICByb290ICAgICAg
MTYwNCAgMC4wICAwLjAgICAxNjY4ICAgNDkyIHR0eTIgICAgIFNzKyAgMDk6MjEgICAwOjAwIC9z
YmluL2FnZXR0eSB0dHkyIDk2MDAKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0dHlfdCAgICAgICByb290
ICAgICAgMTYwNSAgMC4wICAwLjAgICAxNjY4ICAgNDkyIHR0eTMgICAgIFNzKyAgMDk6MjEgICAw
OjAwIC9zYmluL2FnZXR0eSB0dHkzIDk2MDAKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0dHlfdCAgICAg
ICByb290ICAgICAgMTYwNiAgMC4wICAwLjAgICAxNjY4ICAgNDkyIHR0eTQgICAgIFNzKyAgMDk6
MjEgICAwOjAwIC9zYmluL2FnZXR0eSB0dHk0IDk2MDAKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0dHlf
dCAgICAgICByb290ICAgICAgMTYwNyAgMC4wICAwLjAgICAxNjY4ICAgNDk2IHR0eTUgICAgIFNz
KyAgMDk6MjEgICAwOjAwIC9zYmluL2FnZXR0eSB0dHk1IDk2MDAKc3lzdGVtX3U6c3lzdGVtX3I6
Z2V0dHlfdCAgICAgICByb290ICAgICAgMTYwOCAgMC4wICAwLjAgICAxNjY4ICAgNDk2IHR0eTYg
ICAgIFNzKyAgMDk6MjEgICAwOjAwIC9zYmluL2FnZXR0eSB0dHk2IDk2MDAKc3lzdGVtX3U6c3lz
dGVtX3I6aGFsZF90ICAgICAgICByb290ICAgICAgMTYxMCAgMC4wICAwLjAgICAzMTk2ICAgOTQ4
ID8gICAgICAgIFNOICAgMDk6MjEgICAwOjAwIC91c3IvbGliZXhlYy9oYWxkLWFkZG9uLWNwdWZy
ZXEKc3lzdGVtX3U6c3lzdGVtX3I6aGFsZF90ICAgICAgICBuYW1lICAgICAgMTYxMSAgMC4wICAw
LjAgICAyODQwICAgODY4ID8gICAgICAgIFNOICAgMDk6MjEgICAwOjAwIGhhbGQtYWRkb24tYWNw
aTogbGlzdGVuaW5nIG9uIGFjcGkga2VybmVsIGludGVyZmFjZSAvcHJvYy9hY3BpL2V2ZW50CnN5
c3RlbV91OnN5c3RlbV9yOmxvY2FsX2xvZ2luX3QgbmFtZSAgICAgMTYzMCAgMC4wICAwLjEgICAy
OTEyICAxMTA4IHR0eTEgICAgIFMrICAgMDk6MjIgICAwOjAwIC9iaW4vc2ggL3Vzci9iaW4vc3Rh
cnR4CnN5c3RlbV91OnN5c3RlbV9yOmxvY2FsX2xvZ2luX3QgbmFtZSAgICAgMTY0NiAgMC4wICAw
LjAgICAyOTMyICAgNzUyIHR0eTEgICAgIFMrICAgMDk6MjIgICAwOjAwIHhpbml0IC91c3IvbGli
L1gxMS94aW5pdC94aW5pdHJjIC0tIC91c3IvYmluL1ggOjAgLWF1dGgKL2hvbWUvbmFtZS8uc2Vy
dmVyYXV0aC4xNjMwCnN5c3RlbV91OnN5c3RlbV9yOmxvY2FsX2xvZ2luX3Qgcm9vdCAgICAgIDE2
NDcgIDAuNiAgMS40ICAxOTAxNiAxNDU5NiB0dHk3ICAgICBTcysgIDA5OjIyICAgMDowNiAvdXNy
L2Jpbi9YIDowIC1hdXRoIC9ob21lL25hbWUvc2VydmVyYXV0aC4xNjMwCnN5c3RlbV91OnN5c3Rl
bV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgIDE2ODAgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/
ICAgICAgICBTPCAgIDA5OjIyICAgMDowMCBba2F1ZGl0ZF0Kc3lzdGVtX3U6c3lzdGVtX3I6bG9j
YWxfbG9naW5fdCBuYW1lICAgICAgMTY4MSAgMC4wICAwLjQgICA2ODg0ICA0MDgwIHR0eTEgICAg
IFMgICAgMDk6MjIgICAwOjAwIGZsdXhib3gKc3lzdGVtX3U6c3lzdGVtX3I6bG9jYWxfbG9naW5f
dCBuYW1lICAgICAxNzA1ICAwLjIgIDAuMSAgIDM3ODQgIDE5MjQgPyAgICAgICAgU3MgICAwOToy
MiAgIDA6MDMgYXRlcm0Kc3lzdGVtX3U6c3lzdGVtX3I6bG9jYWxfbG9naW5fdCBuYW1lICAgICAx
NzA2ICAwLjAgIDAuMSAgIDMwOTIgIDE0NTYgcHRzLzAgICAgU3MgICAwOToyMiAgIDA6MDAgYmFz
aApzeXN0ZW1fdTpzeXN0ZW1fcjpsb2NhbF9sb2dpbl90IG5hbWUgICAgICAxNzc1ICAwLjAgIDAu
MCAgIDIxNDQgICA4MTYgcHRzLzAgICAgUisgICAwOTo0MCAgIDA6MDAgcHMgYXV4WgoKCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiB1c2luZyBz
aGFkb3cvaGFsIG1lY2hhbmlzbSAqLwoKCgoKTEFCRUwgICAgICAgICAgICAgICAgICAgICAgICAg
ICBVU0VSICAgICAgIFBJRCAlQ1BVICVNRU0gICAgVlNaICAgUlNTIFRUWSAgICAgIFNUQVQgU1RB
UlQgICBUSU1FIENPTU1BTkQKc3lzdGVtX3U6c3lzdGVtX3I6aW5pdF90ICAgICAgICByb290ICAg
ICAgICAgMSAgMi4wICAwLjAgICAyMDU2ICAgNzA0ID8gICAgICAgIFNzICAgMDE6MzMgICAwOjAx
IGluaXQgWzNdICAKc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgICAg
MiAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtrdGhy
ZWFkZF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgICAgMyAgMC4w
ICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFttaWdyYXRpb24v
MF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgICAgNCAgMC4wICAw
LjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtrc29mdGlycWQvMF0K
c3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgICAgNSAgMC4wICAwLjAg
ICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFt3YXRjaGRvZy8wXQpzeXN0
ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgICA2ICAwLjAgIDAuMCAgICAg
IDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW21pZ3JhdGlvbi8xXQpzeXN0ZW1f
dTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgICA3ICAwLjAgIDAuMCAgICAgIDAg
ICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2tzb2Z0aXJxZC8xXQpzeXN0ZW1fdTpz
eXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgICA4ICAwLjAgIDAuMCAgICAgIDAgICAg
IDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW3dhdGNoZG9nLzFdCnN5c3RlbV91OnN5c3Rl
bV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAgIDkgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/
ICAgICAgICBTPCAgIDAxOjMzICAgMDowMCBbZXZlbnRzLzBdCnN5c3RlbV91OnN5c3RlbV9yOmtl
cm5lbF90ICAgICAgcm9vdCAgICAgICAgMTAgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAg
ICBTPCAgIDAxOjMzICAgMDowMCBbZXZlbnRzLzFdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90
ICAgICAgcm9vdCAgICAgICAgMTEgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAg
IDAxOjMzICAgMDowMCBbd29ya19vbl9jcHUvMF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3Qg
ICAgICByb290ICAgICAgICAxMiAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAg
MDE6MzMgICAwOjAwIFt3b3JrX29uX2NwdS8xXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAg
ICAgIHJvb3QgICAgICAgIDEzICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAw
MTozMyAgIDA6MDAgW2toZWxwZXJdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9v
dCAgICAgICAxMzEgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAxOjMzICAg
MDowMCBba2Jsb2NrZC8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAg
ICAgMTMyICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAg
W2tibG9ja2QvMV0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDEz
NCAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtrYWNw
aWRdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAxMzUgIDAuMCAg
MC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAxOjMzICAgMDowMCBba2FjcGlfbm90aWZ5
XQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjA1ICAwLjAgIDAu
MCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2NxdWV1ZV0Kc3lzdGVt
X3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDIwOSAgMC4wICAwLjAgICAgICAw
ICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFthdGEvMF0Kc3lzdGVtX3U6c3lzdGVt
X3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDIxMCAgMC4wICAwLjAgICAgICAwICAgICAwID8g
ICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFthdGEvMV0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVs
X3QgICAgICByb290ICAgICAgIDIxMSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8
ICAgMDE6MzMgICAwOjAwIFthdGFfYXV4XQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAg
IHJvb3QgICAgICAgMjEyICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMToz
MyAgIDA6MDAgW2tzdXNwZW5kX3VzYmRdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAg
cm9vdCAgICAgICAyMTggIDAuMiAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAxOjMz
ICAgMDowMCBba2h1YmRdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAg
ICAyMjEgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAxOjMzICAgMDowMCBb
a3NlcmlvZF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI0NCAg
MC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtrb25kZW1h
bmQvMF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI0NSAgMC4w
ICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtrb25kZW1hbmQv
MV0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI3NyAgMC4wICAw
LjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtydC10ZXN0LTBdCnN5
c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAyNzkgIDAuMCAgMC4wICAg
ICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAxOjMzICAgMDowMCBbcnQtdGVzdC0xXQpzeXN0ZW1f
dTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMjgxICAwLjAgIDAuMCAgICAgIDAg
ICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW3J0LXRlc3QtMl0Kc3lzdGVtX3U6c3lz
dGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI4MyAgMC4wICAwLjAgICAgICAwICAgICAw
ID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtydC10ZXN0LTNdCnN5c3RlbV91OnN5c3RlbV9y
Omtlcm5lbF90ICAgICAgcm9vdCAgICAgICAyODUgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAg
ICAgICBTPCAgIDAxOjMzICAgMDowMCBbcnQtdGVzdC00XQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJu
ZWxfdCAgICAgIHJvb3QgICAgICAgMjg3ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAg
UzwgICAwMTozMyAgIDA6MDAgW3J0LXRlc3QtNV0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3Qg
ICAgICByb290ICAgICAgIDI4OSAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAg
MDE6MzMgICAwOjAwIFtydC10ZXN0LTZdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAg
cm9vdCAgICAgICAyOTEgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAxOjMz
ICAgMDowMCBbcnQtdGVzdC03XQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3Qg
ICAgICAgMjk0ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUyAgICAwMTozMyAgIDA6
MDAgW3BkZmx1c2hdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgICAy
OTUgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTICAgIDAxOjMzICAgMDowMCBbcGRm
bHVzaF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDI5NiAgMC4w
ICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtrc3dhcGQwXQpz
eXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMzkwICAwLjAgIDAuMCAg
ICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2Fpby8wXQpzeXN0ZW1fdTpz
eXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgMzkxICAwLjAgIDAuMCAgICAgIDAgICAg
IDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2Fpby8xXQpzeXN0ZW1fdTpzeXN0ZW1fcjpr
ZXJuZWxfdCAgICAgIHJvb3QgICAgICAgNTU0ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAg
ICAgUzwgICAwMTozMyAgIDA6MDAgW3Njc2lfZWhfMF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVs
X3QgICAgICByb290ICAgICAgIDU1OCAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8
ICAgMDE6MzMgICAwOjAwIFtzY3NpX2VoXzFdCnN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90ICAg
ICAgcm9vdCAgICAgICA1NjYgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAgICAgICBTPCAgIDAx
OjMzICAgMDowMCBbc2NzaV9laF8yXQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJv
b3QgICAgICAgNTY4ICAwLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAg
IDA6MDAgW3Njc2lfZWhfM10Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAg
ICAgIDU5MyAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAw
IFtrc3RyaXBlZF0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDU5
OCAgMC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtlZGFj
LXBvbGxlcl0Kc3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDYwMSAg
MC4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFtoaWRfY29t
cGF0XQpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAgNjMzICAwLjAg
IDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2tqb3VybmFsZF0K
c3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3QgICAgICByb290ICAgICAgIDY5MSAgMC4wICAwLjAg
ICAgICAwICAgICAwID8gICAgICAgIFM8ICAgMDE6MzMgICAwOjAwIFthcHBsZXNtYy1sZWRdCnN5
c3RlbV91OnN5c3RlbV9yOnVkZXZfdCAgICAgICAgcm9vdCAgICAgICA4MDAgIDAuNiAgMC4wICAg
MjE0OCAgIDg5NiA/ICAgICAgICBTPHMgIDAxOjMzICAgMDowMCAvc2Jpbi91ZGV2ZCAtLWRhZW1v
bgpzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAxMjI4ICAwLjAgIDAu
MCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2tocHNicGt0XQpzeXN0
ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAxMjcwICAwLjAgIDAuMCAgICAg
IDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW3BoeTBdCnN5c3RlbV91OnN5c3Rl
bV9yOmtlcm5lbF90ICAgICAgcm9vdCAgICAgIDEzMDcgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/
ICAgICAgICBTPCAgIDAxOjMzICAgMDowMCBba25vZGVtZ3JkXzBdCnN5c3RlbV91OnN5c3RlbV9y
Omtlcm5lbF90ICAgICAgcm9vdCAgICAgIDEzNDYgIDAuMCAgMC4wICAgICAgMCAgICAgMCA/ICAg
ICAgICBTPCAgIDAxOjMzICAgMDowMCBbaGQtYXVkaW8wXQpzeXN0ZW1fdTpzeXN0ZW1fcjpzeXNs
b2dkX3QgICAgIHJvb3QgICAgICAxNTMxICAwLjEgIDAuMCAgIDE3MTYgICA1NTIgPyAgICAgICAg
U05zICAwMTozMyAgIDA6MDAgc3lzbG9nZCAtbSAwCnN5c3RlbV91OnN5c3RlbV9yOmtsb2dkX3Qg
ICAgICAgcm9vdCAgICAgIDE1NDEgIDAuMyAgMC4xICAgMzE2MCAgMTk4NCA/ICAgICAgICBTTnMg
IDAxOjMzICAgMDowMCBrbG9nZApzeXN0ZW1fdTpzeXN0ZW1fcjpzeXN0ZW1fZGJ1c2RfdCBuYW1l
ICAgIDE1NTggIDAuMCAgMC4wICAxMDU1NiAgIDk5NiA/ICAgICAgICBTTnNsIDAxOjMzICAgMDow
MCAvdXNyL2Jpbi9kYnVzLWRhZW1vbiAtLXN5c3RlbQpzeXN0ZW1fdTpzeXN0ZW1fcjpoYWxkX3Qg
ICAgICAgICBuYW1lICAgICAxNjAyICAwLjggIDAuMyAgIDU2NTYgIDM2MTYgPyAgICAgICAgU05z
ICAwMTozMyAgIDA6MDAgL3Vzci9zYmluL2hhbGQgLS11c2Utc3lzbG9nCnN5c3RlbV91OnN5c3Rl
bV9yOmhhbGRfdCAgICAgICAgcm9vdCAgICAgIDE2MDMgIDAuMCAgMC4xICAgMzEyMCAgMTA0NCA/
ICAgICAgICBTTiAgIDAxOjMzICAgMDowMCBoYWxkLXJ1bm5lcgpzeXN0ZW1fdTpzeXN0ZW1fcjpo
YWxkX3QgICAgICAgIHJvb3QgICAgICAxNjA3ICAwLjAgIDAuMCAgIDMxODQgICA5ODAgPyAgICAg
ICAgU04gICAwMTozMyAgIDA6MDAgaGFsZC1hZGRvbi1pbnB1dDogTGlzdGVuaW5nIG9uIC8vZGV2
L2lucHV0L2V2ZW50NiAvL2Rldi9pbnB1dC9ldmVudDQgLy9kZXYvaW5wdXQvZXZlbnQyIC8vZGV2
L2lucHV0L2V2ZW50MTIgLy9kZXYvaW5wdXQvZXZlbnQxMSAvL2Rldi9pbnB1dC9ldmVudDkgLy9k
ZXYvaW5wdXQvZXZlbnQzIC8vZGV2L2lucHV0L2V2ZW50OApzeXN0ZW1fdTpzeXN0ZW1fcjpoYWxk
X3QgICAgICAgIHJvb3QgICAgICAxNjEzICAwLjAgIDAuMCAgIDMxODQgICA5NDggPyAgICAgICAg
U04gICAwMTozMyAgIDA6MDAgL3Vzci9saWJleGVjL2hhbGQtYWRkb24tbGVkcwpzeXN0ZW1fdTpz
eXN0ZW1fcjpoYWxkX21hY190ICAgIHJvb3QgICAgICAxNjI1ICAwLjAgIDAuMSAgIDMyMDAgIDEw
NDAgPyAgICAgICAgU04gICAwMTozMyAgIDA6MDAgL3Vzci9saWJleGVjL2hhbGQtYWRkb24tbWFj
Ym9va3Byby1iYWNrbGlnaHQKc3lzdGVtX3U6c3lzdGVtX3I6aGFsZF90ICAgICAgICByb290ICAg
ICAgMTYzMSAgMC4wICAwLjAgICAzMTg4ICAgOTc2ID8gICAgICAgIFNOICAgMDE6MzMgICAwOjAw
IGhhbGQtYWRkb24tc3RvcmFnZTogbm8gcG9sbGluZyBvbiAvL2Rldi9zcjAgYmVjYXVzZSBpdCBp
cyBleHBsaWNpdGx5IGRpc2FibGVkCnN5c3RlbV91OnN5c3RlbV9yOmdldHR5X3QgICAgICAgcm9v
dCAgICAgIDE2MzIgIDAuMiAgMC4xICAgMjU1MiAgMTIxNiB0dHkxICAgICBTcyAgIDAxOjMzICAg
MDowMCAvYmluL2xvZ2luIC0tICAgICAKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0dHlfdCAgICAgICBy
b290ICAgICAgMTYzMyAgMC4wICAwLjAgICAxNjY4ICAgNDkyIHR0eTIgICAgIFNzKyAgMDE6MzMg
ICAwOjAwIC9zYmluL2FnZXR0eSB0dHkyIDk2MDAKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0dHlfdCAg
ICAgICByb290ICAgICAgMTYzNyAgMC4wICAwLjAgICAxNjY4ICAgNDkyIHR0eTMgICAgIFNzKyAg
MDE6MzMgICAwOjAwIC9zYmluL2FnZXR0eSB0dHkzIDk2MDAKc3lzdGVtX3U6c3lzdGVtX3I6Z2V0
dHlfdCAgICAgICByb290ICAgICAgMTYzOCAgMC4wICAwLjAgICAxNjY4ICAgNDg4IHR0eTQgICAg
IFNzKyAgMDE6MzMgICAwOjAwIC9zYmluL2FnZXR0eSB0dHk0IDk2MDAKc3lzdGVtX3U6c3lzdGVt
X3I6Z2V0dHlfdCAgICAgICByb290ICAgICAgMTYzOSAgMC4wICAwLjAgICAxNjY4ICAgNDkyIHR0
eTUgICAgIFNzKyAgMDE6MzMgICAwOjAwIC9zYmluL2FnZXR0eSB0dHk1IDk2MDAKc3lzdGVtX3U6
c3lzdGVtX3I6Z2V0dHlfdCAgICAgICByb290ICAgICAgMTY0MSAgMC4wICAwLjAgICAxNjY4ICAg
NDk2IHR0eTYgICAgIFNzKyAgMDE6MzMgICAwOjAwIC9zYmluL2FnZXR0eSB0dHk2IDk2MDAKc3lz
dGVtX3U6c3lzdGVtX3I6aGFsZF90ICAgICAgICByb290ICAgICAgMTY0MiAgMC4wICAwLjAgICAz
MTk2ICAgOTQ0ID8gICAgICAgIFNOICAgMDE6MzMgICAwOjAwIC91c3IvbGliZXhlYy9oYWxkLWFk
ZG9uLWNwdWZyZXEKc3lzdGVtX3U6c3lzdGVtX3I6aGFsZF90ICAgICAgICBuYW1lICAgIDE2NDUg
IDAuMCAgMC4wICAgMjg0MCAgIDg3MiA/ICAgICAgICBTTiAgIDAxOjMzICAgMDowMCBoYWxkLWFk
ZG9uLWFjcGk6IGxpc3RlbmluZyBvbiBhY3BpIGtlcm5lbCBpbnRlcmZhY2UgL3Byb2MvYWNwaS9l
dmVudApzeXN0ZW1fdTpzeXN0ZW1fcjprZXJuZWxfdCAgICAgIHJvb3QgICAgICAxNjU5ICAwLjAg
IDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgUzwgICAwMTozMyAgIDA6MDAgW2thdWRpdGRdCm5h
bWU6c3lzYWRtX3I6c3lzYWRtX3QgICAgICAgICAgbmFtZSAgICAxNjYxICAwLjAgIDAuMSAgIDMw
OTIgIDE0OTYgdHR5MSAgICAgUyAgICAwMTozMyAgIDA6MDAgLWJhc2gKbmFtZTpzeXNhZG1fcjpz
eXNhZG1fdCAgICAgICAgICBuYW1lICAgICAxNjY2ICAwLjAgIDAuMSAgIDI5MTIgIDExMDggdHR5
MSAgICAgUysgICAwMTozMyAgIDA6MDAgL2Jpbi9zaCAvdXNyL2Jpbi9zdGFydHgKbmFtcjpzeXNh
ZG1fcjpzeXNhZG1fdCAgICAgICAgICBuYW1lICAgICAxNjgyICAwLjAgIDAuMCAgIDI5MzIgICA3
NTIgdHR5MSAgICAgUysgICAwMTozMyAgIDA6MDAgeGluaXQgL3Vzci9saWIvWDExL3hpbml0L3hp
bml0cmMgLS0gL3Vzci9iaW4vWCA6MCAtYXV0aCAvaG9tZS9uYW1lLy5zZXJ2ZXJhdXRoLjE2NjYK
bmFtZTpzeXNhZG1fcjp4c2VydmVyX3QgICAgICAgICByb290ICAgICAgMTY4MyAgNS4xICAxLjMg
IDE5MDA4IDE0MDQwIHR0eTcgICAgIFNzKyAgMDE6MzMgICAwOjAyIC91c3IvYmluL1ggOjAgLWF1
dGggL2hvbWUvbmFtZS8uc2VydmVyYXV0aC4xNjY2Cm5hbWU6c3lzYWRtX3I6c3lzYWRtX3QgICAg
ICAgICAgbmFtZSAgICAgIDE3MTAgIDAuNyAgMC40ICAgNjg4NCAgNDA4MCB0dHkxICAgICBTICAg
IDAxOjMzICAgMDowMCBmbHV4Ym94Cm5hbWU6c3lzYWRtX3I6c3lzYWRtX3QgICAgICAgICAgbmFt
ZSAgICAgMTczNCAgMC4xICAwLjEgICAzMzg4ICAxNTkyID8gICAgICAgIFNzICAgMDE6MzMgICAw
OjAwIGF0ZXJtCm5hbWU6c3lzYWRtX3I6c3lzYWRtX3QgICAgICAgICAgbmFtZSAgICAgMTczNSAg
MC4wICAwLjEgICAzMDkyICAxNDUyIHB0cy8wICAgIFNzICAgMDE6MzMgICAwOjAwIGJhc2gKbmFt
ZTpzeXNhZG1fcjpzeXNhZG1fdCAgICAgICAgICBuYW1lICAgICAxNzM3ICAwLjAgIDAuMCAgIDIx
NDQgICA4MjAgcHRzLzAgICAgUisgICAwMTozNCAgIDA6MDAgcHMgYXV4WgoK
--000e0cd18192743e6c04636ac3a6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
