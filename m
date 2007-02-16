Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1G5Yjmb029087
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 00:34:45 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1G5Zpqq004913
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 05:36:00 GMT
Received: by nz-out-0506.google.com with SMTP id z3so724624nzf
        for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2007 21:35:59 -0800 (PST)
Message-ID: <45D542B7.3070504@kaigai.gr.jp>
Date: Fri, 16 Feb 2007 14:35:51 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jbrindle@tresys.com, russell@coker.com.au
Subject: [RFC] Security design of SE-PostgreSQL(3/3)
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In recent days, I'm making progress in development of SE-PostgreSQL.
I found some issues on the work.
The followings are the issues and solutions which I planed to take.
I want any comment, idea and suggestion.


3. Database objects which are not enumerated in security_classes

In previous discussion, we didn't considered about some of database objects
such as database user, view, trigger and so on.
Some of them contains PostgreSQL specific object type.
I believe the security design of SELinux is not PostgreSQL specific is better,
so I want to add some new access vectors for common concepts of relational
database and three new access vectors (xxxx_misc) for any other database
objects as follows:

 class database
 inherits database
 {
     access
+    load_module
+    associate
+    create_misc
+    alter_misc
+    drop_misc
+    create_user
+    alter_user
+    drop_user
+    create_view
+    alter_view
+    drop_view
+    create_trigger
+    alter_trigger
+    drop_trigger
 }

Or, some new object classes are necessary/desirable?
I'm worrying about it will be unbounded and never-ending.


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
