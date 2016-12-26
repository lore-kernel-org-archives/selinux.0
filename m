Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQLIkwv018050
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 16:18:49 -0500
Received: from localhost.localdomain (private.iosenag.net [31.7.184.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DAA8956469F
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 22:18:47 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] checkpolicy: do not leak queue elements in queue_destroy()
Date: Mon, 26 Dec 2016 22:18:31 +0100
Message-Id: <20161226211832.7165-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161226211832.7165-1-nicolas.iooss@m4x.org>
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Elements which are inserted into a queue_t object are either NULL (from
insert_separator()) or strings allocated with malloc() in insert_id().
They would be freed if there are still present in the queue when it is
destroyed. Otherwise the memory allocated for these elements would be
leaked.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/queue.c b/checkpolicy/queue.c
index 272079c0debe..acc991c63303 100644
--- a/checkpolicy/queue.c
+++ b/checkpolicy/queue.c
@@ -113,6 +113,7 @@ void queue_destroy(queue_t q)
 
 	p = q->head;
 	while (p != NULL) {
+		free(p->element);
 		temp = p;
 		p = p->next;
 		free(temp);
-- 
2.11.0
