Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA813905E6;
	Fri, 22 May 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441365; cv=none; b=trzyAF9TS4lTPKBoucuhscdkmU/NslNTv5si8CqNrsDh9WOkYazd1lhf8OAnNbz/o+ujt4JPavTcf4VTr56wWhBqMudX+pP835MxqV/Mgc5yLKP2eHvAr3a8WLLd5kcjrJzVObCmD7aocGfZQGVp2prnCuvFxFJCWGeGqksSEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441365; c=relaxed/simple;
	bh=wimK3YS/52teb0Dnz8suCnTWMoQ9EYzTBw/6Snk1ELE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EekTMTAGEMqtAuDXgfx58ISGc+ErXe1YW4N8bYKUenTJSwhkmKrcWm4XbelkvVJ+oe6Vr2VeiyDHlT55ORHRCJeiYvxpRH6NzQyVPLdpcFn9ESL1Nyq0T+pgl5aUEU/ZcWwNZ/gZ2llGd+DHF3ZgxNdIetkZ+n+mx7BkS1K8Ed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky/I9Eyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky/I9Eyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35CB1F000E9;
	Fri, 22 May 2026 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779441363;
	bh=vDitLrccOg+8Y67zSEKhE4vdC5DZGltvxlodqtaG9d4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Ky/I9EybMxXHvCGCIiRwsLutfv3NkZ4d2ICIyEXVxawCvINuc/21zdGrA3ZVtWUV7
	 f2WoX/B4NIUEyo0TJSjVwiySuwm6I9TMXEQA0TnStdvcrIjX8yXMTJ6dF4agpXnIdM
	 ytzFl8MModW6xmD8v6YoXSVvLKD162jMYqAT2M17FjkHKJAQwJWkm4mXlgZjcS16R3
	 7u1AcyY30VgE3dQcPkYeQgZm2o83ScCTGZadxcR8x55u8rq8yynB43xafl6yivtzv4
	 7ZzJ/1EfaH/0qE0zn4LqX/GV/Gx2HswlD8k8yZtHASQPG5Y7bcEh6eXbBDOMkrGq1v
	 yDRCfcyMMEKPQ==
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/7] lsm: Add granular mount hooks to replace
 security_sb_mount
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
 jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
 stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
 gnoack@google.com, takedakn@nttdata.co.jp, 
 penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, 
 kernel-team@meta.com
In-Reply-To: <20260515200158.4081915-2-song@kernel.org>
References: <20260515200158.4081915-1-song@kernel.org>
 <20260515200158.4081915-2-song@kernel.org>
Date: Fri, 22 May 2026 11:15:52 +0200
Message-Id: <177944135249.2871055.11361892114499566606.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wimK3YS/52teb0Dnz8suCnTWMoQ9EYzTBw/6Snk1ELE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJyJ2/ZBpXcuDDe+X784pWOTkby7a6vVD3n3dt0g+h4
 /F3X4Yv6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIIQcjw3xLjeI7e7tcAiuW
 HwxRXJnE8PTh//TuhBcbGzkE+S9eM2H4wx/GcTuqwKwuoLh471HH7dN4F03RDXL9Hbs+KUpgX+1
 GfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 15 May 2026 13:01:52 -0700, Song Liu <song@kernel.org> wrote:
> [...]
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux only
> Signed-off-by: Song Liu <song@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Please cleanly separate the preparatory work for introducing the new
hooks from any changes to fs/namespace.c

Once you have all of the new machinery in place, switch fs/namespace.c
over to the new hooks.

This will make it way easier to review and easier to distribute the

-- 
Christian Brauner <brauner@kernel.org>
