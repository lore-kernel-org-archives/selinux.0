Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UBgqrT026369
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 07:42:52 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6UBgoAP007230
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 11:42:50 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/Debian-5) with ESMTP id i6UBgkvk000642
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 13:42:47 +0200
Subject: Building SE-ssh. Result: fakeroot: Permission denied
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1091187766.18595.153.camel@debby>
Mime-Version: 1.0
Date: Fri, 30 Jul 2004 13:42:46 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All

I can't build ssh as *non-root* from SE sources from
http://selinux.lemuria.org/newselinux/ssh/

I get a "permission denied" if I try to do this.

ls -l `which gcc`
lrwxrwxrwx  1 root root 8 Jul 28 00:24 /usr/bin/gcc -> gcc-2.95

No problem to build non-SE-sources, patched with SE-files like that:
./ssh.debiansources.sh > ssh.debiansources.log

Here's ssh.debiansources.sh:
######################################### 
#!/bin/sh -x
/bin/sh -n $HOME/ssh.debiansources.sh && \
cd $HOME/test/ && \
rm -rf * && \
apt-get source openssh && \
cd openssh-3.8.1p1/ && \
cp $HOME/russellpackages/ssh/openssh-selinux.patch.gz* . && \
gpg --verify openssh-selinux.patch.gz.sign openssh-selinux.patch.gz && \
gzip -cd openssh-selinux.patch.gz | patch -p1 && \
autoconf && \
fakeroot debian/rules binary
#########################################

The problem with the .debs resulting from the script above is that
they're standard, non-SE packages, IINM:
openssh-client-udeb_3.8.1p1-7_powerpc.udeb
openssh-server-udeb_3.8.1p1-7_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-7_powerpc.deb
ssh_3.8.1p1-7_powerpc.deb 


Second try, this time using SE sources:

I run the following ssh.getandbuild.sh script for the SE-build like
that: 
./ssh.getandbuild.sh &> ssh.log

ssh.getandbuild.sh:
#######################################################
#!/bin/sh -x
/bin/sh -n $HOME/ssh.getandbuild.sh && \
cd $HOME/test/ && \
rm -rf * && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1.orig.tar.gz && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz.sign && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1-7.se1.diff.gz && \
tar -xzvf *\.tar.gz && \
cd openssh-3.8.1p1/ && \
cp ../openssh_3.8.1p1-7.se1.diff.gz . && \
gzip -cd  openssh_3.8.1p1-7.se1.diff.gz | patch -p1 && \
autoconf && \
fakeroot debian/rules binary
####################################################

The script above, according to the ssh.log log file, ends like that:

+ autoconf
+ fakeroot debian/rules binary
/usr/bin/fakeroot: line 146: debian/rules: Permission denied


ssh.log, in nearly all its beauty:

################################
+ /bin/sh -n /home/shorty/ssh.getandbuild.sh
+ cd /home/shorty/test/
+ rm -rf openssh-3.8.1p1 openssh-client-udeb_3.8.1p1-7_powerpc.udeb openssh-server-udeb_3.8.1p1-7_powerpc.udeb openssh_3.8.1p1-7.diff.gz openssh_3.8.1p1-7.dsc openssh_3.8.1p1.orig.tar.gz ssh-askpass-gnome_3.8.1p1-7_powerpc.deb ssh_3.8.1p1-7_powerpc.deb
+ curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1.orig.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0  777k    0  1091    0     0    204      0  1:05:01  0:00:05  1:04:56   204
 11  777k   11 93571    0     0  15153      0  0:00:52  0:00:06  0:00:46  107k
 27  777k   27  210k    0     0  30104      0  0:00:26  0:00:07  0:00:19  113k
 42  777k   42  330k    0     0  41400      0  0:00:19  0:00:08  0:00:11  115k
 57  777k   57  449k    0     0  50226      0  0:00:15  0:00:09  0:00:06  116k
 73  777k   73  569k    0     0  57325      0  0:00:13  0:00:10  0:00:03  117k
 88  777k   88  689k    0     0  63154      0  0:00:12  0:00:11  0:00:01  119k
100  777k  100  777k    0     0  66833      0  0:00:11  0:00:11 --:--:--  119k
+ curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

 50  2005   50  1076    0     0   3375      0 --:--:-- --:--:-- --:--:--  3375
100  2005  100  2005    0     0   6203      0 --:--:-- --:--:-- --:--:--  226k
+ curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz.sign
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

100   265  100   265    0     0    839      0 --:--:-- --:--:-- --:--:--   839
100   265  100   265    0     0    828      0 --:--:-- --:--:-- --:--:--     0
+ curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1-7.se1.diff.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0  226k    0  1098    0     0   3481      0  0:01:06 --:--:--  0:01:06  3481
  8  226k    8 18778    0     0  33838      0  0:00:06 --:--:--  0:00:06 73666
 60  226k   60  137k    0     0  90851      0  0:00:02  0:00:01  0:00:01  110k
100  226k  100  226k    0     0    98k      0  0:00:02  0:00:02 --:--:--  113k
+ tar -xzvf openssh_3.8.1p1.orig.tar.gz
openssh-3.8.1p1/
openssh-3.8.1p1/.cvsignore

    [ .... removed ... ]

openssh-3.8.1p1/ssh-keysign.0
openssh-3.8.1p1/sshd_config.0
openssh-3.8.1p1/ssh_config.0
openssh-3.8.1p1/stamp-h.in
+ cd openssh-3.8.1p1/
+ cp ../openssh_3.8.1p1-7.se1.diff.gz .
+ gzip -cd openssh_3.8.1p1-7.se1.diff.gz
+ patch -p1
patching file .cvsignore
patching file Makefile.in
patching file auth-pam.c
patching file clientloop.c
patching file config.guess
patching file config.sub
patching file configure.ac
patching file entropy.c
patching file log.c
patching file log.h
patching file monitor_fdpass.c
patching file packet.c
patching file packet.h
patching file readconf.c
patching file readconf.h
patching file serverloop.c
patching file session.c
patching file ssh-keyscan.c
patching file ssh.1
patching file ssh.c
patching file ssh_config
patching file ssh_config.5
patching file sshconnect.c
patching file sshd.8
patching file sshd.c
patching file sshpty.c
patching file version.h
patching file contrib/ssh-copy-id
patching file contrib/redhat/sshd.init
patching file contrib/.cvsignore
patching file scard/.cvsignore
patching file config.h.in
patching file configure
patching file debian/po/it.po
patching file debian/po/POTFILES.in
patching file debian/po/da.po
patching file debian/po/de.po
patching file debian/po/es.po
patching file debian/po/fr.po
patching file debian/po/ja.po
patching file debian/po/nl.po
patching file debian/po/pl.po
patching file debian/po/pt_BR.po
patching file debian/po/ru.po
patching file debian/po/templates.pot
patching file debian/po/ca.po
patching file debian/po/el.po
patching file debian/po/tr.po
patching file debian/po/cs.po
patching file debian/po/zh_CN.po
patching file debian/.cvsignore
patching file debian/README.Debian
patching file debian/changelog
patching file debian/conffiles
patching file debian/config
patching file debian/control
patching file debian/copyright.head
patching file debian/dirs
patching file debian/gnome-ssh-askpass.1
patching file debian/init
patching file debian/moduli.5
patching file debian/postinst
patching file debian/postrm
patching file debian/preinst
patching file debian/prerm
patching file debian/rules
patching file debian/ssh-argv0
patching file debian/ssh-argv0.1
patching file debian/ssh-askpass-gnome.copyright
patching file debian/ssh-askpass-gnome.dirs
patching file debian/ssh-askpass-gnome.postinst
patching file debian/ssh-askpass-gnome.prerm
patching file debian/ssh.default
patching file debian/ssh.pam
patching file debian/templates.master
patching file debian/postrm.debhelper
patching file debian/substvars
patching file debian/openssh-client-udeb.isinstallable
patching file debian/openssh-client-udeb.dirs
patching file debian/templates
patching file debian/openssh-server-udeb.dirs
patching file debian/ssh-askpass-gnome.desktop
patching file debian/ssh-askpass-gnome.png.uue
+ autoconf
+ fakeroot debian/rules binary
/usr/bin/fakeroot: line 146: debian/rules: Permission denied

################################################################

Was it my mistake?

Thanks in anticipation
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
