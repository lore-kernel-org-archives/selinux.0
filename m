Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994C80034;
	Wed, 12 Mar 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741842; cv=none; b=uR02RFk/2368r7UEhM+YLi3w3Mp+qBI7pgd6j+O6qrr4faSCl8F0LBCpLIXp82uVb5bshnLj4g475IylK7yMaJ/qTe3hDtLvI53SBPewdMMQVOYIZIbjKu534V6EfFKSeHXyiwkbhHo75Gh47Mcl2uhI1+TgLFPFWjjkZj7sNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741842; c=relaxed/simple;
	bh=ihg5D7JjYwR8wMjfG32hR1vTg+jRmYudx4QHbcb4sIw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=b444ltHQ1/6+qibohg5a+F7nQPZ1TIeag2DtUt1OoyNC0J/9kIZjbkGDDXijDMEXACjPoK1wfQlubXil3AIT1PE+sTj9BFo6xupchT9YS6rx0hPgOpKS/aUWnXzMH2zsPiGvd4by7j4FejSAUMAAHEnqzQYQLXJ/XZYS8AfNrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d0ZMyQeH; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d0ZMyQeH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741741525; bh=hIU6OUXhJGBsv4djF82ZLszpiy8ehuXLtiXE6CrEhKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0ZMyQeHx575wW8g1gphD92SMaTyenXQOIQPeJ9OSWmfRaTl89XhRxBAtNw4XNPen
	 W2C4852advLemtQlSSTYMzACkOvYZA5WHqdkIdhDuypvcg8GiEBha24Rd+FHrQbH5u
	 9b5uzyFHofyJOqiWSKk/MlBbL83GnIfafixRMwuw=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 1569A20B; Wed, 12 Mar 2025 09:05:22 +0800
X-QQ-mid: xmsmtpt1741741522ts27i5q8l
Message-ID: <tencent_E8AA2ECB6ED7CC88A7F746FED2C4065B0906@qq.com>
X-QQ-XMAILINFO: NN8wcaRHkJbBpHtqXl713Cg9E1IV7rv2clcZUpgVcxgqdBJMexZy63zArzO5my
	 PC14odSXYx4DDVDwSZYsPXOvHGljY+DODeNSAOd8cSeLRAguH9OYIwVRKxLQxmhSfBs/uya+hQy7
	 +BMNCpcRUgXtpmY/M61bWh9sQcP8ve8Sq6EbsdzM/CKid4S8jz6oT+u4BFtyCH/FIgnduREAL+CO
	 +qlgDpXoS0Rjp5uG19JEW957SYcn2b8381U6pMjtstru+oBqPUTApG0PoZZVK4mpoaJhM2jXXzXT
	 m/q4u9ZluCrWZoETIH78D4LpZG5mSr8agwOCTYE/qkB+X/nQfpin/eTp3oWIBsg3eNdkyrrjy9wb
	 AzINr+9Y8LVmZJyJhZ6UUMOjW1fFKPs1qPqbHD+bowAjxKDM31YIdX92jiPgbgvBBMn05CHY7nU6
	 Ivl5lM8xsdQR3UoNYRb4d2MZVZbHDeiYHVM3BAXSKwTetsIjtGzg4+D+QCACyMRjWk33uaN1rkGz
	 Wy+TiAX4ix28fLwuKvClP5F1aSj2nF66FDqi/IzWaKva2Vv3mTASJfu99z6ydrHF9g65Mfw9p7Av
	 zHcb7GkHKxZ4hMiiLxTOHTVxStcVoBQcLvFls/uFBs3lxjC+ruiX3iM09DN76hB0Avy5hSSWkwHp
	 qvuP7dEC4nEuljYiIAuo6tcLLpN/OsQs7zMqgTahf5dkb2HGO9r/0OGjfPDSzq88QirGJwTTFNCY
	 ZW7V0RCU3vb2mHKVpSLZCYlbABwkeZFbt8/cAGlhlQ4XZHguH+CEyJ0omuYe3khFgaVnBc9f5AHV
	 cMkBEEoPrvIxT4Mj5Pl371iY504g8qEyKh13fD51c64/gpZnSduzXZT52S8v3n2k5848hAEmzKZb
	 e857yzKpKV5zCfaS7RmsL9zh1rYjKmf6glPmgGIXSXC9fj5cPiIHj5Wmkk93esTA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: stephen.smalley.work@gmail.com
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] selinux: access sid under READ/WRITE_ONCE
Date: Wed, 12 Mar 2025 09:05:23 +0800
X-OQ-MSGID: <20250312010522.232131-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAEjxPJ7eFbsn7h7o90tOE6ymp4+g-bwYL_Rwy6t0EcxpaBAxAA@mail.gmail.com>
References: <CAEjxPJ7eFbsn7h7o90tOE6ymp4+g-bwYL_Rwy6t0EcxpaBAxAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 11:19:49 -0400, Stephen Smalley wrote:
> > Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=00c633585760c05507c3
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > V1 -> V2: replace with READ_ONCE/WRITE_ONCE
> 
> Thanks for the patch. Did you audit all other users of sksec->sid to
> see if they too should be wrapped with READ_ONCE()/WRITE_ONCE() or are
> already safe?
This fix is only for the issues reported by syzbot+00c633585760c05507c3.
I have confirmed that there are many contexts related to "sksec->sid" (at
least 29). I am not familiar with selinux, and it is unnecessary to do
excessive fixes before syzbot reports other issues.

Maybe the subject of my patch is not appropriate, and it may be more
appropriate to adjust it to "selinux: fix data race in socket create and
receive skb".

BR,
Edward

