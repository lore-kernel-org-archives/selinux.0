Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D23C09FF
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621555; cv=none; b=N9nVzquw/QxV4oe+23XwWME/8mna4pyiCk+UcUtqXg97swB3d1PBWy+1GO7gjhhh2IyN9c+fCU6ZBMdcz4jwMXlhA8FTKnZ+omixcy2TzOSuieaHi91S1w1WB68v5iOrFvU2k+3JVRTgeRtYvkmFSCLA3yY/NGrN1CTiC0lCrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621555; c=relaxed/simple;
	bh=gTwn4ty2IcNVWpVult57EewYPI168Shh1bYeHY4xAE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3Oc+NaoYKbWnzsZDUV04y15JVlY4vQr8Rc5RNxD4m3Hl2IAIlFnzrloaxbUcerEd1HSXIPIIvsd2N2BMffES6W+VvKFFi1ck9isPfoky71wVjY94IeAABBVThm0X4Y2BUEJRQyUrje7xzaIW3iCpwuFex5fPCbv9LMiHcKSxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KpBld5Hi; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KpBld5Hi"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1781621037;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DBnQUH7GSjFTMrKb+2rnsFwu0v753ZlxlWhrHTGI7q8=;
	b=KpBld5HiFLndK68KFFuheE+nrVM2Vzb77oBcl+Dml+81Dbqis3mgsqTvN48V6FGt90Xupv
	q18mWT5sshyjJoXSd199JHXJCPHP50F5g3tNZXgWHjlWMXPiCWZ30tAO/ZajAGNE1JtgUK
	JgoPaRjry1NKwR+bOeCy0xSS0hPaC16BlOyQwM1yU9/x29YOr4vvz9GLrpv1l3rBXwfvbZ
	OpKNxPxat3tpBexqO3joAuslC/SIbViXdIEB+nzx6XBqOPvCHzNa2lWJw1ThgbQA4Vdtfc
	5EKwiIM+MO84JeGy2YPE5bZBzjjDLMYPByeMyKQFOCaHtpBmcPtHfIwtNbEbwg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] secilc/docs: mention nlmsg extended permissions
Date: Tue, 16 Jun 2026 16:43:44 +0200
Message-ID: <20260616144345.478744-1-cgoettsche@seltendoof.de>
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

In addition to ioctl CIL also supports nlmsg extended permissions.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/docs/cil_class_and_permission_statements.md | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/secilc/docs/cil_class_and_permission_statements.md b/secilc/docs/cil_class_and_permission_statements.md
index c494f144..565bb59e 100644
--- a/secilc/docs/cil_class_and_permission_statements.md
+++ b/secilc/docs/cil_class_and_permission_statements.md
@@ -529,7 +529,11 @@ Defines a named extended permission, which can be used in the [`allowx`](cil_acc
 <tbody>
 <tr class="odd">
 <td align="left"><p>ioctl</p></td>
-<td align="left"><p>Permissions define a whitelist of ioctl values. Permission values must range from <code>0x0000</code> to <code>0xFFFF</code>, inclusive.</p></td>
+<td align="left"><p>Permissions define a whitelist of ioctl command values. Permission values must range from <code>0x0000</code> to <code>0xFFFF</code>, inclusive.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p>nlmsg</p></td>
+<td align="left"><p>Permissions define a whitelist of netlink message type values. Permission values must range from <code>0x0000</code> to <code>0xFFFF</code>, inclusive.</p></td>
 </tr>
 </tbody>
 </table></td>
@@ -561,4 +565,5 @@ Defines a named extended permission, which can be used in the [`allowx`](cil_acc
     (permissionx ioctl_1 (ioctl tcp_socket (0x2000 0x3000 0x4000)))
     (permissionx ioctl_2 (ioctl tcp_socket (range 0x6000 0x60FF)))
     (permissionx ioctl_3 (ioctl tcp_socket (and (range 0x8000 0x90FF) (not (range 0x8100 0x82FF)))))
+    (permissionx nlmsg_1 (nlmsg netlink_route_socket (range 0x0010 0x0018)))
 ```
-- 
2.53.0

