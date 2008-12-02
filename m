Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB21keP8022484
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 20:46:40 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB21ke7j012815
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2008 01:46:40 GMT
Received: by wa-out-1112.google.com with SMTP id j5so1364344wah.18
        for <selinux@tycho.nsa.gov>; Mon, 01 Dec 2008 17:46:39 -0800 (PST)
Subject: ERROR 'syntax error' at token 'typeattribute'
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: SE Linux <selinux@tycho.nsa.gov>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 17:46:36 -0800
Message-Id: <1228182396.4021.7.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After spending a few days trying
to load the latest refpolicy,I decided to
do a git-pull, so after loading everything
seems pretty good, except I now receive a 
syntax error when compiling the refpolicy

policy/modules/apps/yam.te":11:ERROR 'syntax error' at token
'typeattribute' on line 2615741:
#line 11
        typeattribute yam_t application_domain_type;
checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.23] Error 1

this error comes from the latest svn,
nothing like this all day, just after git-pull.
If I use the stable tar ball no issues.

the latest pull is 2.6.28-rc6-00209-g6a12141


-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
