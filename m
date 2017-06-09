MIME-Version: 1.0
In-Reply-To: <1497012308.26846.1.camel@tycho.nsa.gov>
References: <3bc76902-e183-ef43-7528-901e579d1031@debian.org>
 <1497012308.26846.1.camel@tycho.nsa.gov>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 9 Jun 2017 14:52:15 +0200
Message-ID: <CAJ2a_DdLA+VhgO+7aSU_NmvDCiweaU_=As7hzuLorQdhid28cA@mail.gmail.com>
Subject: Re: boot failure due to ambiguous SELinux config
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>,
 864479-forwarded@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-06-09 14:45 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> Kernel version and config, particularly the CONFIG_SECURITY_SELINUX
> ones?  And are you using any other SELinux-related kernel command line
> options (e.g. enforcing=, selinux=)?

standard Debian sid kernel: Linux server02 4.9.0-3-amd64 #1 SMP Debian
4.9.30-1 (2017-06-04) x86_64 GNU/Linux

$ grep -i selinux /boot/config-4.9.0-3-amd64
CONFIG_SECURITY_SELINUX=y
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
# CONFIG_DEFAULT_SECURITY_SELINUX is not set

$ cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.9.0-3-amd64
root=UUID=1e528afb-83e1-489e-b2f7-1ad1d73d145c ro security=selinux
nomodeset elevator=noop
