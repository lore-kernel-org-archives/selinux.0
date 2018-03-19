Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2JIofck010952
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 14:50:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 404lWH33Bvz2SlcG
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 18:50:35 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 404lWH1RXBz2Slc8
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 18:50:35 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id x82so4859582wmg.1
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 11:50:34 -0700 (PDT)
Sender: Pierre-Hugues Husson <phhusson@gmail.com>
From: Pierre-Hugues Husson <phh@phh.me>
To: selinux@tycho.nsa.gov
Date: Mon, 19 Mar 2018 19:47:55 +0100
Message-Id: <20180319184756.12561-1-phh@phh.me>
Subject: [PATCH 0/1] Support multiple identical genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

secilc has a multiple_decls option to allow for multiple type
declarations.
The next step is to allow multiple samples of the same rules.
This commit does this on genfscon

One usecase is Android/Project Treble:
With Project Treble, vendor might include rules included in later
in framework.
In order to be able to update the framework in this case, we need
to remove identical rules.

I have several pending questions before considering merging:

Should the "compact" function be somewhere else? Or perhaps there is already
some variant available?
Should the "compact" function simply take a cil_sort rather than a C array?
Should we compact all types indifferently?
If so, we need to guarantee that the _compare function returns 0 only when the
types rules are identical, and not just the same match rule. Is this already
the case?
How is memory allocation done/will compact impact the release of the memory?
In my understanding this is just one big chunk, so the size isn't used when
free-ing, so it should be ok


Pierre-Hugues Husson (1):
  Delete identical genfscon-s

 libsepol/cil/src/cil_post.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.15.1
