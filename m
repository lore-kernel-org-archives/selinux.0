Subject: Another small issue on Debian
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 30 Nov 2005 16:52:51 +0100
Message-Id: <1133365971.8467.39.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Debian currently uses a "strict" policy, but uses "SELINUXTYPE=." and
has the sources in /etc/selinux/src, not /etc/selinux/strict/src
Since the Makefile I got has "strict" somewhere hardcoded in there, I
set up a symlink "strict -> ." causing the following violation:
avc:  denied  { read } for  pid=8075 comm="checkpolicy" name="strict"
dev=ida/c0d0p5 ino=49769 scontext=root:sysadm_r:checkpolicy_t
tcontext=system_u:object_r:selinux_config_t tclass=lnk_file

Any objections to allowing this?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
        The best things in life are free: Friendship and Love.       //\
  Wie kann ich wissen, was ich denke, bevor ich höre, was ich sage.  V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
