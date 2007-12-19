Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBJIHG0B023989
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 13:17:16 -0500
Received: from mu-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBJIHFPQ004728
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 18:17:16 GMT
Received: by mu-out-0910.google.com with SMTP id i10so4296132mue.5
        for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 10:17:15 -0800 (PST)
Message-ID: <cadfc0e40712191017x3ea7989bxa94a934aa195c980@mail.gmail.com>
Date: Wed, 19 Dec 2007 12:17:14 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: MLS newrole avcs and polyinstantiation avcs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm using newrole to run apps at level but am getting mls constraint
related avcs like:

type=AVC msg=audit(1198086275.274:1836): avc:  denied  { transition }
for  pid=4815 comm="newrole" path="/bin/bash" dev=dm-0 ino=14843920
scontext=user_u:user_r:newrole_t:s0
tcontext=user_u:user_r:user_t:s2:c0.c253,c255,c256 tclass=process

I have :
ifdef(`enable_mls',`
      mls_process_set_level(newrole_t)
')

 in my policy but it either isn't the right thing or isn't enough. Can
anyone help with this?

Also I have pam_namespace configured for newrole and am getting mls
constraint avcs related to relabeling directories, for example:

type=AVC msg=audit(1198086274.884:1793): avc:  denied  { relabelto }
for  pid=4815 comm="newrole" name="eb3ba083bd05d11d8c0e697ad725e391"
dev=dm-0 ino=35323932 scontext=user_u:user_r:newrole_t:s0
tcontext=user_u:object_r:user_home_t:s2:c0.c253,c255,c256 tclass=dir

I have :
files_poly_parent(user_home_t)
files_poly_member(user_home_t)

in my policy but ...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
