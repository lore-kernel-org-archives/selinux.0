Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347911DED53;
	Tue, 28 Jan 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087031; cv=none; b=PA0e1XaherdkYG6yGsNQix+Y2JJgI1f4fBBg6txk69AUYhpoImb9QWy+YR0PiMbZsXnjdF0pWIc2EUa/zm8AVYOnsPCZyIpkEQmrGjkXEkzfbsKP/A4ma4XI6vAifiCZbbkgcw+fjJeW7DFce/3SyzjgEdB2jCYUCKQOcOSUfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087031; c=relaxed/simple;
	bh=UZQ7tBlYbmh1YkCm30NavXRziQ8ENbEWDWNd4K9+gas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1yHG2PsZQLE0qEICbP0MzOiDPsodxcbn7s4JptExiyFmLzkBzh0jjAlRrWaTNr6lpJQAiw/PKanVdqfIsXHBwkQH+xhFkkyCoMw1PhSipienYIYXDo4o/D+UGnUtSPhx7LNkn1vbcjaN/st/CP09c5dKNQOaBQlqAI0O+R+i50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WUvZu+Qu; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WUvZu+Qu"
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3d20:0:640:8692:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id E192161CCE;
	Tue, 28 Jan 2025 20:49:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Qnh9LH1OkGk0-mjztRRHZ;
	Tue, 28 Jan 2025 20:49:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738086567; bh=4bF+K/7ZU1KzCV1atn1iaxgfwJ16GOCJPyuj5wi9FcA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=WUvZu+QuX9BoY5m6dCCoggBcX+m6kjC8/gEG9IvvUSOz63QpFRCM7GjjHJ7T5qA5z
	 upX/JSYrbb2mB739LzMpKhxtan+uerXKf9AxCVSNXVniZXotTdVtonLYEde3YBN12V
	 T+avEznDPYLi0oHfL3iqxD66TLUCnGPGstO/SiHo=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
Date: Tue, 28 Jan 2025 20:49:26 +0300
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

28.01.2025 18:04, Willem de Bruijn пишет:
> Ondrej Mosnacek wrote:
>> On Mon, Jan 27, 2025 at 3:50 PM Willem de Bruijn
>> <willemdebruijn.kernel@gmail.com> wrote:
>>> stsp wrote:
>>>> 27.01.2025 12:10, Ondrej Mosnacek пишет:
>>>>> Hello,
>>>>>
>>>>> It looks like the commit in $SUBJ may have introduced an unintended
>>>>> change in behavior. According to the commit message, the intent was to
>>>>> require just one of {user, group} to match instead of both, which
>>>>> sounds reasonable, but the commit also changes the behavior for when
>>>>> neither of tun->owner and tun->group is set. Before the commit the
>>>>> access was always allowed, while after the commit CAP_NET_ADMIN is
>>>>> required in this case.
>>>>>
>>>>> I'm asking because the tun_tap subtest of selinux-testuite [1] started
>>>>> to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
>>>>> so I'm trying to figure out if we need to change the test or if it
>>>>> needs to be fixed in the kernel.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> [1] https://github.com/SELinuxProject/selinux-testsuite/
>>>>>
>>>> Hi, IMHO having the persistent
>>>> TAP device inaccessible by anyone
>>>> but the CAP_NET_ADMIN is rather
>>>> useless, so the compatibility should
>>>> be restored on the kernel side.
>>>> I'd raise the questions about adding
>>>> the CAP_NET_ADMIN checks into
>>>> TUNSETOWNER and/or TUNSETPERSIST,
>>>> but this particular change to TUNSETIFF,
>>>> at least on my side, was unintentional.
>>>>
>>>> Sorry about that. :(
>>> Thanks for the report Ondrej.
>>>
>>> Agreed that we need to reinstate this. I suggest this explicit
>>> extra branch after the more likely cases:
>>>
>>>          @@ -585,6 +585,9 @@ static inline bool tun_capable(struct tun_struct *tun)
>>>                          return 1;
>>>                  if (gid_valid(tun->group) && in_egroup_p(tun->group))
>>>                          return 1;
>>>          +       if (!uid_valid(tun->owner) && !gid_valid(tun->group))
>>>          +               return 1;
>>>          +
>>>                  return 0;
>>>           }
>> That could work, but the semantics become a bit weird, actually: When
>> you set both uid and gid, one of them needs to match. If you unset
>> uid/gid, you get a stricter condition (gid/uid must match).
> I don't follow this point.
>
> Judging from the history, the intent was that
>
> - if user is set, then it must match.
> - if group is set, then it must match.
>
> And I think the group constraint was added with the idea that no one
> would try to use both constraints at the same time.
>
> The referenced patch intended to (only) relax the condition when both
> are set after all.
>
>> And if you
>> then also unset the other one, you suddenly get a less strict
>> condition than the first two - nothing has to match. Might be
>> acceptable, but it may confuse people unless well documented.
> I find that ownership is optional and must be set explicitly through
> TUNSETOWNER and TUNSETGROUP quite surprising too.
>
> But this is only reverting to long established behavior.
>
>> Also there is another smaller issue in the new code that I forgot to
>> mention - with LSMs (such as SELinux) the ns_capable() call will
>> produce an audit record when the capability is denied by an LSM. These
>> audit records are meant to indicate that the permission was needed but
>> denied and that the policy was either breached or needs to be
>> adjusted. Therefore, the ns_capable() call should ideally only happen
>> after the user/group checks so that only accesses that actually
>> wouldn't succeed without the capability yield an audit record.
>>
>> So I would suggest this version:
>>
>> static inline bool tun_capable(struct tun_struct *tun)
>> {
>>      const struct cred *cred = current_cred();
>>      struct net *net = dev_net(tun->dev);
>>
>>      if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
>>          return 1;
>>      if (gid_valid(tun->group) && in_egroup_p(tun->group))
>>          return 1;
>>      if (!uid_valid(tun->owner) && !gid_valid(tun->group))
>>          return 1;
>>      return ns_capable(net->user_ns, CAP_NET_ADMIN);
>> }
> Improvement makes sense, thanks.
>
> One more point, based on the problem description in the referenced
> patch:
>
>      Currently tun checks the group permission even if the user have matched.
>      Besides going against the usual permission semantic, this has a
>      very interesting implication: if the tun group is not among the
>      supplementary groups of the tun user, then effectively no one can
>      access the tun device.
>
> The intent was to skip the group check if the user matches. Not
> necessarily the reverse.
>
> To minimize the impact of the patch, perhaps it can still always deny
> if tun->owner is set and does not match. That keeps the group check
> iff the owner is not explicitly set as well.

Doesn't this mean, if the user
is set then group is completely
ignored?
By doing that you indeed avoid
the problem of "completely
inaccessible tap". However, that
breaks my setup, as I really
intended to provide tap to the
owner and the unrelated group.
This is because, eg when setting
a CI job, you can add the needed
user to the needed group, but
you also need to re-login, which
is not always possible. :(

Also completely ignoring group
when the user is set, is somewhat
questionable. At the very least,
perhaps then you need to explicitly
clear the group when the user
is set, to avoid the confusion.
Having "either user or group"
sounds like a sensible semantic,
but its a different semantic.

