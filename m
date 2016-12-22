Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBMChJVa011264
 for <selinux@tycho.nsa.gov>; Thu, 22 Dec 2016 07:43:19 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A43D5C05680F
 for <selinux@tycho.nsa.gov>; Thu, 22 Dec 2016 12:43:17 +0000 (UTC)
Received: from pl-workstation.usersys.redhat.com ([10.40.3.105])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 uBMChGik029556
 for <selinux@tycho.nsa.gov>; Thu, 22 Dec 2016 07:43:16 -0500
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Rewrite restorecon python method
Date: Thu, 22 Dec 2016 13:43:07 +0100
Message-Id: <20161222124309.27686-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi.

selinux.restorecon(path, recursive=True) uses matchpathcon() to get a
label for a file and when the label is defined as <<None>>,it throws a
backtrace with error:

"OSError: [Errno 2] No such file or directory"

It creates a problem for scripts which tries to relabel whole directory tree
when there a subdirectory with a specification like this:

/var/lib/nfs/rpc_pipefs(/.*)?      all files   <<None>>

>>> selinux.restorecon('/var/lib', recursive=True)                                   
Traceback (most recent call last):
  File "/usr/lib64/python3.5/site-packages/selinux/__init__.py", line 114, in restorecon
    status, context = matchpathcon(path, mode)
FileNotFoundError: [Errno 2] No such file or directory


At the same time, there's a rfe to rewrite restorecon() to use
selinux_restorecon() which uses selabel_lookup() instead of deprecated
matchpathcon() - [1]

The following 2 patches tries to address the described problem using the RFE.

First patch exports selinux_restorecon() to SWIG bindings.
Second one rewites python implementation of restorecon() to use it.


[1] https://github.com/SELinuxProject/selinux/issues/29

Petr
