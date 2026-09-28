Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE904EBAF7
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=KduAGCAy3WXI9K3DnB1cY/Jpy3NQDI/JvDwJdkFKG3IZXnGUKAk99mKAe6uwXPsFiZXlnouG2bil0UZv8Qfi2/08EzEAvTpveLAPExGhVkw98SGkZvPSRiV+NxrNricgsSzcRdsytgQ+2fcIqCl9wRynzdqwWX2zr2JlVduWiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=+XOxAlgshZ7X+gyPzsH4YRXJTZgzg7UVrESHp4pZ6iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyfY4GOYxB5nmG3OSbUfuDQCDR8rrMfx0DekFXT5nPvNwtcBNd9QPnFNs14Wbhbh8oSpGmS9QWdnXtvRO39rT8WY+5HbXDJzRmJkCOoDqkwx6gw2Au3+xkpxhjzxxMyGbJOfF72OICZlASsvrqCYo7SSqEu1Wj7CjxaPHbABj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=mLxIAX+Z; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="mLxIAX+Z"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617623;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N60ka3ulYoV7xCo0aKUY2GHW2zqCm7Maw6DzikV+yko=;
	b=mLxIAX+ZjN/jNe+tfey1x63XSQcbPGsSrs2Y37ROOBZiakQxY+tgAWVRT2FD8fpdIlevO/
	8yGNnxb5/EmogD4O0AZnhb2eBEz6Nn6F5sGwmPZqWMOnQNLrGQZiov7sayMqpE+fLS3uKW
	spS2zOIva/lBFGewmeWV7wTw5YSGnKG8xS/LwamoVucyJ85COpQDy5iQCZ6op2C0AyImQi
	3ruSjaNs1EkhkO4jVwY+0XkAUByOG7ZCe6AHCg3q9W0062YkYFPqju4fGHCFz0JE2Q8S8y
	uYNFrHVLS2Aukgo1KHDnDBQMWZ8xYyXghb58R/hieNso/h5+eyyQLDNUTomaqA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 22/32] selinux: factor out constraint_list_destroy()
Date: Mon, 28 Sep 2026 19:46:32 +0200
Message-ID: <20260928174643.2458710-21-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

cls_destroy() tears down the constraints and validatetrans lists with
the same code.  Move it into a helper.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 47 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 94b0f1392ad3..a80aebf0bbfa 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -221,42 +221,35 @@ static void constraint_expr_destroy(struct constraint_expr *expr)
 	}
 }
 
+static void constraint_list_destroy(struct constraint_node *constraint)
+{
+	struct constraint_node *ctemp;
+	struct constraint_expr *e, *etmp;
+
+	while (constraint) {
+		e = constraint->expr;
+		while (e) {
+			etmp = e;
+			e = e->next;
+			constraint_expr_destroy(etmp);
+		}
+		ctemp = constraint;
+		constraint = constraint->next;
+		kfree(ctemp);
+	}
+}
+
 static int cls_destroy(void *key, void *datum, void *p)
 {
 	struct class_datum *cladatum;
-	struct constraint_node *constraint, *ctemp;
-	struct constraint_expr *e, *etmp;
 
 	kfree(key);
 	if (datum) {
 		cladatum = datum;
 		hashtab_map(&cladatum->permissions.table, perm_destroy, NULL);
 		hashtab_destroy(&cladatum->permissions.table);
-		constraint = cladatum->constraints;
-		while (constraint) {
-			e = constraint->expr;
-			while (e) {
-				etmp = e;
-				e = e->next;
-				constraint_expr_destroy(etmp);
-			}
-			ctemp = constraint;
-			constraint = constraint->next;
-			kfree(ctemp);
-		}
-
-		constraint = cladatum->validatetrans;
-		while (constraint) {
-			e = constraint->expr;
-			while (e) {
-				etmp = e;
-				e = e->next;
-				constraint_expr_destroy(etmp);
-			}
-			ctemp = constraint;
-			constraint = constraint->next;
-			kfree(ctemp);
-		}
+		constraint_list_destroy(cladatum->constraints);
+		constraint_list_destroy(cladatum->validatetrans);
 		kfree(cladatum->comkey);
 	}
 	kfree(datum);
-- 
2.55.0

