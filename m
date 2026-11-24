Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525118;
	b=t0ftHZ6wqjK9BkOOXwGcaN7D97ewLuHsLYyT8m5raIaWA84rtcZtl3KSuHuOGOf5HQ61
	 3Oyug9tXtGJ749xAr2F/Jv7ZaHIpIqGDqQm76gKjQF3uQRMiX8awnYqPQmPCiGh7G70G7
	 wuNKzav3xpRDjUez+L0zpqqxRd1j1Nya557swdn0eTCuSPdA7J6MM+liEjjzoSOKSzUid
	 JWCi6Cmlv3Tf/zQLDACPcQa/CiTCMn2FtXm5Yg+S9HpsvIzFU/fi07ycH7hR3bKii4AoE
	 lZC46G+n463EQ3dCMTnoOmST8hDRikHeUO9eOCwAA/SRhmzGgn9HP/pw5fMqTwoafyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525118;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=z9Og2qwrjp4flkjnEIlPD8dRFmzOZtVzEgO4j8FEnhg=;
	b=3oHkM89yEyKwnba/sdwtRUdqwL0u7ysJbwm+xzQBDx6gIEgZAz36b1pBcyTqsKMmwGwA
	 KGS4piy4oi6+TCwhJ0TYZLH4kGCiC2XMygeRMwBlJf3FBVw41xbYVAUQ5HB99eDpU5W+B
	 89LB130GwVfWGuDy9fqFVQ4vMiT5BGaK59wSjsMWtzpRbq8pqNIbsVjbpiLJAyzGx12Ot
	 p7EZP16f+XWWp7BfED6yBOOws7BV/OfA7NHls5zCjX1aNo2N/QU45aVD7L8saEnCo90wF
	 gcJ2Ooh+LGRK+4oPo95d3BKQ4fks4LjVULOZh3RfCpducJbHAXakGSn1i8ZRjuzXx6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHiKmKr1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2075606A326
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 12:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2075606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHiKmKr1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795525116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z9Og2qwrjp4flkjnEIlPD8dRFmzOZtVzEgO4j8FEnhg=;
	b=eHiKmKr1z63yohBoPxr0kuJwi2kkPpKKI8ww/BHHEYPazGB1eNCa9ep3Z3sfHiEUb9JNX5
	RoAUkuXBrwBjpaRgkCT/m+riQQWTklR+XImPBes5FR6WLU9Aa5hEF++XqMWw5qchux5i29
	2o/QZO7kJ4HKiXvd8goCOh37urxom4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-NVDN-YzONOKUIOQujH1OoQ-1; Tue,
 24 Nov 2026 12:58:34 +0000
X-MC-Unique: NVDN-YzONOKUIOQujH1OoQ-1
X-Mimecast-MFC-AGG-ID: NVDN-YzONOKUIOQujH1OoQ_1795525113
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C92E71955F56
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 12:58:33 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBD3918004FC;
	Tue, 24 Nov 2026 12:58:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] scripts/release: Use "v" prefix for main release tag
Date: Tue, 24 Nov 2026 13:58:25 +0100
Message-ID: <20261124125825.904308-1-lautrbach@redhat.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

With this change, the new release tags will be prefixed with "v" - "v3.12". This
allows us to use later release branch "3.12" if there's a demand to backport
some important fixes and do a fast release, see
https://github.com/SELinuxProject/selinux/wiki/Release-Process

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 scripts/release | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/scripts/release b/scripts/release
index 94125a7acd0d..3549da9209d3 100755
--- a/scripts/release
+++ b/scripts/release
@@ -12,8 +12,9 @@ if ! [ -d "$WIKIDIR" ]; then
 	git clone git@github.com:SELinuxProject/selinux.wiki.git "$WIKIDIR"
 fi
 
-RELEASE_TAG="$(cat VERSION)"
-DEST="releases/$RELEASE_TAG"
+RELEASE="$(cat VERSION)"
+RELEASE_TAG="v$RELEASE"
+DEST="releases/$RELEASE"
 DIRS=(
 	checkpolicy
 	libselinux
@@ -31,9 +32,9 @@ DIRS=(
 )
 
 if git rev-parse "$RELEASE_TAG" &> /dev/null ; then
-	echo "Warning: tag $RELEASE_TAG already exists"
+	echo "Warning: tag v$RELEASE_TAG already exists"
 else
-	git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
+	git tag -a "$RELEASE_TAG" -m "Release $RELEASE"
 fi
 
 rm -rf "$DEST"
@@ -52,22 +53,22 @@ for COMPONENT in "${DIRS[@]}"; do
 	gpg -b -a "$DEST/$TAG.tar.gz"
 done
 
-git archive -o "$DEST/selinux-${RELEASE_TAG}.tar.gz" --prefix="selinux-${RELEASE_TAG}/" "${RELEASE_TAG}"
-gpg -b -a "$DEST/selinux-${RELEASE_TAG}.tar.gz"
+git archive -o "$DEST/selinux-${RELEASE}.tar.gz" --prefix="selinux-${RELEASE}/" "${RELEASE_TAG}"
+gpg -b -a "$DEST/selinux-${RELEASE}.tar.gz"
 
 echo "Add the following to the $WIKIDIR/Releases.md wiki page:"
 
 echo ""
 
-echo "## Release $RELEASE_TAG"
+echo "## Release $RELEASE"
 
 echo ""
 
-echo "[Release Notes](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/RELEASE-$RELEASE_TAG.txt)"
+echo "[Release Notes](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE/RELEASE-$RELEASE.txt)"
 echo ""
-echo "[full log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/log-$RELEASE_TAG.txt)"
+echo "[full log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE/log-$RELEASE.txt)"
 echo ""
-echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
+echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE/shortlog-$RELEASE.txt)"
 echo ""
 
 for COMPONENT in "${DIRS[@]}"; do
@@ -75,7 +76,7 @@ for COMPONENT in "${DIRS[@]}"; do
 	VERS="$(cat "$DIR/VERSION")"
 	TAG="$COMPONENT-$VERS"
 	tarball="$TAG.tar.gz"
-	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
+	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE/$tarball) "
 	sha256sum "$DEST/$tarball" | cut -d " " -f 1
 	echo ""
 done
@@ -84,13 +85,13 @@ echo "### Source repository snapshot"
 
 echo ""
 
-echo -n "[selinux-${RELEASE_TAG}.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-${RELEASE_TAG}.tar.gz) "
-sha256sum "$DEST/selinux-${RELEASE_TAG}.tar.gz" | cut -d " " -f 1
+echo -n "[selinux-${RELEASE}.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE/selinux-${RELEASE}.tar.gz) "
+sha256sum "$DEST/selinux-${RELEASE}.tar.gz" | cut -d " " -f 1
 echo ""
 
 echo "And then run:"
 echo "  cd $WIKIDIR"
-echo "  git commit  -m \"Release $RELEASE_TAG\" -a -s"
+echo "  git commit  -m \"Release $RELEASE\" -a -s"
 echo "  git push"
 
 echo ""
-- 
2.56.1

