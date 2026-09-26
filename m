Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03E3A6EE3
	for <selinux@vger.kernel.org>; Sat, 26 Sep 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790409399; cv=none; b=R9UQRf+swnMqeL1Uj+4kGgMjusNAfiDguYw35ZyCDUgMcl0k3gXW4Ywb4Z9eCdt0YQxg1kSkW/Yq6VktVRA2ugod91fbSUAs6maE5S0GxADm2ncDREMzSw5agtTei/uF2wAhDUtDNJGwJnbjeCCR734hb7iseK6SqaO32PrFiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790409399; c=relaxed/simple;
	bh=yY5aPVN1kZdRX24f/rOo18N2WyJh702NUMPAilvlSUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAG5jFiGkez/G7tQxboECa5AN5W+FeAHLyLtAcLrmQRF5OTMMTu0SMEQad4T3j3zkTvreBcSD3oOekY0mFRmXRl5baHCE9SWEZFZoZkei6LzL6TIuhTgT086aiswFoDL6lFVDXNu730N+44W31lcKmIATNno0kIAkeiVGumi2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7sMzVkW; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7sMzVkW"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so548687f8f.1
        for <selinux@vger.kernel.org>; Sat, 26 Sep 2026 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790409395; x=1791014195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YI9LML6UkRl05Tm2nCgeCpB6+5W0fxaRHeYbqDyeGfo=;
        b=k7sMzVkWtbUDbbp4+aRtCSwDYg/N9rlz5NFwvHo0ICgZGz2vAj1arjCTNFVVNezR16
         /Ct47msFKVJf6LN2vVRfnO34+ZDkjssZdw6W3qAaFsAWlcL7BNXDy1FA2VflXUW56lSt
         3ZZjWRd5JTtGPcuQLzV0GCBCGh840Ak32mWas3lf2k1lgPMuNRRsWyFoUL+Ed/qnlU6U
         +qDtYx3WR7Jqscy8bKzg+pZYCzGu1rSnBgortOuci/G1L04E4zKswMx1/ZTwSTlxLLCD
         r8wNC5Uyyd/2qpi54K+mrUFtFa75uqS95saZ22AN2yr2mWIdpnEPm/XnVjnVdFRJLXmP
         ltGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790409395; x=1791014195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YI9LML6UkRl05Tm2nCgeCpB6+5W0fxaRHeYbqDyeGfo=;
        b=LLS4pHde9VeKEPrBPDjVzGNWQCy/uXlk0YUBA/0vyYyEtHSydWxs6T6k0TV4l2KOp/
         CYZiLjOIz8zkLsAQIHvA0kA29jRnDCaVsQgmPru7WyIdbZDqxcZuhaY2MiIdOmE+j0Fu
         6q2OjNhq0XLAYVcOZXfps8+syt/C/JQ4kUUaFQROcxAd9BimCgHPW40CgrIxoaeUqnFN
         f3Kh0THQ4Ri+te72PgWsr3wr7oW7lMfhNvfU7bjcu3dETw3KseuvzUGeYbnJ3GAsjJK5
         bc0NDduPKN46DEuoH4nLXIfJEwaErQczWlrBgtxfITEqywpxlqwowjc0tVcWA2E8TIWt
         8qcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3YpXeG0heZQQ806oazBZuW2KCqZKvlVs+ySktcvoEc7fTAPpnaPRXvETvnDOB+6lWjCYp7xDp@vger.kernel.org
X-Gm-Message-State: AFuF++ngBzd4xtsiBQ+LWQmPP4irkDkrxJc1deOG4xq31OKbYB2wkk0b
	DrOCb/hZYOZ9DJ+6UFArqd3HR+u7KAQfJdE4oCelDl9YPzy/YWE5LiTa
X-Gm-Gg: AYBFou2ys8sZOG6rt9WUB0Lix3Qc8H2+pv6/T2kDjD7aTBJTu9bwwSddOJOFpONdzL4
	rv27Ae0II4YHX0NmfHXRIjffEQQXh244JGsmx6SNDyStlY/0HUbry09ESF6PFSaA64Qx5m1xiX9
	ST92jjpO676BLl6RFn72gjJc6gBOCQLJPWFd/695/EcNY50XAN26oFGCDHlYy1FWmPV+F5HIhDL
	RfKm65Kh3+HhmTcK3HN3GLcdcZxGZU3pUVl71cPj+1TKHYnEeZBuUsF3otD5fJlfVF4cBd0N2gR
	6Q1lcRIf8Ku/bPd1YTPeIACcNmisvuGLkEaLklz/UY/ks8LJggFuDKhNIjdD+jem7TaqCVH04fs
	icjsk9NPAh5Rpz7Zkdcrb7BDPcR2NDmalFD3IZA5SyCoOu6knam4XN/2KOG9Hf7Z4IZA5HSx+sb
	g7WqvDSZ/CN5AarUe9e/1YRy+kQf9CzyfcbObSYBUyxCxXSNdbpwnwRPZSBhX1HPXcDzf9TGgJK
	x8UNw8x8K4jEaS5XcGZRuo=
X-Received: by 2002:a05:600c:8b82:b0:49f:fefc:7d01 with SMTP id 5b1f17b1804b1-49ffefc7e4dmr2208755e9.15.1790409394348;
        Sat, 26 Sep 2026 00:56:34 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe667ae2fsm204215155e9.13.2026.09.26.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:56:33 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:56:28 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Cai Xinchen <caixinchen1@huawei.com>, mic@digikod.net,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org,
	rdunlap@infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dlemoal@kernel.org, hch@lst.de,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, dhowells@redhat.com, code@tyhicks.com,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, miklos@szeredi.hu, amir73il@gmail.com,
	senozhatsky@chromium.org, chenxiaosong@chenxiaosong.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com, omosnacek@gmail.com,
	casey@schaufler-ca.com, nanx95726@gmail.com, djwong@kernel.org,
	daniel@iogearbox.net, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	xiujianfeng@huawei.com, lujialin4@huawei.com
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Message-ID: <20260926.255b951d3013@gnoack.org>
References: <20260924104831.1081137-1-caixinchen1@huawei.com>
 <araxO4ze0KZBz756@suesslenovo>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <araxO4ze0KZBz756@suesslenovo>

Hello!

On Fri, Sep 25, 2026 at 02:03:05PM -0400, Justin Suess wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed in
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
> > 
> > Landlock evaluates access rights on a per-path basis, but the metadata
> > related LSM hooks (inode_getattr, inode_setattr, inode_setxattr,
> > inode_getxattr, inode_listxattr, inode_removexattr, inode_set_acl,
> > inode_get_acl, inode_remove_acl) only receive the dentry of the accessed
> > object.  Patches 1-7 therefore first pass struct path instead of dentry
> > through the metadata-related VFS helpers and LSM hooks.  This is a pure
> > refactoring with no behavior change, split so that every patch builds
> > and works on its own:
> >
> I like these patches, but is the ability to read metadata already
> sorta controlled by LANDLOCK_ACCESS_FS_READ_DIR on the parent
> directory?
> 
> The one case I see this being different is:
> 
> 1. if you wanted to grant read access to the file, but not metadata
> read access, but I can't think of any usecase for being able to read
> the contents of a file, but not the metadata. (see below)
> 
> 2. If you had the absolute path already and didn't need READ_DIR.
> 
> I see introducing this READ_METADATA as causing potential
> hard-to-diagnose issues.
> 
> Say you handle READ_METADATA and READ_FILE, but only grant READ_FILE.
> 
> The program can technically open the file with the READ_FILE permission,
> but it may error out because the stat() on it beforehand failed.
> It's pretty common for programs to do that kind of thing (stat before
> open), like for checking for config files (strace bash and you see it
> stat .profile, /etc/profile)
> 
> There may be other bugs, because being able to set permissions to read
> a file *but not read it's metadata* isn't possible currently in posix
> acl and userspace may not work well if that assumption no longer holds.
> 
> So maybe WRITE_METADATA is good enough?

The existing use cases are the combinations of (a) READ_DIR
allowed/denied and (b) READ_METADATA allowed/denied.  Because these
two access rights overlap slightly, it seems likely that for a given
directory or file, users will want to either grant both, or deny both.

At the moment, where the (not yet existing) READ_METADATA is
implicitly always allowed, the problematic case is the one where the
Landlock user wants to deny READ_DIR, but where much of the same
metadata is still available through stat() and the various
get-attribute syscalls.  (c.f. the warning box in the Landlock docs
[1])

In my view the READ_METADATA right closes a gap that READ_DIR left
open (which is also potentially surprising to callers if they did not
read the docs closely).  Also, if its implementation is symmetric to
WRITE_METADATA, I feel that it's worth having it in the same patch
set.

–Günther

P.S.: I know, even after we can control stat(), there are likely ways
to infer the presence of a file by observing Landlock error codes.
This would be nice to fix as well, but is harder to do without
controlling the path walk itself [2].  But also, the fact that this is
currently not controllable is not an excuse for leaving READ_METADATA
open IMHO.

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
[2] https://github.com/landlock-lsm/linux/issues/9
