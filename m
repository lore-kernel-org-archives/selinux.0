Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F332B108
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067023; cv=none; b=LvqyHorXTOB6vYkzemxWmJ1WtfctxxHapocku8mkKFl2suhk7n4aUGY/R1pRWHZLcYqBRq7WEW0HfNBFV3g4Bal8ObG9eql4WT/7IpWq5yto6zuSM7RY8JA/A3qn/lO3B+ls46/KXdIhnYMZkSud43cukTb7/Bx6NtSc66l2W2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067023; c=relaxed/simple;
	bh=/BZteunWUuLJLH6bspsInS2xIfNPxz0Iy4dyQd3NFTQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=aTbNJ2uwBmuGjTLhCx+X2Hicb1SoxFKc3qv97zSAcmm8mbKx+udsG1gXZipXkACiMcBlJ5tPR8WBdXrKBJmAlfG866XyYIzW5fEN1tW4fZOmYRxGrRPAXZWyvwYPGwsm89uQbo0ou3QFoTIapX++S2IdtlduSO7XSJ93RiaOEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lr4mijoa; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lr4mijoa"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee88fce572so21285296d6.1
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784067020; x=1784671820; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cf8dsbSDIi2GC0LgRjk6ppSiN0uKevcq+Q3KeCIsFs=;
        b=Lr4mijoauZFoNwzr9Kov5glQnnPYahM0Q59CS+mbMrNCyMeJIVcEp3F/jn1dZrGL7L
         lyRwiskhC6foUekYWMJTVgBXpNivlA+aLrFyh/UygPPEsJwZ6Av5Z7ZOko+Q+uWNnnLd
         hU344rI4M7grnZiZ52oE962EhG9fkMdjjfHTrWQ7W6xRUIoE0+DQnlS1oqXIe6SRZhVq
         /0hFkrdgN6y0QnLTSCBm8nClPpaMiij1fYdhhJizKiv7L11bx/cJ12NVYlGlIc/YjnRw
         L7MrPWopZEzJ7Boi+mtgfV9zpOr+1C0TtRXCWBMtEBSdX+x5JboX4IdKPlXcPRgXQDNp
         wWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784067020; x=1784671820;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cf8dsbSDIi2GC0LgRjk6ppSiN0uKevcq+Q3KeCIsFs=;
        b=LOHUzzKebbK+GWwIDuGcQ1pFBSwVKH4AWtbY0Xzf7EOeD+VTIrab8ZEIP0bmJRCsat
         RPZT3GJ8F9KrHOa8g1JeDC1+g86JtdMUvzmcVFthsQeKoHUMqgiTFRtHJ6QJ7Q28pEfV
         TBNOQwb5cVh2N8gGOQ0XkcttEdnuqb65gXHhCRId7Jw6BMH9ReX8DdwJTrPnl/S0RiOH
         x/fM0Nutfo+szvNe6Cuk4/lZ1tLkWGhBRtcOu9HyMLbBxt971jGe6+rNWu5Sl5biOuxl
         UsEwg31Jj/Q9lERDKokjT/j2jusV5jKse2PVSQkI564WfbK89ygChkyDv95tzt5j0pWw
         XWaA==
X-Forwarded-Encrypted: i=1; AHgh+RpLwLNQjjbeMqY7pXeK6ctu453rMcg7AP31ySKKo/anc67RnN/jzm5JWs5INcBvUZN+ry8dZI7O@vger.kernel.org
X-Gm-Message-State: AOJu0Yysx/2tEaIlmcB+lk9h3UrrRKJOeBqw/M/SQidnjNDchWJI5Xl3
	ojB3n8xzUPZvfRE1acpp+63IiigBPEMjy4p1UB6KVt0QwQt8F6UtaX+okJrBfdWKOg==
X-Gm-Gg: AfdE7cldGT1/YGeYgxmvaW7DH8wjKQWPq/jTLtwaqVXuZrPdkoD/BejWs3GXtjfjHqD
	kVXNcFv+4XuswtL3KyFBFiy1GuWvhu4qKPMQ9NgzAojwhoXBue51EOWwwOHpvu4t3azfBtjTAJ4
	OGnXwrxP2u61/WnZlDERhJB9wZ6PQ3lCC3D/vo3YD3FBvepu57CUn8Dx3MD8/NtBMt8Vk+7wIab
	tm3EiZVFq96xHrE3Iii7c5Qzg49pK/CxXTW/BAq3gQBvmaX8lrUuBTEPpv0BxaVfQCkm1CVSzLQ
	9T4jgp2RaaCfNlzWGTK+YZQ27Qsz3eVjmN23zyfdq46ZKq/eWGI+fvromzv0uKDFUUAQgJsatcV
	vZBZCfDZLHOtROoOxUvQeLFTUVR88vGb4JaVTXIlurulfhYfuiX/7dmlhnoxlz0Nn4YIy72DsZw
	yI2zLr38WBAQEdxEPIYGfL9dN8EFDE5rAx75qFwy3VK6ctIZxtPmLHzfYLSA==
X-Received: by 2002:a05:6214:3f82:b0:8f0:b75:c4aa with SMTP id 6a1803df08f44-904032619f0mr158194076d6.35.1784067020375;
        Tue, 14 Jul 2026 15:10:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm176759466d6.42.2026.07.14.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:10:19 -0700 (PDT)
Date: Tue, 14 Jul 2026 18:10:18 -0400
Message-ID: <1dd1d69569b2a1f83c34ffe6ccbba337@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260714_1805/pstg-lib:20260714_1432/pstg-pwork:20260714_1805
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2] selinux: fix incorrect execmem checks on overlayfs
References: <20260714125759.1042127-1-omosnace@redhat.com>
In-Reply-To: <20260714125759.1042127-1-omosnace@redhat.com>

On Jul 14, 2026 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> The commit fixing the overlayfs mmap() and mprotect() access checks
> failed to skip the execmem check in __file_map_prot_check() for the case
> where the "mounter check" is being performed. This check should be
> performed only against the credentials of the task that is calling
> mmap()/mprotect(), since it doesn't pertain to the file itself, but
> rather just gates the ability of the calling task to get an executable
> memory mapping in general.
> 
> The purpose of the "mounter check" is to guard against using an
> overlayfs mount to gain file access that would otherwise be denied to
> the mounter. For execmem this is not relevant, as there is no further
> file access granted based on it (notice that the file's context is not
> used as the target in the check), so checking it also against the
> mounter credentials would be incorrect.
> 
> Fix this by passing a boolean to [__]file_map_prot_check() and
> selinux_mmap_file_common() that indicates if we are doing the "mounter
> check" and skiping the execmem check in that case. Since this boolean
> also indicates if we use current_cred() or the mounter cred as the
> subject, also remove the "cred" argument from these functions and
> determine it based on the boolean and the file struct.
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: only access file->f_cred after checking file is not NULL
> 
>  security/selinux/hooks.c | 42 +++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)

Thanks for the update, this looks good to me.  I'm going to merge it into
selinux/stable-7.2 now and send it up to Linus later assuming all goes
well.

--
paul-moore.com
