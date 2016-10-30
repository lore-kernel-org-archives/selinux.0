Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9UM5Sc0007800
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 18:05:28 -0400
Received: by mail-wm0-f44.google.com with SMTP id t79so20042276wmt.0
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 15:04:56 -0700 (PDT)
Received: from [192.168.0.14] (81-66-120-207.rev.numericable.fr.
 [81.66.120.207])
 by smtp.googlemail.com with ESMTPSA id au8sm26576622wjc.12.2016.10.30.15.04.53
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Oct 2016 15:04:53 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: secilc crashes on unknown permissions
To: selinux@tycho.nsa.gov
Message-ID: <39fb72d4-6135-3fb9-6671-6cbe8bd2a41b@m4x.org>
Date: Sun, 30 Oct 2016 23:04:52 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------0C12D849FAFC21D40FF89FCA"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------0C12D849FAFC21D40FF89FCA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

After the crashes I found by running AFL on secilc were fixed (thanks!),
I continued to run AFL. It found a new way to make secilc crash, using
an unknown permission with a classmap, like what is done with the policy
attached to this email.

This policy does not make secilc 2.6 crash but triggers a NULL pointer
dereference in __evaluate_classperms_list() (in cil_post.c) when using
secilc from the master branch. More precisely if I revert commits
1b3b36aeecf2 ("libsepol/cil: Use empty list for category expression
evaluated as empty") and da51020d6f33 ("libsepol/cil: Use an empty list
to represent an unknown permission"), secilc no longer crashes. But it
produces a file which makes tools like apol, sesearch... behaves in a
weird way:

    $ secilc secilc_crash_unknown_cm_perm.cil
    $ echo $?
    0
    $ sesearch -A policy.30
    [Errno 0] Error: 'policy.30'

I guess the internal structures of the generated policy get corrupted in
a way that the policy loader does not like (I have not yet spent time to
investigate where this "Errno 0 error" comes from).

Nicolas

--------------0C12D849FAFC21D40FF89FCA
Content-Type: text/x-selinux-cil;
 name="secilc_crash_unknown_cm_perm.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="secilc_crash_unknown_cm_perm.cil"

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
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

(classmap cm1 (mp1))
(classmapping cm1 mp1 (CLASS (PERM)))
(allow TYPE TYPE (cm1 (unknown)))

--------------0C12D849FAFC21D40FF89FCA--
