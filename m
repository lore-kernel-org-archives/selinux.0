Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4GCCQgA018593
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 08:12:26 -0400 (EDT)
Received: from web60425.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4GC8rhq014888
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 12:08:53 GMT
Message-ID: <20050516120907.86410.qmail@web60425.mail.yahoo.com>
Date: Mon, 16 May 2005 05:09:07 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: bash: cd: /etc/selinux/strict/users/: No such file or directory
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Folks;
  This (the subject line) is immedaiately after doing a fresh load of policy
1.22 on a Knoppix (Debian derived) system.

  The home.dirs file was messed up; and I had just created a
/etc/default/useradd file. a 'make reload' didn't fix the home.dir problem; so
I deleted the entire /etc/selinux/strict subtree and reran the entire load
process.

  I need to know what parts of the structure are needed to be made by hand?

------------
root@lppda:/etc/selinux/src# make load
install -m 644 file_contexts/file_contexts
/etc/selinux/strict/contexts/files/fi
le_contexts
install -m 644 file_contexts/homedir_template
/etc/selinux/strict/contexts/files
/homedir_template
mkdir -p /etc/selinux/strict/policy
/usr/bin/checkpolicy  -o /etc/selinux/strict/policy/policy.19 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  3 users, 5 roles, 334 types, 18 bools
security:  54 classes, 20262 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 19) to
/etc/selinu
x/strict/policy/policy.19
/usr/bin/checkpolicy -c 18 -o /etc/selinux/strict/policy/policy.18 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  3 users, 5 roles, 334 types, 18 bools
security:  54 classes, 20262 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 18) to
/etc/selinu
x/strict/policy/policy.18
/usr/sbin/load_policy /etc/selinux/strict/policy/policy.19
sepol_genusers: Can't load system.users:  No such file or directory
/usr/sbin/load_policy:  Error while setting user configuration from
/etc/selinux
/strict/users//{local.users,system.users}:  No such file or directory
touch tmp/load
root@lppda:/etc/selinux/src# ls



Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
