Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5MFrdB9009074
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 11:53:39 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5MFtHCP010865
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 15:55:17 GMT
Received: by gwj18 with SMTP id 18so2080250gwj.12
        for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 08:53:38 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 22 Jun 2010 08:53:37 -0700
Message-ID: <AANLkTikAhExdRILzInlYswXnAFbJsSGec43O7p2VcaEe@mail.gmail.com>
Subject: selinux_required option given and selinux is disabled
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

playing around with pam_namespace I seem to at a crux with trying to
figure out how to use require_selinux in pam.d/login with pam_namespace

heres what I see:

pam_selinux(login:session): Open Session
pam_unix(login:session): session opened for user name by LOGIN(uid=0)
pam_selinux(login:session): Open Session
pam_selinux(login:session): Username= name SELinux User = name Level= s0
pam_selinux(login:session): Security Context name:staff_r:staff_t:s0 Assigned
pam_selinux(login:session): set name security context to name:staff_r:staff_t:s0
pam_selinux(login:session): Key Creation Context
name:staff_r:staff_t:s0 Assigned
pam_selinux(login:session): set name key creation context to
name:staff_r:staff_t:s0
pam_namespace(login:session): selinux_required option given and
selinux is disabled
Cannot make/remove an entry for the specified session

did I miss something with this?


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
