Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAD204096;
	Thu, 11 Sep 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597151; cv=none; b=gwyF4FSfuayzWe7j6pSsok+yAsVq1RBB7KRNvKYKdGdXNldSLqTrTnzR5P/S8v157AXFAt7MmA9Al6zx1j+H3cGUVSVH9vIkLuDE4a+7xUVWJxjuy/zT+WoxG+kRRNknKaIQV3DoFXcqahwtfqF/VezUJQqtZO4HZdfdPf+RwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597151; c=relaxed/simple;
	bh=FIMY/3NZ6Rz/ebm9TPGOIX0XStBA+bqI6cEJjsslY9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNaQQY3eTXXhtlWCsBoWtGv3xpa+gbcWC7Cxl1tb2fTZz32Iab4qmurhMM6Kpln5Rl29PfPIi1XPXKNONoc6JX1s3WGiI6ZvT4ueSrtiN2TXpmaxy3aX7a898mbc14Y+VLDUQ5RMxxdWcCfVrhg1IKbSrS8woun2a9Un+Ks4pjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baDCvOhg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baDCvOhg"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so454333a12.1;
        Thu, 11 Sep 2025 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597149; x=1758201949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMtSHaulXrhyRXZXHDwWRgMU8kQQ1GTRKtPp9+9HmKI=;
        b=baDCvOhgC8hs5OlsSfJ1FZoUUbx2Grm2RrT+MbypI6NoCpGsQdgmN5Ahe6S+VdxRec
         DoajYrJ78gm6D55VCUk5rq1UNV/5EfSlQUZindHo+76pKrvGRcNHnG030DhEr/lWWVoF
         1pFpklWQCSEoZTike9XERlWptminst0BA3V/ZBaKbOMUOFGf9+sivQ7XfIs3//+MOmlD
         DDBVEwvk8LNs2QxOlockBSDRTAKYi2VfGTyZJJeCk2t6/JNbM4Z217VVBNv14pyLqVbf
         8LJHGT+KI+yfbhUp1hnEw1qM20xs5dWM0Q3d0+8l7h+rathjjHNqRXXiVYXL/iW6EBHQ
         upeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597149; x=1758201949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMtSHaulXrhyRXZXHDwWRgMU8kQQ1GTRKtPp9+9HmKI=;
        b=iC1/cu3f21P0wG/QmMAQbD5PlRqTZkehx7fSGCwuV8KdOuO7+B2TqOUiEAdjNDvhJr
         Y8ZlZYC+L89jSINOAr09ly96POIwo2KRq61Z/kT0+b5rAvMgszto82pK+Wxsd9Q00lyH
         IRydHM82/mJVpoKkywXHLSvh5rc1GVIkOol5KCn33OC2lWJbvkNFSUOUfJhIuv3CcwBr
         gwg0vxcIiKYg3JHgUpyGax3vhbAZq0ZoZ2kUsyZBGMJxxyLnVkCmld7XZrhgbjUlSaoQ
         tXcAfTfeyYJDXjnJ2aaL0phu21pguaNww9mhn1LVOwWW1OQFAQEWX+3NGoijc0EjVjnJ
         VoKw==
X-Forwarded-Encrypted: i=1; AJvYcCW7KoaeiSkCriYJLVsZM7WOsoKm3/4L9/dvK31Ie1vrHmRJ3ntOWqn+8svTmf3V7w38QmVFsVGB@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxrvW8Czzfud3mN0HAax1ELQTbe5qLmK1TnLG0IfiT+RD5V3E
	LMexQVUE/qetmZOcxdWSWodbKeolxpynJGjP+4pXw9H4SSkQ/c6Zg3V9EhFqj/DkaTZ1mV6vXVF
	0Q9yiUBpNk9wa/0FU6G95cI4LGY+JLFU=
X-Gm-Gg: ASbGncuBA06/lgP/51Wume8NeKUZ42G1gxoKTyOPwE6u81MrZ9P4NpPU0Pi9LUY8LNK
	xDiEV7ulGdwnIKeBUoWAcMcGqolx+g8LoAiT0RAV0o39N1asybX+6Xgri0glXY6IP8IZFejNRvZ
	gjhR5ll3LtXJn0pQs3V3ZgHPJ6HDsnDpRM05LJQosjaymRjbvV4+wLVX5rhsc77VQF2RSG8fdzK
	wHasOM=
X-Google-Smtp-Source: AGHT+IFkYH1X9yw/iBKEbT0ofFylkWgGn23ocaHAuJDNdtfa3OMZZcsxvlopvVBM2ETIvs3vzosAHW6bANHGVReJxnQ=
X-Received: by 2002:a17:90b:3c85:b0:32d:dd7c:c3d8 with SMTP id
 98e67ed59e1d1-32ddd7cc580mr1215965a91.25.1757597149453; Thu, 11 Sep 2025
 06:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4-+WfGPLev5QU_+_NgBx68zdBBQ6x_+aonzbk4f9BNEw@mail.gmail.com>
 <20250911130653.967139-1-zhanghongru@xiaomi.com> <CAEjxPJ6upN5e7XD9HC970pKvHox-qPjZLdzm=bV-tu8GgFrYoA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6upN5e7XD9HC970pKvHox-qPjZLdzm=bV-tu8GgFrYoA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 09:25:38 -0400
X-Gm-Features: Ac12FXzA6a-Ajo7aWVfmOKrXqLP0A5E8_8atC7kIMPksDVQ-AJWjXL4er4kjKMg
Message-ID: <CAEjxPJ4naa66Aum5YO0jntY5-reXxF5Z-=JYTcmb7WFCBODAHg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 11, 2025 at 9:07=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail=
.com> wrote:
> >
> > > >  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> > > >  {
> > > > -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS =
- 1);
> > > > +       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots =
- 1);
> > >
> > > If you are making the number of buckets adjustable, you should also
> > > change the hash function to better deal with multiple numbers of
> >
> > Thank you for the advice. When running the test model, I sampled
> > /sys/fs/selinux/avc/hash_stats once per second for a total of 1800 time=
s
> > and analyzed the distribution uniformity of the hash algorithm using th=
e
> > sampled data.
> >
> > Baseline: 512 nodes, 512 buckets
> > Comparison: 8192 nodes, 8192 buckets
> >
> > Metrics (Average value over 1800 samples):
> > * Bucket utilization rate (higher -> better, same chain length assumed)
> >         * Baseline: 52.5%
> >         * Comparison: 49.5%
> > * Max chain length (lower -> better, positive correlation with worst-ca=
se latency)
> >         * Baseline: 7.5
> >         * Comparison: 11.4
> >
> > Experimental results show that scaling buckets and nodes from 512 to 81=
92:
> > 1. The distribution uniformity under the current hash algorithm does no=
t
> > degrade significantly;
> > 2. The maximum chain length rise significantly, potentially degrading
> > worst-case performance (ignoring other code in avc_search_node function=
).
> >
> > Details:
> > url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b1795
> >
> > I will modify the hash algorithm in the avc_hash function and collect d=
ata
> > again to see if we can achieve performance improvements.
>
> If you look elsewhere in the SELinux code, you'll see that others have
> been converting other hash tables to using the jhash functions, so may
> want to try those here too.

Or you could follow the example of ss/avtab.c which was converted to
MurmurHash3.
