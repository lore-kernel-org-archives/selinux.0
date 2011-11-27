Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pARG70NI004072
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 11:07:01 -0500
Received: from nm3-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pARG6xPm016608
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 16:06:59 GMT
Message-ID: <1322410017.47664.YahooMailClassic@web87001.mail.ird.yahoo.com>
Date: Sun, 27 Nov 2011 16:06:57 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] libselinux - Mapped compute functions now obey deny_unknown flag
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If selinux_set_mapping(3) is used to map classes, and an invalid class is used to compute a decision (tclass = 0), the result did not obey the status of the deny_unknown flag.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/compute_av.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 86ff274..ec5a096 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -60,6 +60,8 @@ int security_compute_av_flags_raw(const security_context_t scon,
 	} else if (ret < 6)
 		avd->flags = 0;
 
+	/* If tclass invalid, kernel sets avd according to deny_unknown flag */
+	if (tclass != 0)	
 	map_decision(tclass, avd);
 
 	ret = 0;
-- 
1.7.7.1


Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
