Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HESafH029239
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 10:28:42 -0400
Received: by wgxm20 with SMTP id m20so83641249wgx.3
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 07:28:38 -0700 (PDT)
Received: from localhost ([94.204.182.243])
 by smtp.gmail.com with ESMTPSA id e7sm8733757wib.22.2015.07.17.07.28.36
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jul 2015 07:28:37 -0700 (PDT)
Date: Fri, 17 Jul 2015 18:28:34 +0400
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [GIT PULL] policycoreutils: fix PEP8 issues
Message-ID: <20150717142834.GA20679@meriadoc.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The following changes since commit 2202a68d5ac2ac4c8fe05cdea829435efd2ba8e6:

  Updated sepolgen ChangeLog. (2015-07-16 13:11:14 -0400)

are available in the git repository at:

  https://github.com/perfinion/selinux.git reformat

for you to fetch changes up to 78c977e34c85ff97e236434d90ee9be5ed8ce1d0:

  policycoreutils: Fix PEP8 issues (2015-07-17 17:55:28 +0400)

Commit message:

    policycoreutils: Fix PEP8 issues

    When trying to get policycoreutils working in python3, I kept running
    into TabErrors:

        Traceback (most recent call last):
          File "/usr/lib/python-exec/python3.3/semanage", line 27, in <module>
            import seobject
          File "/usr/lib64/python3.3/site-packages/seobject.py", line 154
            context = "%s%s" % (filler, raw)
                                           ^
        TabError: inconsistent use of tabs and spaces in indentation

    Python3 is a lot stricter than python2 regarding whitespace and looks like
    previous commits mixed the two.  When fixing this, I took the chance to fix
    other PEP8 style issues at the same time.

    This commit was made using:
    $ file $(find . -type f) | grep -i python > pyfiles
    $ autopep8 --in-place --ignore=E501,E265 $(cat pyfiles)

    The ignore E501 is long lines since there are many that would be wrapped
    otherwise, and E265 is block comments that start with ## instead of just #.

---- ------------------------------------------------------------
Jason Zaman (1):
      policycoreutils: Fix PEP8 issues

 policycoreutils/audit2allow/audit2allow           |  112 ++--
 policycoreutils/audit2allow/audit2why             |  104 ++--
 policycoreutils/audit2allow/sepolgen-ifgen        |   14 +-
 policycoreutils/audit2allow/test_audit2allow.py   |   15 +-
 policycoreutils/gui/booleansPage.py               |   69 ++-
 policycoreutils/gui/domainsPage.py                |   24 +-
 policycoreutils/gui/fcontextPage.py               |   83 +--
 policycoreutils/gui/html_util.py                  |   19 +-
 policycoreutils/gui/loginsPage.py                 |   45 +-
 policycoreutils/gui/mappingsPage.py               |    6 +-
 policycoreutils/gui/modulesPage.py                |   33 +-
 policycoreutils/gui/polgengui.py                  |  201 +++----
 policycoreutils/gui/portsPage.py                  |   48 +-
 policycoreutils/gui/semanagePage.py               |   29 +-
 policycoreutils/gui/statusPage.py                 |   40 +-
 policycoreutils/gui/system-config-selinux.py      |   33 +-
 policycoreutils/gui/usersPage.py                  |   30 +-
 policycoreutils/mcstrans/share/util/mlscolor-test |   18 +-
 policycoreutils/mcstrans/share/util/mlstrans-test |   27 +-
 policycoreutils/sandbox/sandbox                   |  592 +++++++++---------
 policycoreutils/sandbox/start                     |    8 +-
 policycoreutils/sandbox/test_sandbox.py           |   27 +-
 policycoreutils/scripts/chcat                     |  129 ++--
 policycoreutils/semanage/semanage                 |  238 +++++---
 policycoreutils/semanage/seobject.py              | 4316 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
 policycoreutils/semanage/test-semanage.py         |  291 ++++-----
 policycoreutils/sepolicy/selinux_client.py        |   19 +-
 policycoreutils/sepolicy/selinux_server.py        |   29 +-
 policycoreutils/sepolicy/sepolicy.py              |  220 ++++---
 policycoreutils/sepolicy/sepolicy/__init__.py     |  487 ++++++++-------
 policycoreutils/sepolicy/sepolicy/booleans.py     |   19 +-
 policycoreutils/sepolicy/sepolicy/communicate.py  |   21 +-
 policycoreutils/sepolicy/sepolicy/generate.py     | 2168 +++++++++++++++++++++++++++++++++---------------------------------
 policycoreutils/sepolicy/sepolicy/gui.py          |  527 ++++++++--------
 policycoreutils/sepolicy/sepolicy/interface.py    |   49 +-
 policycoreutils/sepolicy/sepolicy/manpage.py      | 1174 ++++++++++++++++++------------------
 policycoreutils/sepolicy/sepolicy/network.py      |   33 +-
 policycoreutils/sepolicy/sepolicy/sedbus.py       |   30 +-
 policycoreutils/sepolicy/sepolicy/transition.py   |   35 +-
 policycoreutils/sepolicy/setup.py                 |    8 +-
 policycoreutils/sepolicy/test_sepolicy.py         |   39 +-
 41 files changed, 5907 insertions(+), 5502 deletions(-)
