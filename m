Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i861R8rT019415
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 21:27:08 -0400 (EDT)
Received: from georgia.yamato.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i861QFia014021
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 01:26:17 GMT
Received: from e19f3n15.jp.ibm.com (d19relay02.sagamino.japan.ibm.com [9.189.5.62])
	by georgia.yamato.ibm.com (8.11.6p2-20030922/8.11.1) with ESMTP id i861R1a274476
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 10:27:01 +0900
Received: from D19ML102.sagamino.japan.ibm.com (d19av02.sagamino.japan.ibm.com [9.189.5.91])
	by e19f3n15.jp.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i861R0s2152142
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 10:27:01 +0900
Reply-To: 
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: SuSE 9.1 SELinux
From: Takuya Mishina <TMISHINA@jp.ibm.com>
Message-ID: <OF93C1DDD2.9FAF1403-ON49256F06.00517E1E-49256F07.0007F249@jp.ibm.com>
Date: Mon, 6 Sep 2004 10:26:58 +0900
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I've tried being enable SELinux on SuSE 9.1 personal edition, followings 
are the installation and configuration memo.
after this configuration, SELinux in console login mode (runlevel 3) is 
available. please use this memo for your information about SELinux on 
SuSE!



+ Install SuSE
  filesystem must be ext3 (not reiserfs). no limitation except for 
filesystem.

+ Install and upgrade RPM packages using YaST
   - checkpolicy
   - policycoreutils
   - policy-sources
   - other update packages (kernel, etc.)

+ make mountpoint /selinux
  # mkdir /selinux

  /selinux will be automatically mounted on boot (cf. /etc/init.d/boot).

+ modify /sbin/init 
  cf. http://www.nsa.gov/selinux/list-archive/0310/5617.cfm
  thanks, Russell!

+ edit policy
　add following into 
/security/selinux/src/policy/file_contexts/program/init.fc 

　/sbin/init.real               --      system_u:object_r:init_exec_t

+ modify PAM configurations
  add following into /etc/pam.d/sshd and /etc/pam.d/su

  session       required        pam_selinux.so

+ setuid to /usr/bin/newrole
  # chmod 4755 /usr/bin/newrole
  SuSE Linux newrole seems not to use PAM for authentication, so newrole 
must be able to read /etc/shadow. 


to enable SELinux, boot SuSE with kernel option "selinux=1".



---
Takuya MISHINA
IBM Research, Tokyo Research Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
