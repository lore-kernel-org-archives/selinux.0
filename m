Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2GKjGs3024785
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 15:45:17 -0500
Received: from kokytos.rz.ifi.lmu.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2GKhc3h002897
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 20:43:39 GMT
Received: from hydrogenium.cip.ifi.lmu.de (hydrogenium.cip.ifi.lmu.de [141.84.214.74])
	by kokytos.rz.ifi.lmu.de (Postfix) with ESMTP id 811344367F
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 21:45:12 +0100 (CET)
Date: Thu, 16 Mar 2006 21:45:12 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Bug in the semanage user management code or genhomedircon?
Message-ID: <20060316204512.GB30979@hydrogenium.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to set up an Ubuntu SELinux system and have a problem I don't
really understand. The system is up-to-date (just compiled all the
libraries from the new release, the policy is two days old).

I think the following command sequence illustrates my problem:
# ls -dZ /root
drwxr-xr-x  root     root     system_u:object_r:default_t:s0   /root
# semanage login -l

Login Name                SELinux User              MLS/MCS Range

# semanage user -l

                MLS/       MLS/
SELinux User    MCS Level  MCS Range                      SELinux Roles

root            s0         s0-s0:c0.c255                  system_r sysadm_r staff_r
staff_u         s0         s0-s0:c0.c255                  sysadm_r staff_r
sysadm_u        s0         s0-s0:c0.c255                  sysadm_r
system_u        s0         s0-s0:c0.c255                  system_r
user_u          s0         s0                             user_r
# semanage login -a -s sysadm_u root
root@warschau:~/debian# semanage login -l

Login Name                SELinux User              MLS/MCS Range

root                      sysadm_u                  s0
# restorecon -v /root/
restorecon reset /root context system_u:object_r:default_t:s0->sysadm_u:object_r:user_home_dir_t:s0

Notice the last line. I cannot get /root to be of type
sysadm_home_dir_t (It doesn't change if I do "semanage login -a -s
root root" instead).

What am I doing wrong?

Thomas

PS: The semanage manpage really needs some examples. Now if I understood
the program I could write some :-(


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
