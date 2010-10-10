Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9A3Q1L1018093
	for <selinux@tycho.nsa.gov>; Sat, 9 Oct 2010 23:26:02 -0400
Received: from mail-qy0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9A3Q1Kd019037
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2010 03:26:01 GMT
Received: by qyk1 with SMTP id 1so1467808qyk.12
        for <selinux@tycho.nsa.gov>; Sat, 09 Oct 2010 20:26:01 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 9 Oct 2010 20:26:00 -0700
Message-ID: <AANLkTi=SPJgXto8wjhvBwRbM7ujeTPGjfLj21DjtSHoU@mail.gmail.com>
Subject: policycoreutils breaks when installing
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I seem to be hitting this with userspace tools from git and the latest
stable release on opensuse 11.4:

0 translated messages, 254 untranslated messages.
msgfmt --statistics --verbose -o et.mo et.po
0 translated messages, 254 untranslated messages.
/usr/bin/install: cannot stat `et.mo': No such file or directory
removed `/usr/share/locale/bn_IN/LC_MESSAGES/policycoreutils.mo'
`bn_IN.mo' -> `/usr/share/locale/bn_IN/LC_MESSAGES/policycoreutils.mo'
removed `/usr/share/locale/sk/LC_MESSAGES/policycoreutils.mo'
`sk.mo' -> `/usr/share/locale/sk/LC_MESSAGES/policycoreutils.mo'

<------ cut -------->

`ru.mo' -> `/usr/share/locale/ru/LC_MESSAGES/policycoreutils.mo'
removed `/usr/share/locale/pt_BR/LC_MESSAGES/policycoreutils.mo'
`pt_BR.mo' -> `/usr/share/locale/pt_BR/LC_MESSAGES/policycoreutils.mo'
/usr/bin/install: cannot stat `gl.mo': No such file or directory
removed `/usr/share/locale/my/LC_MESSAGES/policycoreutils.mo'
`my.mo' -> `/usr/share/locale/my/LC_MESSAGES/policycoreutils.mo'
removed `/usr/share/locale/ko/LC_MESSAGES/policycoreutils.mo'


<----- cut ------->

`te.mo' -> `/usr/share/locale/te/LC_MESSAGES/policycoreutils.mo'
removed `/usr/share/locale/sq/LC_MESSAGES/policycoreutils.mo'
`sq.mo' -> `/usr/share/locale/sq/LC_MESSAGES/policycoreutils.mo'
/usr/bin/install: cannot stat `id.mo': No such file or directory
make[2]: [install] Error 1 (ignored)
make[2]: Leaving directory `/home/justin/kernel/selinux/policycoreutils/po'
make[2]: Entering directory
`/home/justin/kernel/selinux/policycoreutils/restorecond'
[ -d /usr/share/man/man8 ] || mkdir -p /usr/share/man/man8

I just ignored it to keep going, but when building through build
service not sure what to change in the *.spec
let me know if I need to try out anything.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
