Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAK91srL020869
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 04:01:54 -0500
Received: from iron3-smtp.tops.gwu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAK90FkX009099
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 09:00:16 GMT
From: Yuichi Nakamura <ynakam@gwu.edu>
To: selinux@tycho.nsa.gov
Cc: ynakam@gwu.edu
Message-ID: <dca487e823b48.4561eda4@gwu.edu>
Date: Mon, 20 Nov 2006 18:02:12 +0900
MIME-Version: 1.0
Subject: Question about setsebool.c
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I looked at the latest policycoreutils code.
(policycoreutils-1.33.1-9.fc7.src.rpm)

And found strange code, in setsebool.c.

    94  /* Apply (permanent) boolean changes to policy via libsemanage */
    95  static int semanage_set_boolean_list(size_t boolcnt,
    96                                       SELboolean * boollist, int perm)
    97  {
   <snip>
   117          } else if (managed == 0) {
   118                  if (selinux_set_boolean_list(boolcnt, boollist, 1) < 0)
   119                          goto err;
   120                  goto out;
   121          }

Why 3rd arg for selinux_set_boolean_list is "1"?
Should it be "perm"?

Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
