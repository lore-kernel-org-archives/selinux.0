Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71DuMrT007079
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:56:22 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71DuK0x021248
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 13:56:20 GMT
Subject: Re: [Fwd: Re: Building SE-ssh. Result: fakeroot: Permission denied]
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>,
   Erich Schubert <erich@debian.org>, Colin Walters <walters@verbum.org>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
In-Reply-To: <1091278744.1295.40.camel@debby>
References: <1091278744.1295.40.camel@debby>
Content-Type: text/plain
Message-Id: <1091368566.1295.213.camel@debby>
Mime-Version: 1.0
Date: Sun, 01 Aug 2004 15:56:07 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-07-31 at 14:59, Wolfgang Pfeiffer wrote:

                   [ ... ]

> 
> Tomorrow, Sunday, I will try to re-establish conditions for a failing
> se-openssh build, i.e. I will try to first uninstall
> ecos, ecosconfig, libwxgtk2.4
> again and then rebuild ssh: the stock debian one and the other one
> patched for SE-Linux, logging both builts, if possible --- I hope things
> will become clear by that.

           [ ... ]

I'm stumped: Today the builds worked without
ecos, ecosconfig and libwxgtk2.4 being installed:

# apt-get remove --purge ecos ecosconfig libwxgtk2.4
Reading Package Lists... Done
Building Dependency Tree... Done
The following packages will be REMOVED:
  ecos* ecosconfig* libwxgtk2.4*
0 upgraded, 0 newly installed, 3 to remove and 124 not upgraded.
Need to get 0B of archives.
After unpacking 94.3MB disk space will be freed.
Do you want to continue? [Y/n] Y
(Reading database ... 136765 files and directories currently installed.)
Removing ecos ...
Removing ecosconfig ...
Purging configuration files for ecosconfig ...
Removing libwxgtk2.4 ...

$ locate ansi.h
/usr/src/ecos/packages/net/common/v2_0/include/machine/ansi.h
shorty@ 14:26:04:$ ls /usr/src/ecos/packages/net/common/v2_0/include/machine/ansi.h
ls: /usr/src/ecos/packages/net/common/v2_0/include/machine/ansi.h: No such file or directory

:# apt-get build-dep openssh
Reading Package Lists... Done
Building Dependency Tree... Done
0 upgraded, 0 newly installed, 0 to remove and 124 not upgraded.

# ll `which gcc`
lrwxrwxrwx  1 root root 8 Jul 30 16:48 /usr/bin/gcc -> gcc-2.95

Then AFAIKS, successfully building a default Debian ssh package with
this script I called
ssh-default-debian.getandbuild.sh:

###############################################
#!/bin/sh -x
/bin/sh -n $HOME/ssh-default-debian.getandbuild.sh && \
cd $HOME/ssh-default-debian.getandbuild/ && \
rm -rf * && \
fakeroot apt-get source --compile openssh
##############################################

I ran the latter like that:
./ssh-default-debian.getandbuild.sh &> ssh-default-debian.getandbuild.log.txt

(during the build I slightly hit the desk where the computer did the
compile: I didn't repeat the above compile for that ... )

Here's what I got:

:$ ls -R ssh-default-debian.getandbuild/ | egrep '(\.udeb|\.deb)$'
openssh-client-udeb_3.8.1p1-8_powerpc.udeb
openssh-server-udeb_3.8.1p1-8_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-8_powerpc.deb
ssh_3.8.1p1-8_powerpc.deb

The log for the latter build is on
<http://www.geocities.com/wolfgangpfeiffer/ssh-default-debian.getandbuild.log.txt>


Now the SE-build:

With the sources from http://www.coker.com.au/newselinux/ repositories
it worked like a charm.
Here's the script ("ssh-SE.getandbuild.sh") I used:

######################################
#!/bin/sh -x
/bin/sh -n $HOME/ssh-SE.getandbuild.sh && \
cd $HOME/ssh-SE.getandbuild/ && \
rm -rf * && \
curl -f -O http://www.coker.com.au/newselinux/ssh/openssh_3.8.1p1.orig.tar.gz && \
curl -f -O http://www.coker.com.au/newselinux/ssh/openssh-selinux.patch.gz && \
curl -f -O http://www.coker.com.au/newselinux/ssh/openssh-selinux.patch.gz.sign && \
curl -f -O http://www.coker.com.au/newselinux/ssh/openssh_3.8.1p1-7.se1.diff.gz && \
tar -xzvf *\.tar.gz && \
cd openssh-3.8.1p1/ && \
cp ../openssh_3.8.1p1-7.se1.diff.gz . && \
gzip -cd  openssh_3.8.1p1-7.se1.diff.gz | patch -p1 && \
chmod +x debian/rules && \
autoconf && \
fakeroot debian/rules binary
###########################################

I ran the latter like that:
./ssh-SE.getandbuild.sh &> ssh-SE.getandbuild.sh.log.txt

$ ls -R ssh-SE.getandbuild/ | egrep '(\.udeb|\.deb)$'
openssh-client-udeb_3.8.1p1-7.se1_powerpc.udeb
openssh-server-udeb_3.8.1p1-7.se1_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-7.se1_powerpc.deb
ssh_3.8.1p1-7.se1_powerpc.deb

The log for the build is here
<http://www.geocities.com/wolfgangpfeiffer/ssh-SE.getandbuild.sh.log.txt>


Now the build with the sources from
<http://selinux.lemuria.org/newselinux/ssh/>

Here's the script ("ssh-SE-lemuria.getandbuild.sh") that I ran
like that:
./ssh-SE-lemuria.getandbuild.sh &> ssh-SE-lemuria.getandbuild.log.txt

ssh-SE-lemuria.getandbuild.sh:
######################################################
#!/bin/sh -x
/bin/sh -n $HOME/ssh-SE-lemuria.getandbuild.sh && \
cd $HOME/ssh-SE-lemuria.getandbuild/ && \
rm -rf * && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1.orig.tar.gz && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh-selinux.patch.gz.sign && \
curl -f -O http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1-7.se1.diff.gz && \
tar -xzvf *\.tar.gz && \
cd openssh-3.8.1p1/ && \
cp ../openssh_3.8.1p1-7.se1.diff.gz . && \
gzip -cd  openssh_3.8.1p1-7.se1.diff.gz | patch -p1 && \
chmod +x debian/rules && \
autoconf && \
fakeroot debian/rules binary
######################################################

This last build also worked, IINM:

$ ls -R ssh-SE-lemuria.getandbuild/ | egrep '(\.udeb|\.deb)$'
openssh-client-udeb_3.8.1p1-7.se1_powerpc.udeb
openssh-server-udeb_3.8.1p1-7.se1_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-7.se1_powerpc.deb
ssh_3.8.1p1-7.se1_powerpc.deb

log:
<http://www.geocities.com/wolfgangpfeiffer/ssh-SE-lemuria.getandbuild.log.txt>

Best Regards
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
