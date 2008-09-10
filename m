Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8AJWW6X028682
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 15:32:32 -0400
Received: from mail-gx0-f12.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8AJWW24020080
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 19:32:32 GMT
Received: by gxk5 with SMTP id 5so14435111gxk.18
        for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 12:32:32 -0700 (PDT)
Message-ID: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
Date: Wed, 10 Sep 2008 12:32:31 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: ssh issue with latest policy
Cc: Hong <kindloaf@gmail.com>, tresys <refpolicy@oss.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hong,
I cant seem to locate the post you sent a few days ago
about logging into ssh. anyways I finally got around to logging into
my machines with both the latest kernel and refpolicy;
there was difficulty due to having /etc/host and /etc/sysctl.conf
variables in these files preventing me from logging in.
So with that in mind check and make sure those files
are cleared of anything that might cause an error.
As for the policy itself they were both in permissive mode
via boot param, so having /etc/selinux/config in enforcing
didnt cause an ubstruction for me.
hope this helps.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
