Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o29I1tYU026340
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 13:01:55 -0500
Received: from mail-iw0-f193.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o29I1YqP021597
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 18:01:35 GMT
Received: by iwn31 with SMTP id 31so6553705iwn.30
        for <selinux@tycho.nsa.gov>; Tue, 09 Mar 2010 10:01:50 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 9 Mar 2010 10:01:46 -0800
Message-ID: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
Subject: what to do: libsemanage.get_home_dirs:
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

with the latest policy on open suse 11.2
I'm seeing this after building the policy:
libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its
parent directory conflicts with a file context already specified in
the policy.  This usually indicates an incorrectly defined system
account.  If it is a system account please make sure its uid is less
than 1000 or its login shell is /sbin/nologin.

with using an older policy on this system, I never saw this.

what to do?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
