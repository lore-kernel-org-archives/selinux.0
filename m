Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A21ACDFD
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055368; cv=none; b=CbiZb5U+OWZkGV5vMrCHOUKHdugOP+bX0YqqpXZcQxGAtlOgz+Us/yi2Xwc2CU/x+7IsA6OKRVmCOpBFBRsCd9ktBoFbvH61CAj32yZe1yH/6KL5vyPeozNbrRH1y6fxtczwmh76+etXxG/fSQ3INQKNr0vMzfzH6vzOcGfsmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055368; c=relaxed/simple;
	bh=JYXsxaF1px/OX7lqED4hoe0RnjUVmLdxWEnlN4WkO/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lcLTNKaalrMCgh2ktHCiFz1Xny5sS4ROfca+dJw5GtfyP8GMzzZdmleNkUfRQvZPXFyNZHmueGPKnPq8CWCub9JhHh9J9oh7L4pFWtmo5QJknYi7mpWhccRdn1acvRCNdjxyHmCe/8fTdQ8s++w9RKT/IeFPGRlZcHZIVejofJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fnsVQ9gf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fnsVQ9gf"
Received: from [100.96.192.252] (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FBD0201337F;
	Thu, 13 Nov 2025 09:36:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FBD0201337F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763055360;
	bh=lzxqDK6OT6UhsC8zT4Ak1jisB4QKXKqzgMWivY++JHQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fnsVQ9gfOwO9+Y+H2xO9SbEOVPoBlWAHqt4w9jzgcZLACSNNAYDha8UKOGAFbVt2s
	 u1jWA9yYid/blZ58KrAL1i7TQCPq8QpiRy+Ybb9RyOQ3UUYRqcxjHlDALgwfOGKsMc
	 okNjz7VJHWSWpjbprj9ovd8Zb982Ajp1lal67jGE=
Message-ID: <394ce63e-2ea0-4b0f-9196-bb47c6721f85@linux.microsoft.com>
Date: Thu, 13 Nov 2025 12:35:59 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: William Roberts <bill.c.roberts@gmail.com>,
 SElinux list <selinux@vger.kernel.org>
References: <20251110180935.202229-1-vmojzis@redhat.com>
 <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
 <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
 <0d41ceb7-5173-4360-a746-c258e86089e8@linux.microsoft.com>
 <CAFftDdoTR5ae1qORSjPuOj5ea1O15qtgrRiadhTp2HMh926swg@mail.gmail.com>
 <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2025 7:43 PM, William Roberts wrote:
> On Tue, Nov 11, 2025 at 10:34 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
>>
>> <snip>
>>>>> I'm no longer an SELinux maintainer, so don't let my nack stop anyone.
>>>
>>> We have a need for a similar use case in terms of ensuring that
>>> restorecon actually performed relabeling, but I agree that I don't think
>>> this patch as is would meet our needs.
>>>
>>> One thing that might make the patch more usable and address these
>>> comments would be to instead pass the expected number of relabels as an
>>> argument to restorecon and then return success if the relabel count ==
>>> the expected count.  That avoids all the problems around exit code
>>> handling while still verifying the count.
>>>
>>> The other problem though is that in the presence of globbing it's not
>>> clear that getting the expected number of files relabeled means that you
>>> actually relabeled the files you expected to.  But I guess the answer to
>>> that is just "don't use the count feature with globbing".  Even without
>>> globbing though, if you don't relabel all the files, you don't know
>>> which one you skipped without extra handling, which seems like you
>>> really don't need to know the number relabeled as much as whether it was
>>> the number you expected, which seems like a point in favor of "pass the
>>> expected count".
>>>
>>
> 
> Sorry I accidentally sent this only to Daniel, adding back the list.
> 
> With -v doesn't restorecon show what would be changed? Perhaps it
> would be better
> to add an option that produces some standard formatting for an audit
> trail and that output
> could include various statistics. Then folks could parse those
> records. I see -p does some form
> of progress/status meter as well, for whatever that is worth.
> 
> <snip>

My two cents FWIW is that being able to see whether you actually 
relabeled via exit status is way more useful than having to parse output 
to get at that info.  There's no need for the complexity of the wrapper, 
no opportunities for parser bugs, and you can just directly succeed/fail 
a systemd unit or bash script based on the return code.

-Daniel
