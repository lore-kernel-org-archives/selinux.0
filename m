Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990451;
	b=KfcmCQkVtZpqJ6zRSwX1vfGFaXik7Z5JUmrz4Y2Pn9Sx404033ZnkXmbS36gfAm3mAds
	 oDQVTdjT0rsgaxdxf7o4tCAfGUkjdA060Ug/iW+FojXwVYl3aXkQYme/YNrLrH/SButsT
	 QB6oehIk0+knhk65UxcgQty35i1bfM+z70n+DW6MwbbzuiveeqfSVU+3QsN+4Q2XArIOj
	 yLQwbhLk9wDBLWz9GRRfkpavE/GGonzmoJ02Ki8l9d6LV3TRYVRycIbaHkMTL8URmgsgd
	 Hh2r+gwJpqsLRXukJwZXwyrKSNnr1dh8afOq6ltrbhVYFuBCj8/Z/BsIhmCWUU863Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4qciyvRDi7BLRo1X+5yaNx5Sjg5GpHBAuBx0NgTdZJM=;
	b=rs2YD5MtfzsIAiQ7qHKDfbE1X/dauzhpKWu6Hqpg4G7OzdY7OwZtyVZ/5VE+ONnTq0ab
	 iFj1eo2IuuEQoAFLJA77jufl/RjYmdWMsn0Hf8FiOSnu1COQ2J81MyJkf44z5DsjaZ66b
	 bU0OR4Lv/deyEbKtarLj84iaQ4v2R1hRt0uiitYc5ImSAyBCbLkM1CEH++9FhVKZ5ZEmV
	 plHrozv0Q/KY9DHe2e5RGUnfaYUstd4XrfOqbAXpGA4ZCzGj/ulg6ifiXOyrDBGlgzvc1
	 5TVFGocx6ITicz5qgoa1Dc0dRLd+r/mWWTs3SsZdLUfqdhdGMYGqzCUTHO41JSBdYSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uFXL+2Qp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654A606D806
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2654A606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uFXL+2Qp
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so1150676d50.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793990450; cv=none;
        d=google.com; s=arc-20260327;
        b=AvA3pucERO5AgtMuGpNngNAp5e5cCzVSV7YUB5uodKTcsp3zP7vwNIWsA0G2HXhIsI
         zeh0jjQtSE92nnuYcOqNnnW8Y7zIxICNTscWhdEK9Uzlk6+9kzkIEWzC2/eZQeDI147o
         AEmK4IfC+wBBDQC+nJUzWs471fyM+Y/1W8V8tDrqEg02y9zg3oV7tesitYI31pXnnyjH
         DTyjbH4HpQARtbhU5DXvW6em3QkckN8sl2oh8Woz43XlVnGbtso+EyzSzV9b72JYxeUv
         93qifeQAieh1NQWk1Q1FeudKURDu+f6KRFkV+/ToyA+20W0VevNizMmbtf+MC4ZbC2cG
         Nk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qciyvRDi7BLRo1X+5yaNx5Sjg5GpHBAuBx0NgTdZJM=;
        fh=JHL+dlBtetZKWAunLGWKbt14h50PoOUW6V+T78x38Ms=;
        b=JnPvMSMtqGGd6BDr8eAUxM4yd1VmrTS38T+rL3VXMCEh2J9hVgFbdpb5n4ShajjbWr
         Wqbbh1OwoiTI/jKhtDbz6RvuLe2LmtScl6NuoADEkFW13a/YCTQvD6lCn7k7I4bW8yO7
         gMWrtebLhktl/JXTCsiM3clTWug4E9Ui/2lAcAktHN1OwdsovDCcjE70ssDwS64oImVq
         MgHqjKTZ0vAlGZrnWZdf3o4N3a3xdFVUbvB/ODCp2lBy97BA9zUuLy1n7m1i40AcYHuh
         pSvPkpZO3lWdpnvxymvX7xe9eWdgu0KGGeJ5khmqzdtTjWXbtU6mAvplF4oVJsAqgUgB
         uAXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990450; x=1794595250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4qciyvRDi7BLRo1X+5yaNx5Sjg5GpHBAuBx0NgTdZJM=;
        b=uFXL+2Qpkn6uX0bfbqs0H0EiIZuipa3Cjh4XHArv1x2RzA1E97p5+z04/M7b9xQpk6
         1PcVE663nGa5TGS5+pitl9jb8V8CfnDqAl3na+pycqS/ahdr5zN98TDEvmYoAl1/Kylg
         Q38I2gGHTAnEfVDmiGMkhpc+cunNeV/FNKOLThu07oELan/7wLUDkf2hJYRFXTeYIQWd
         swMBxCCJXi8zVu8aQyg5y2Q9F9TzEK5qN/+aju8NvZKfGrl7o/hTA1Qqo0abv0zivp8u
         Gs1v942bp/J2tceHrbl+NDDA4izeh3MQLnLzrA8zlT19hd5oTiYV4EhV/WNzbBFpfnTn
         piwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990450; x=1794595250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4qciyvRDi7BLRo1X+5yaNx5Sjg5GpHBAuBx0NgTdZJM=;
        b=DPdarTPlUjFXvujUk+EJpC3ukTOAdFwXAnDfEeABZfhtO8Jlnk/wQuJsoY1aGjXTNE
         MlqXHqVjOqx3JmEzK4g8Twv0xMI7g/uzKGgRwGnAmiVO5P/DyXV9MGPgEMYl2BeAUomX
         Y2R3L1AgbPdewyE1QCPmrGOccOD4Jsz5bwuQR26Yn6o0VujDy4J3W5xdXWHjJ2AmuAXd
         Q4OV+0whQ9hFQHpKDKDg84jbqpo4BU+jQDj63azkxhjmZVBP0HbKNvVv2phPCe9a0I4h
         ipc3l5GDJq+ATpewqzZPZR/l/OKNGN5L1oFfSQSji/jtwymlZOb7Uhg/Elxav1Q8XpmQ
         amEw==
X-Gm-Message-State: APuU4Z8m7R8HRLq3LDsccTm9MVeQ28o5FhV0EpCS7nHJ8l6V2q0PbOoY
	LlkcWtO7p0OtZP7cWtXo1R9a5gWZr8ZvHKNi9iup7FD8PG9f5UJNq0YSNWW9GrDtSZbpZKWA4wn
	PlS1I6RwE4hCraCVtylA73xqUPPSLBEVkv6p2
X-Gm-Gg: AYBFou3NUU7ciU7W71QsYIvKx98IxSk3l79i/OzKDnxjKWnNkPWcGkhGbARaCGTLkbQ
	Kja2W5Muor8287dWvPcuA3k/dJD6/ulxjW9PS7dTSpswDZBh8TdHNFRKvBOQnEXv2LVcljuZvkA
	VWT0A8vZ1WgMO+qOdAHAAsMQ4ibB6VMtowWSgqGUJuqHZGmXJMqp5XCr5QfLDPeCCMs8/Y7X1O1
	tTqMrJHJMdmq5RJ+Du3WXypUInRJqPES0JHtUsBurA2r7Vf8G90wFtBfYOFFMtYToPAYfLxQVjc
	g4t6dNpOgjHrgftQzrKGo0j4tmNXsjLjHldcKwRINOjsk0CaaoDF4wyiRa5dgGnl1zPqDkwrmou
	tZtXAM4g2jPQJcbRZtL5KvS4y174GZ6fOvOuzZPcV7CRVEFK+WTqvgHUimy7DbAasxTV9azs/1o
	LyxM/ZOELZNQZ/4UKYgDB/0sEbwZMSR1pBKu4YBLlN97bdkk+UIbPmQRNU57b8VVT74bvmTPMr3
	TXV2LY=
X-Received: by 2002:a05:690e:169c:b0:675:6f9d:dd53 with SMTP id
 956f58d0204a3-67c1406eb1amr1732214d50.8.1793990450191; Fri, 06 Nov 2026
 10:40:50 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928142354.17638-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260928142354.17638-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 13:40:39 -0500
X-Gm-Features: AclHuK_8ZDdiU5yG0w0ljwuEX6Qkq2Bi9PhU5wag8pLJmKAK81qW8vDdRWMaKjc
Message-ID: <CAEjxPJ6mP-zsHV5Kj+TM1wJzw0_Vw=aKD=cpe9c6sYhD0EVe9g@mail.gmail.com>
Subject: Re: [PATCH testsuite] Revert "tests/nfs_filesystem: comment out
 failing mount"
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:24=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This reverts commit 0815abcd70b382e13592264ce39bf48742421cc8.  The
> linked kernel patch below fixes the underlying kernel bug that
> prevented us from successfully running this test.
>
> Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.smal=
ley.work@gmail.com/
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This is also now merged.
