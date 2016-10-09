Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u999gmGZ009309
 for <selinux@tycho.nsa.gov>; Sun, 9 Oct 2016 05:42:48 -0400
Received: by mail-wm0-f42.google.com with SMTP id b201so120140994wmb.0
 for <selinux@tycho.nsa.gov>; Sun, 09 Oct 2016 02:42:42 -0700 (PDT)
Received: from ?IPv6:2a02:8428:4da:9800:c476:6880:6772:3cfd?
 (2a02-8428-04da-9800-c476-6880-6772-3cfd.rev.sfr.net.
 [2a02:8428:4da:9800:c476:6880:6772:3cfd])
 by smtp.googlemail.com with ESMTPSA id ct1sm655492wjd.13.2016.10.09.02.42.39
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Oct 2016 02:42:39 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: CIL policies which make secilc crash
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <4fe9df1a-01e5-b199-1bb4-329e8c364fc2@m4x.org>
Date: Sun, 9 Oct 2016 11:42:38 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------11F5F21E538CC4A96854A7D3"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------11F5F21E538CC4A96854A7D3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

When fuzzing secilc with AFL, I got some files which made the CIL
compiler crash. To understand better the conditions which led to the
crash, I trimmed them down afterwards. This led to the 6 files attached
to this email. On my system the crashes still exist with the 2.6-rc2
release.

I won't have time in the following days to perform the debugging which
is needed to fix these crashes correctly, so feel free to do this and
submit patches using these files.

By the way, from what I have seen so far, no policy which makes secilc
crash is valid, and the bugs mainly lie in the way errors are
detected/handled.

Thanks,
Nicolas

--------------11F5F21E538CC4A96854A7D3
Content-Type: text/x-selinux-cil;
 name="secilc-cat_in_cats.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc-cat_in_cats.cil"

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)

(category c0)
(category c1)
(categoryorder (c0 c1))

(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (range c1 c0)) ; Invalid range
;(sensitivitycategory SENS (not (all)))

(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (c0))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

(levelrange LH ((SENS c0) (SENS c0)))

--------------11F5F21E538CC4A96854A7D3
Content-Type: text/x-selinux-cil;
 name="secilc-classpermissionset-and.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc-classpermissionset-and.cil"

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

(classpermission CPERM)
(classpermissionset CPERM (CLASS (and unknow PERM)))

--------------11F5F21E538CC4A96854A7D3
Content-Type: text/x-selinux-cil;
 name="secilc-empty-class.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc-empty-class.cil"

(class C (()))

--------------11F5F21E538CC4A96854A7D3
Content-Type: text/x-selinux-cil;
 name="secilc-sensitivityaliasactual-same.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc-sensitivityaliasactual-same.cil"

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

(sensitivityaliasactual SENS SENS)

--------------11F5F21E538CC4A96854A7D3
Content-Type: text/x-selinux-cil;
 name="secilc-sidcontext-invalid-catrange.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc-sidcontext-invalid-catrange.cil"

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT0)
(category CAT1)
(categoryorder (CAT0 CAT1))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT0 CAT1))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT0))))

(mls true)
(level low (SENS))
(sidcontext SID (USER ROLE TYPE (low (SENS (range CAT1 CAT0)))))

--------------11F5F21E538CC4A96854A7D3
Content-Type: text/x-selinux-cil;
 name="secilc-typebounds.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc-typebounds.cil"

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

(type t1)
(typeattribute ta1)
(typeattributeset ta1 t1)
(type t2)
(typebounds t2 ta1)

--------------11F5F21E538CC4A96854A7D3--
