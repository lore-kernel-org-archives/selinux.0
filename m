Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PFqatt011927
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 11:52:36 -0400
Received: by mail-we0-f179.google.com with SMTP id x55so6403689wes.10
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 08:52:32 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] Support udev-197 and higher
Date: Wed, 25 Sep 2013 17:52:01 +0200
Message-Id: <1380124322-32745-5-git-send-email-sven.vermeulen@siphos.be>
In-Reply-To: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
References: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The errno value was not set, causing wrong return notifications and
failing to have udev label things correctly.

See https://bugzilla.redhat.com/show_bug.cgi?id=909826#c24 and
see https://bugs.gentoo.org/show_bug.cgi?id=462626

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 libselinux/src/label_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 5f697f3..9b0d6b0 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -649,6 +649,8 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 				break;
 			} else if (rc == PCRE_ERROR_NOMATCH)
 				continue;
+
+			errno = ENOENT;
 			/* else it's an error */
 			goto finish;
 		}
@@ -660,6 +662,7 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 		goto finish;
 	}
 
+	errno = 0;
 	ret = &spec_arr[i].lr;
 
 finish:
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
