Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1G5YbOn029076
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 00:34:37 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1G5Zpqp004913
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 05:35:52 GMT
Received: by nz-out-0506.google.com with SMTP id z3so724624nzf
        for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2007 21:35:51 -0800 (PST)
Message-ID: <45D542AF.1030108@kaigai.gr.jp>
Date: Fri, 16 Feb 2007 14:35:43 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jbrindle@tresys.com, russell@coker.com.au
Subject: [RFC] Security design of SE-PostgreSQL (2/3)
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In recent days, I'm making progress in development of SE-PostgreSQL.
I found some issues on the work.
The followings are the issues and solutions which I planed to take.
I want any comment, idea and suggestion.


2. about Loadable module

PostgreSQL allowed to load dynamic link library.
It has a possibility to mess up the access control of SE-PostgreSQL no need
to say, so we have to restrict loading them by the security policy.

I have an idea to add the following access vector for the purpose.
  1. allow (context of client)   (context of database)   database:load_module;
  2. allow (context of database) (context of shlib file) database:associate;

The second is a mimic of 'filesystem:associate'.

You can obtain the latest SE-PostgreSQL source code from:
    http://code.google.com/p/sepgsql/source
and the sample security policy is here:
    http://www.kaigai.gr.jp/pub/selinux-policy-2.5.2-5.sepgsql.src.rpm

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
