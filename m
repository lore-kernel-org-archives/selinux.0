Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3169288DB
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528942; cv=none; b=N56mdSzhQREt/Fobnp9zEmali5yNGf/0aybMzwq82gm8H+S9AEwTnFCZsPej9McE5O84TMZHKzntC58bjeSpfYYizuwg98sIGjywcaCPkbycbP1Bs9XEySIycPF7PPvI+NuojqzESKYDd4tLF8pKap3XxREjCDjenvhBo1RnSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528942; c=relaxed/simple;
	bh=tLaTkb+47AwmWJXfVP2MoQouKNaHjdmUiApVVQq6Cf8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iqzl3FRFGYpM9Fb7umdIHLw446UHcMsi968O2AstoG9PBvyJKMEXX/Lgs42ip5js90NAHMS1PWZ7alA4rLWgu02pAggxovWD3gLWNPszruzVt4JSCuGbn3Vvz5PlYz93hFo9L79Q+DLLFXYniL6mUeBvOB2IL1/G4iO5iLbF9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=atOkFH0Z; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="atOkFH0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1748528939;
	bh=tLaTkb+47AwmWJXfVP2MoQouKNaHjdmUiApVVQq6Cf8=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=atOkFH0Zo/fnMuqxzh8mVqQadrkKeCgrthFAN9NZVEURSVdkSiNf4BwBdWrQSHLKY
	 HqmrNW8s+gJy6tuFhcOaF1Nksbl6c9LbcKEeVa3hH+jBP7oSaNmN5O2BbFIU9eg3Uk
	 IKjImNtI0AAUSVm2Mf/xdNN1CEdfyktHdWYyFlc8=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 549DC19CDFC
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 16:28:59 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Subject: Re: possible regression with filecon equivalency
In-Reply-To: <87ecw7ts9b.fsf@defensec.nl> (Dominick Grift's message of "Thu,
	29 May 2025 16:18:24 +0200")
References: <87ldqftsxd.fsf@defensec.nl> <87ecw7ts9b.fsf@defensec.nl>
Date: Thu, 29 May 2025 16:28:59 +0200
Message-ID: <87a56vtrro.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominick Grift <dominick.grift@defensec.nl> writes:

In case its not clear. To clarify. I treat /usr/sbin like /usr/bin this
works fine. until it gets nested:

/fooroot / # treat /fooroot like / (works)
/fooroot/usr/sbin /usr/bin # treat /fooroot/usr/sbin like /usr/bin (no
longer works but use to work)

So now /fooroot/usr/sbin gets a label the equivalent of /usr because it
ignores to /fooroot/usr/sbin /usr/bin equivalency rule.

I hope that clears it up. I rely on this functionality.

> Dominick Grift <dominick.grift@defensec.nl> writes:
>
> example was too simple. Its more complicated:
>
> root@nimbus:~# matchpathcon -m dir /
> /       sys.id:sys.role:root.file:s0
> root@nimbus:~# matchpathcon -m dir /blaroot
> /blaroot        sys.id:sys.role:unknown.file:s0
> root@nimbus:~# matchpathcon -m dir /usr/bin
> /usr/bin        sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /usr/sbin
> /usr/sbin       sys.id:sys.role:exec.file:s0
> root@nimbus:~# cat >> /etc/selinux/dssp5-debian/contexts/files/file_contexts.subs_dist <<'EOF'
>> /blaroot /
>> /blaroot/usr/sbin /usr/bin
>> EOF
> root@nimbus:~# matchpathcon -m dir /
> /       sys.id:sys.role:root.file:s0
> root@nimbus:~# matchpathcon -m dir /blaroot
> /blaroot        sys.id:sys.role:root.file:s0
> root@nimbus:~# matchpathcon -m dir /usr/bin
> /usr/bin        sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /usr/sbin
> /usr/sbin       sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /blaroot/usr/sbin
> /blaroot/usr/sbin       sys.id:sys.role:data.file:s0
>
>> This worked a while ago:
>>
>> root@nimbus:~# cat >> /etc/selinux/dssp5-debian/contexts/files/file_contexts.subs_dist <<'EOF'
>>> /foo /usr/bin
>>> /sysroot/foo /usr/bin
>>> EOF
>>
>> root@nimbus:~# matchpathcon -m dir /usr/bin
>> /usr/bin        sys.id:sys.role:exec.file:s0
>> root@nimbus:~# matchpathcon -m dir /foo
>> /foo    sys.id:sys.role:exec.file:s0
>> root@nimbus:~# matchpathcon -m dir /sysroot/foo
>> /sysroot/foo    sys.id:sys.role:unknown.file:s0
>>
>> What happened?

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
