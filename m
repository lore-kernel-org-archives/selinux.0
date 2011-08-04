Subject: Re: [PATCH 006/155] libselinux: do not check fcontext duplicates
 on use
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4E39B41E.8060801@redhat.com>
References: <4E39B41E.8060801@redhat.com>
Content-Type: multipart/mixed; boundary="=-KrduQR1C1v7wnbpn9wvi"
Date: Thu, 04 Aug 2011 10:48:18 -0400
Message-ID: <1312469298.20973.51.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KrduQR1C1v7wnbpn9wvi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-08-03 at 16:48 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> This patch looks good to me. acked.

>From 576af10294e14d03660708d3f7eddf49e71897d7 Mon Sep 17 00:00:00 2001
From: Eric Paris <eparis@redhat.com>
Date: Tue, 28 Jun 2011 21:37:38 -0400
Subject: [PATCH 006/155] libselinux: do not check fcontext duplicates on use

Tools like restorecon or systemd, which load the fcontext database to
make labeling decisions do not need to check for duplicate rules.  Only
the first rule will be used.  Instead we should only check for
duplicates when new rules are added to the database.  And fail the
transaction if we find one.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index af7fd8f..3b8346d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -485,7 +485,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 					 pass, ++lineno) != 0)
 				goto finish;
 		}
-		if (pass == 1) {
+		if (pass == 1 && rec->validating) {
 			status = nodups_specs(data, path);
 			if (status)
 				goto finish;


This seems like the wrong fix to me.  rec->validating is set based on
whether the application passed SELABEL_OPT_VALIDATE in the selinux_opt
array to selabel_open().  So you should fix the applications that set
this option if you do not want this behavior.  Not silently ignore what
they requested while leaving the field and option flag intact.



-- 
Stephen Smalley
National Security Agency

--=-KrduQR1C1v7wnbpn9wvi
Content-Disposition: attachment; filename="0006-libselinux-do-not-check-fcontext-duplicates-on-use.patch"
Content-Type: text/x-patch; name="0006-libselinux-do-not-check-fcontext-duplicates-on-use.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 576af10294e14d03660708d3f7eddf49e71897d7 Mon Sep 17 00:00:00 2001
From: Eric Paris <eparis@redhat.com>
Date: Tue, 28 Jun 2011 21:37:38 -0400
Subject: [PATCH 006/155] libselinux: do not check fcontext duplicates on use

Tools like restorecon or systemd, which load the fcontext database to
make labeling decisions do not need to check for duplicate rules.  Only
the first rule will be used.  Instead we should only check for
duplicates when new rules are added to the database.  And fail the
transaction if we find one.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index af7fd8f..3b8346d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -485,7 +485,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 					 pass, ++lineno) != 0)
 				goto finish;
 		}
-		if (pass == 1) {
+		if (pass == 1 && rec->validating) {
 			status = nodups_specs(data, path);
 			if (status)
 				goto finish;
-- 
1.7.6


--=-KrduQR1C1v7wnbpn9wvi--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
