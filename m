Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q85Fk2GK024214
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2012 11:46:02 -0400
Received: by obbwd18 with SMTP id wd18so542689obb.12
        for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2012 08:46:00 -0700 (PDT)
From: Joe Nall <joe@nall.com>
Content-Type: text/plain; charset=us-ascii
Subject: domain_kill_all_domains in login programs
Message-Id: <7C0BFC34-B6A3-4B7A-BD9F-7E3684C79B49@nall.com>
Date: Wed, 5 Sep 2012 10:45:58 -0500
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is a domain_kill_all_domains in auth_login_pgm_domain that allows sshd and other login programs to send sigkill to auditd and other system processes that were probably not intended.

For auditd, I can create domain_kill_all_domains_except and put auditd in the exception list. This still leaves processes that use auth_login_pgm_domain with the ability to kill many unrelated system processes.

Another approach is to allow login programs to only kill programs with an attribute like userdomain.

Thoughts?

joe

grep through RH policy, refpolicy is similar

find . -name \*.if -exec grep -H auth_login_pgm_domain {} \;
./policy/modules/system/authlogin.if:interface(`auth_login_pgm_domain',`
./policy/modules/services/ssh.if:	auth_login_pgm_domain($1_t)

find . -name \*.te -exec grep -H auth_login_pgm_domain {} \;
./policy/modules/system/locallogin.te:auth_login_pgm_domain(local_login_t)
./policy/modules/services/xserver.te:auth_login_pgm_domain(xdm_t)
./policy/modules/services/rshd.te:auth_login_pgm_domain(rshd_t)
./policy/modules/services/rlogin.te:auth_login_pgm_domain(rlogind_t)
./policy/modules/services/remotelogin.te:auth_login_pgm_domain(remote_login_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
