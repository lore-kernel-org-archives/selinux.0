Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C4F2FD665
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062333; cv=none; b=HXjmxeLp5QueAoSjCOniBvMv7UWGSDB1tyd7WdG5jxYEc8dnTTdh8d3fdkUMGYeCw3xBecZnj5iYsmG7ZX5tjwRVrVTK6CUsIUykn77XdRQDR1T21MdcCb1L3s9C5pTbsUUjRTKLULdwVXfXUDFJeHlybafZS0zu3x3mJzpWvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062333; c=relaxed/simple;
	bh=5fngXuiCaA7sqBvqDP8TjCVcbhDi2XG9DkpHeNOF81c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ74eMAzjEWk+viXVpODIxoLbrU2GLXBcGYXfR7lWUm43yCaAAcA+U97Y1bX1h8j3B3aLmN1YHltZV6Ga7yhHvJEw8shFtNYhULR0qilNOwuQ3pG4WlHQ0338kCR/zsZLe7FpQPkmbcXJnxOaMsct0lm4OtVTnFKbKthr8j3foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ilhwpcii; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ilhwpcii"
Received: from [100.96.192.252] (unknown [52.177.6.190])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC0BB201AE5D;
	Thu, 13 Nov 2025 11:32:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC0BB201AE5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763062331;
	bh=f6KjPYXddmanVaDfKsmxkx1NYe7BLnN6zwNJFk+3bKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ilhwpciiVFZvQdFbQE/O27qLNZwsfwxurxUsBwr+C2wh71UNhbGp4ctPj/yRHbVBv
	 59iE85hLOEIJ0p4p8NG5hJZCwOr3oxfqFgBkytJJdeCq6zvG7XBg1aXVcbC7i/zP0X
	 bmiI4wcUUZewrrMN2EH7J5qEAItPLJliPXgE9Mp0=
Message-ID: <cef4f1aa-c289-4f50-9738-4922f1330e95@linux.microsoft.com>
Date: Thu, 13 Nov 2025 14:32:09 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: William Roberts <bill.c.roberts@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
References: <20251110180935.202229-1-vmojzis@redhat.com>
 <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
 <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
 <0d41ceb7-5173-4360-a746-c258e86089e8@linux.microsoft.com>
 <CAFftDdoTR5ae1qORSjPuOj5ea1O15qtgrRiadhTp2HMh926swg@mail.gmail.com>
 <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
 <394ce63e-2ea0-4b0f-9196-bb47c6721f85@linux.microsoft.com>
 <CAFftDdrJ=Grx6_eHZXs5L0bN88WS7bG7XRBMHtgtYLBdYCXSuQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAFftDdrJ=Grx6_eHZXs5L0bN88WS7bG7XRBMHtgtYLBdYCXSuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/2025 2:29 PM, William Roberts wrote:
> On Thu, Nov 13, 2025 at 11:36 AM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>>
>> On 11/12/2025 7:43 PM, William Roberts wrote:
>>> On Tue, Nov 11, 2025 at 10:34 AM William Roberts
>>> <bill.c.roberts@gmail.com> wrote:
>>>>
>>>> <snip>
>>>>>>> I'm no longer an SELinux maintainer, so don't let my nack stop anyone.
>>>>>
>>>>> We have a need for a similar use case in terms of ensuring that
>>>>> restorecon actually performed relabeling, but I agree that I don't think
>>>>> this patch as is would meet our needs.
>>>>>
>>>>> One thing that might make the patch more usable and address these
>>>>> comments would be to instead pass the expected number of relabels as an
>>>>> argument to restorecon and then return success if the relabel count ==
>>>>> the expected count.  That avoids all the problems around exit code
>>>>> handling while still verifying the count.
>>>>>
>>>>> The other problem though is that in the presence of globbing it's not
>>>>> clear that getting the expected number of files relabeled means that you
>>>>> actually relabeled the files you expected to.  But I guess the answer to
>>>>> that is just "don't use the count feature with globbing".  Even without
>>>>> globbing though, if you don't relabel all the files, you don't know
>>>>> which one you skipped without extra handling, which seems like you
>>>>> really don't need to know the number relabeled as much as whether it was
>>>>> the number you expected, which seems like a point in favor of "pass the
>>>>> expected count".
>>>>>
>>>>
>>>
>>> Sorry I accidentally sent this only to Daniel, adding back the list.
>>>
>>> With -v doesn't restorecon show what would be changed? Perhaps it
>>> would be better
>>> to add an option that produces some standard formatting for an audit
>>> trail and that output
>>> could include various statistics. Then folks could parse those
>>> records. I see -p does some form
>>> of progress/status meter as well, for whatever that is worth.
>>>
>>> <snip>
>>
>> My two cents FWIW is that being able to see whether you actually
>> relabeled via exit status is way more useful than having to parse output
>> to get at that info.  There's no need for the complexity of the wrapper,
>> no opportunities for parser bugs, and you can just directly succeed/fail
>> a systemd unit or bash script based on the return code.
> 
> How would someone distinguish between error and one file labeled? It's
> also clipped to a very small
> number, so will it really be useful on larger file systems?

No, I agree with your concern about returning the number of files 
relabeled.  My suggestion was:

 > One thing that might make the patch more usable and address these
 > comments would be to instead pass the expected number of relabels as an
 > argument to restorecon and then return success if the relabel count ==
 > the expected count.  That avoids all the problems around exit code
 > handling while still verifying the count.

> 
> We can simplify the output to stdout is just the number then no
> parsing needed, albeit
> we may want to look at the verbose option and define a format for that
> as well (not now, future work).
> So folks could do -vc or -c and have a way to get an audit trail of
> files and a count independently.
> The last line will always be the number in base 10 with a newline.
> POSIX shells will strip that
> in assignments from command substitution, so you can still just use
> the number directly.
> 
> For -c:
> set -e
> x="$(restorecon -c)"
> if x == 400; then
>    whatever
> fi
> 
> For -cv:
> x="$(restorecon -cv | tail -n1)"
> if x == 400; then
>    whatever
> fi

That may not strictly be "parsing", but it's still added complexity vs 
checking a return code.

-Daniel
