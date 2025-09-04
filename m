Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A612305043
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998427; cv=none; b=DK3r9JTUOSWjZglRHAeiq9pVKWKEjJbdaQDJOOabOZCrR/FttfWUmsqVLn7ULtbbFQc8qT8gVh/p2xTs949oQVk1+MRaLsS78quvG6cEPVck3cbuaG/gHLUCN/IH8/tTmaj/sbsxDmkkule82Rpph6RBU21R8R7dTmW4DnPhwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998427; c=relaxed/simple;
	bh=WdSMSR85x87X0+DfffqCowskGNW4tPHLqZlvNo3jcgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e1oXNkjKBkcXBPIeAQf8tWhvso1sr3TkwDqn/Y6j1bK+x4WBfgLHvH+ASH/X2OwPqgnmjercR7WMPoF6S258w4zURZD/uE/i3XfcZwmwwX/aI1QkdjLzAxo0Uczu0t2vlnnO1xiXENksD4xIkmxtnCfw9kCtMs/l4px/6u2RtlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870219dce3so105027939f.0
        for <selinux@vger.kernel.org>; Thu, 04 Sep 2025 08:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998425; x=1757603225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLO91xyldPwJGtv4KAJ9Dss03Zr2mNg6Ty96jb715OM=;
        b=QL0G5v9iR02Iyys7bypKaH1OaSMTrmuhiCg5ubqrkS7qs4S5IACJm9MfyKcxhc/KRq
         VHQWuWUWI8EdfH1V9RVzKaQZDijR19VU3JSqS1/kKTiGBULgJXBILuTkOJh40Usfb85U
         d54oj1tJ+Kan2HTNOGTiddPYfS2/NKSI2lhotIBC3i9hxyOw7M6UFfdACX2pGWd+WQg7
         kallNYOC+tdgPQmPcRioSkGGL6F0h8c07o2Hoi8/JLYI8e2nvxfrmt4rQTlUo9YxeyTe
         Pt2gWpRnDD+py9rRutPEs02vr0XNN3N/VFHwOy2rhTcaK1u9740luxHgYUjXLauKNqcJ
         H6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUoneLb8v3UJse6u5d+4duPElg5xse/Dtar05HxhxFdfuWNPHUXhwcoyBOz91UzdqtBkfu+UAfk@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTPya46FtWRZQnBjZZN0bSEvxvT3Pedv42HlNoiT3UL8LaP2S
	HqoLokQq+84ZTLZEulTFvBYirdABVmdF3mcNDoe1XWVpy//wgVItAQ3pjpCVZPDPYoJEDh3O9FL
	TdWcA/Q2Z2ZgHFrC1fmzp57TYNAO7KZvOR2BTla5vjH7cqxGx457qCUOBYp8=
X-Google-Smtp-Source: AGHT+IGPt5XXPZQ71LRSq35os/98bkbkleFEzJZRK9KO1wphEAorWaJE0sjRcGoS9N8q2GtO62tIzPc9fUr+UXPnANVDnXDcNjgk
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:3ef:969c:c91 with SMTP id
 e9e14a558f8ab-3f400097800mr372808605ab.6.1756998424765; Thu, 04 Sep 2025
 08:07:04 -0700 (PDT)
Date: Thu, 04 Sep 2025 08:07:04 -0700
In-Reply-To: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9ab18.050a0220.192772.0008.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
From: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
To: apparmor@lists.ubuntu.com, audit@vger.kernel.org, casey@schaufler-ca.com, 
	davem@davemloft.net, edumazet@google.com, eparis@redhat.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jmorris@namei.org, 
	john.johansen@canonical.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	paul@paul-moore.com, peterz@infradead.org, selinux@vger.kernel.org, 
	serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit eb59d494eebd4c5414728a35cdea6a0ba78ff26e
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Sat Aug 16 17:28:58 2025 +0000

    audit: add record for multiple task security contexts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1199fe62580000
start commit:   5d50cf9f7cf2 Add linux-next specific files for 20250903
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1399fe62580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1599fe62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d2429dff5531d80
dashboard link: https://syzkaller.appspot.com/bug?extid=bb185b018a51f8d91fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b9a312580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16819e62580000

Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
