Subject: Re: ext3 security labels missing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
References: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 09:14:27 -0500
Message-Id: <1235139267.6285.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-19 at 23:04 -0800, Justin Mattock wrote:
> I've a strange issue.
> with my experimental learning machine(LFS)
> I'm able to load the policy etc.. but have no labels
> on my files.(just a question mark);
> 
> 
> ls -lZ shows
> 
> drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
> drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
> lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
> drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
> drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
> drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
> drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
> drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
> drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
> drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
> drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
> dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
> drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
> drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
> drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
> drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
> drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
> drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
> drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
> drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
> drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
> lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
> /boot/vmlinuz-2.6.29-rc4
> 
> if I do a id -Z I get:
> id: --context (-Z) works only on an SELinux-enabled kernel
> (but it is enabled in the kernel)

sestatus shows what?

To be fully "enabled" as far as userspace is concerned, SELinux has to
be:
- enabled in your kernel build,
- enabled at boot,
- policy has to be loaded

grep SELINUX .config
cat /etc/selinux/config
dmesg | grep SELinux

> >From looking back, I enabled as much as possible in any app/lib I was compiling
> that provided selinux support.(libc,xserver,hal,dbus, etc..);
> But could be missing an important app/lib that might make the security labels
> give the proper label. by chance if anybody had experienced this and/or knows
> what might be going on,(would be really appreciated).
> 
> regards;
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
