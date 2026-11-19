Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093752;
	b=Q9hctwd+2vLx3qJ7kqRpzgTBckSjZkPXv7TeA70X97/cGCDtRrn7mRfuLHnjrbk6z64S
	 MxWEfEhe9BmH7Vzn2TBQlDY1T+H+dXIXCgI+qvdvPEX2TxJnmmjONzRdSis7Vi9Bha156
	 jpt7Prg3qfQ3P0QYL6KNO3sx5r+2wjyVvDMS1GnF4CqWkfjotAAw0ohq8LGsX8fyk0pNI
	 gcgess5qs1aVG36T7yTcDhDhIWl0i9dIcus5exVjTp6c3qwWCCaAkS2j73vpSkE7ezYW5
	 ed+dKeVMV5RvzgD8vajXm+2jeCxHnZvwSZrNAm8ZC9hBrJXCTjPfg6Wm94OJePM4rsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iol609hugT74WT/ksT3c5jGYkGJ4Cc05dN2jVVKPBQ4=;
	b=2HqPSpoE+zqUYVD+EB8TnfSOo30LIQNBHSiXNnKIu3dFcAJLKRqhF5TDYLWr706N6htj
	 MZFqFLccfCCiOUoS5xSOZ3RKUaO5WPN0T7TO4NReJ0C4FFXJbMdZSmyGFdXRblETv6fzx
	 zMLNC/jy3mGuAun8m9KvPPili0RYOvjHbdzacjX6F/2TdltIpSdPiakqCZ8yWeHoJHfFf
	 ai4HCWSj0j6J5wB+NWxFXPrkfTFZRz/N7Dt9kxT8tu3YGv+ia8VM7QikjqAwIQhebyc/e
	 dUEh1Qh7DRFKQ6j/T421Il54bU/08QIsYqxU47OL3b8rJ2oJxPHX75ATieaON++T39g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKOboDiu;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E25606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34E25606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKOboDiu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-920fed989b2so19385876d6.2
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093751; x=1795698551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iol609hugT74WT/ksT3c5jGYkGJ4Cc05dN2jVVKPBQ4=;
        b=iKOboDiuVlNy6zFlkguYxFAVf9BQfBaAjmAaGn5vDzVaDqtulQHB6mOHRqbzKDQM8x
         Jcl6TRAdkFP0DAgjVEAg3beS7kg1tWVP7nT7Fs3EDJPRq52ADDq6ULxMj2C4wN+pS6K3
         qhAhhwCyIL4VPhFqAvfWHIqCRcfs5mcb2ItX+dKtZ/9L87iooyrk26hPDd49KPmJakBU
         W5I4Vyq9nNNNIYJRcMlf8vwvANEoIp3Kd9GEynrogGSxfb/J/WUpd2HMLExbkc8CSeSq
         QSQx370+xNgeneCW3uBcR8uVZzZkR5we5G/wAfSFIiz7L744obwkTWM/JpHUjIwMbE6p
         nITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093751; x=1795698551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iol609hugT74WT/ksT3c5jGYkGJ4Cc05dN2jVVKPBQ4=;
        b=Zu2LyD0H0Oh9n4czPMOOitPJ2LQ90xb/S/tPRlrNvmUJLf5Ye2a61AYU7QqYOxHtgO
         bXHckis5b6+s79VWA9JnazUggRCrHhgWpe0/VYcFyIBw7BgGsjEBWxRXf2m8atjc7L2L
         VSqbb6B8QjIj2HL6tp8xLQ2zuA3umMomDrvudFLi9rE5teUxfP4yCfDjBVoUp5qc1+pH
         YVtwlmfcB9M7WPBxDt7jMa9VCukoRf5zknxBIV+slI1og1tTKHn1uPpoSEO4+FCKdpxP
         XQ/q7htAP0TS/mLiCtPaJA5EO1TzGFBKRNbV1MTzyit9CL/7j1uZhs+xlCKLQlZ7Af5M
         Du7Q==
X-Gm-Message-State: APuU4Z9/PwIpmf+lFLZSLFAd3wJ+EOo8NSz3/IICH9TDZyxwxp+3lZMR
	JHnQG5u+2S6/CSYUc9vGxXM3dok1yTUzLsjI8J9xr8QEzNBZfo3JG9vkS0EyHw==
X-Gm-Gg: AZFdTZcg7s0PGnSBVFhoh1Zceba1/LOj08Kyw3gFpflGTdwo8C0LlKWQJ2TQR3JdWuD
	PyuMpdCdYb6qXPRozKluT5fbM2F3rQCEuP0xt2+6lOgMg3KiBfdXhNcO6o4ct9eZpt5D32iGJsN
	lSQsdChemHGURpM0JUtVyHNjG4SN2tZ1XLtpqIqQujMqxipcg5F5TtqzH9gI/1ItRNypJ3ydGm/
	e+iNzK8lvRg56krW//ZFt+jmEot/HbskEDsSu9gX/q9lZmNRfZvkRW9sHGPM2vpPAHZ3e292eEf
	6Ohoo5vRU+Z+yE5nNPP9usMdR1t+nciHf4+z7IjvLUn2olbie84FKf2aWIsFuPIa3wpTD+rNUSo
	Kx4kyCDBtGLoWaTGxgDhoWbtWgEnT6ICG5ip6TLHZpb0ypZms13C4++pzBboKOEyidHmG9wK/sG
	648utkodQFJNp5zlbO4zG1R/UuA1W/tySjHfGdHh/jK2Gl+2+1Onpt5+LmJ2wUzH+p1jtb6SEYU
	V+nqt1eF2VaRwGBriHK1ChLWoR6W2IhMmvBSD9IM5OaxBYN66kY4R6OeloGnsC5Y2IAbTGkIDcK
	DBAyiY7FR4vLNpyVTpNBIuhiW2MpKtXyfXSVYB14ylfAoH7o8BWJEJnyylVRIr5Tlhg/mSC0D3x
	mw7vSzRCg6HtJz5WSsNlmsDSt9BYl7CMxPV1Rn6gaIcKI/E1OpRz3WOx4Ho2xn/JgD4uTckjvRk
	JBy+n1GcJxTIZXr2dvdZaWk4NM2VuVWSg/
X-Received: by 2002:a05:6214:33c8:b0:91e:a46f:a58c with SMTP id 6a1803df08f44-92114d9bcdbmr92507896d6.8.1795093751092;
        Thu, 19 Nov 2026 05:09:11 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114a00ad2sm48981206d6.3.2026.11.19.05.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:09:10 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libsemanage: escape regex metacharacters when substituting NSS strings
Date: Thu, 19 Nov 2026 13:08:53 +0000
Message-ID: <20261119130853.858-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119130853.858-1-stephen.smalley.work@gmail.com>
References: <20261119130853.858-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genhomedircon substitutes the Linux user name into the USER and
%{USERNAME} placeholders and the home directory into HOME_DIR and
HOME_ROOT verbatim. These land in the regular-expression field of a
file-context line, so a "." in "john.smith" or "/srv/home.d" matches
any character, and a hostile passwd source can supply a value to widen
a homedir template so that arbitrary system paths receive
user_home_dir_t and similar contexts on the next relabel. This is
weaker than the line-injection primitive addressed by the previous
patch, but it is the same untrusted-input path.

Backslash-escape the PCRE metacharacters in these values before
substitution. Add a name_re field alongside name so the un-escaped
form is still available for the "# Home Context for user %s" comment
and the find_user() equality check, and so the fallback entry can keep
its intentional "[^/]+" / "[0-9]+" regexes. The home field has no
other consumers so it stores the escaped form directly. \Q..\E is not
used because a "\E" in the input would terminate it.

The visible behavior change is that a user "john.smith" now only
matches its literal home directory, not "johnXsmith"; that was always
the intent and matches how libselinux's label_file compares literal
prefixes.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/genhomedircon.c | 74 ++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 2ef923ce..8afffab9 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -106,6 +106,7 @@
 
 typedef struct user_entry {
 	char *name;
+	char *name_re;
 	char *uid;
 	char *gid;
 	char *sename;
@@ -323,6 +324,24 @@ static bool is_fc_safe(const char *str)
 	return true;
 }
 
+static char *fc_regex_escape(const char *s)
+{
+	static const char meta[] = "\\^$.[]|()*+?{}";
+	size_t len = strlen(s);
+	char *out = malloc(2 * len + 1);
+	char *p = out;
+
+	if (!out)
+		return NULL;
+	for (; *s; s++) {
+		if (strchr(meta, (unsigned char)*s))
+			*p++ = '\\';
+		*p++ = *s;
+	}
+	*p = '\0';
+	return out;
+}
+
 static int prefix_is_homedir_role(const semanage_user_t *user,
 				  const char *prefix)
 {
@@ -963,7 +982,8 @@ static int write_username_context(genhomedircon_settings_t *s, FILE *out,
 				  const genhomedircon_user_entry_t *user)
 {
 	const replacement_pair_t repl[] = {
-		{ .search_for = TEMPLATE_USERNAME, .replace_with = user->name },
+		{ .search_for = TEMPLATE_USERNAME,
+		  .replace_with = user->name_re },
 		{ .search_for = TEMPLATE_USERID, .replace_with = user->uid },
 		{ .search_for = TEMPLATE_ROLE, .replace_with = user->prefix },
 		{ NULL, NULL }
@@ -977,7 +997,7 @@ static int write_user_context(genhomedircon_settings_t *s, FILE *out,
 			      const genhomedircon_user_entry_t *user)
 {
 	const replacement_pair_t repl[] = {
-		{ .search_for = TEMPLATE_USER, .replace_with = user->name },
+		{ .search_for = TEMPLATE_USER, .replace_with = user->name_re },
 		{ .search_for = TEMPLATE_ROLE, .replace_with = user->prefix },
 		{ NULL, NULL }
 	};
@@ -1022,13 +1042,14 @@ static int name_user_cmp(const void *arg1, const void *arg2)
 	return strcmp(key, semanage_user_get_name(*val));
 }
 
-static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
-			   const char *u, const char *g, const char *sen,
-			   const char *pre, const char *h, const char *l,
-			   const char *ln, const char *hd_role)
+static int push_user_entry(genhomedircon_user_entry_t **list, bool escape,
+			   const char *n, const char *u, const char *g,
+			   const char *sen, const char *pre, const char *h,
+			   const char *l, const char *ln, const char *hd_role)
 {
 	genhomedircon_user_entry_t *temp = NULL;
 	char *name = NULL;
+	char *name_re = NULL;
 	char *uid = NULL;
 	char *gid = NULL;
 	char *sename = NULL;
@@ -1044,6 +1065,9 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
 	name = strdup(n);
 	if (!name)
 		goto cleanup;
+	name_re = escape ? fc_regex_escape(n) : strdup(n);
+	if (!name_re)
+		goto cleanup;
 	uid = strdup(u);
 	if (!uid)
 		goto cleanup;
@@ -1056,7 +1080,7 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
 	prefix = strdup(pre);
 	if (!prefix)
 		goto cleanup;
-	home = strdup(h);
+	home = escape ? fc_regex_escape(h) : strdup(h);
 	if (!home)
 		goto cleanup;
 	level = strdup(l);
@@ -1072,6 +1096,7 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
 	}
 
 	temp->name = name;
+	temp->name_re = name_re;
 	temp->uid = uid;
 	temp->gid = gid;
 	temp->sename = sename;
@@ -1087,6 +1112,7 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
 
 cleanup:
 	free(name);
+	free(name_re);
 	free(uid);
 	free(gid);
 	free(sename);
@@ -1109,6 +1135,7 @@ static void pop_user_entry(genhomedircon_user_entry_t **list)
 	temp = *list;
 	*list = temp->next;
 	free(temp->name);
+	free(temp->name_re);
 	free(temp->uid);
 	free(temp->gid);
 	free(temp->sename);
@@ -1166,10 +1193,11 @@ static int setup_fallback_user(genhomedircon_settings_t *s)
 				homedir_role = prefix;
 			}
 
-			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
-					    FALLBACK_UIDGID, FALLBACK_UIDGID,
-					    seuname, prefix, "", level,
-					    FALLBACK_NAME, homedir_role) != 0)
+			if (push_user_entry(&(s->fallback), false,
+					    FALLBACK_NAME, FALLBACK_UIDGID,
+					    FALLBACK_UIDGID, seuname, prefix,
+					    "", level, FALLBACK_NAME,
+					    homedir_role) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
 			if (u)
@@ -1336,10 +1364,11 @@ retry:
 	}
 
 	retval =
-		push_user_entry(head, name, uid, gid, sename, prefix,
+		push_user_entry(head, true, name, uid, gid, sename, prefix,
 				canonical_home ? canonical_home : pwent->pw_dir,
 				level, selogin, homedir_role);
 	free(canonical_home);
+
 cleanup:
 	free(rbuf);
 	return retval;
@@ -1593,10 +1622,12 @@ static int write_context_file(genhomedircon_settings_t *s, FILE *out)
 		}
 
 		for (h = homedirs; h; h = h->next) {
+			char *hd_re = fc_regex_escape(h->data);
 			char *temp = NULL;
 
-			if (asprintf(&temp, "%s/%s", h->data, FALLBACK_NAME) <
-			    0) {
+			if (!hd_re || asprintf(&temp, "%s/%s", hd_re,
+					       FALLBACK_NAME) < 0) {
+				free(hd_re);
 				retval = STATUS_ERR;
 				goto done;
 			}
@@ -1608,20 +1639,23 @@ static int write_context_file(genhomedircon_settings_t *s, FILE *out)
 						   s->fallback) !=
 			    STATUS_SUCCESS) {
 				free(temp);
+				free(hd_re);
 				s->fallback->home = NULL;
 				retval = STATUS_ERR;
 				goto done;
 			}
-			if (write_home_root_context(
-				    s, out, homeroot_context_tpl, h->data) !=
-			    STATUS_SUCCESS) {
+			if (write_home_root_context(s, out,
+						    homeroot_context_tpl,
+						    hd_re) != STATUS_SUCCESS) {
 				free(temp);
+				free(hd_re);
 				s->fallback->home = NULL;
 				retval = STATUS_ERR;
 				goto done;
 			}
 
 			free(temp);
+			free(hd_re);
 			s->fallback->home = NULL;
 		}
 	}
@@ -1678,11 +1712,13 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 	}
 
 	s.fallback->name = strdup(FALLBACK_NAME);
+	s.fallback->name_re = strdup(FALLBACK_NAME);
 	s.fallback->sename = strdup(FALLBACK_SENAME);
 	s.fallback->prefix = strdup(FALLBACK_PREFIX);
 	s.fallback->level = strdup(FALLBACK_LEVEL);
-	if (s.fallback->name == NULL || s.fallback->sename == NULL ||
-	    s.fallback->prefix == NULL || s.fallback->level == NULL) {
+	if (s.fallback->name == NULL || s.fallback->name_re == NULL ||
+	    s.fallback->sename == NULL || s.fallback->prefix == NULL ||
+	    s.fallback->level == NULL) {
 		retval = STATUS_ERR;
 		goto done;
 	}
-- 
2.47.3

