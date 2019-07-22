Return-Path: <SRS0=8ULP=VT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85998C76194
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4782190F
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XU+yqo9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfGVQEu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:04:50 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:41674 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfGVQEu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jul 2019 12:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563811487; bh=Wi40ZJbGV7/MHYoYYbKtPMJtdXVZqbMN3tuZcsUYgnY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=XU+yqo9uM8cJF5/nmRoFU+VhHMs5VIKMgHecXIcDNi4sC2vcgjwNclwmC5XsS5BEy0bPW0UDo+MThQ0y/e1UOVmAe8NnQ5qdbGgE4vl3A4TLE+7owyDFAGtjv5vkszPxiQOpS8yiGNQaoadPNTIIUDNjTuIgRxfMjdW/Rgqbv30xaE3Vc2lxP2rw4n/74J3923vz2/g8ARWvIlx1ryA2iufa7VnimckrQprb16qmlLnnm1wZ9rzIdohUC2WD32ax+ULfvV2V9dg7X4qQx0iyxtFM6sgR4McAc6nHNeXD2igcK4ry8fP6hUZOi5sGYdfboOYoXblk2GSxtlCMgXB+TQ==
X-YMail-OSG: Idj5FusVM1lpvV7WQTc4VXOeOPYrIRnxjuVKliWCglXgkTYzePHF7Whi7sNM4Ia
 iexXcPaMjRTUfZmknNQpMK96I.9oC34DdAYZo.yNYClxMJlb_P2hgX3xcjKzA_BrGn2BD6gnJ0d5
 dnkWQJBo.4wNwz.h.TlrLZ8P1wvxhWuDvYrP3sUmsk5My6mVyetuYz3aSGJSwzetdJdhp767qTl_
 TF0edHlpQEOikyfBAk4GW_lrS54SrAFS2s0CA9abfR1cWrEoSNprEhdjQSmTiNfMSTKbLlzvJJf9
 EV_9B7gHISWWOouvhzIcvC7N4I6Env1EDodKNSjfxAbUIne6H5cn9EXhQa.Z7NlTep44waqmmnpO
 2.xRcgB6NYk9j9v3SJvUGf.FBCIyUGV02j2l6iDtqbvhtd1j5i85l6aLuxz5m6gRjQRnsbK0W3bc
 VCSRPWH7uqMX8BjC52.iikwb7pJMY_L6RqKYOWuz7xM8gImwtd0V9DkKcpeZVRZCVXS0QIHWsEyq
 XloP8s4WrsPPHesZJQgTY7Xl4Xu.5lo0xPVp_y6kh0YwhXUB3FOrlCaMiZY.hPdboPc3L5lN7hgD
 I4zH1pu2In7H0ttnMaoSB1k4amzVrx9xCAmbnVyZebB3AyhEXGDlhNpyW.JWU5aFX06rUsluQd9v
 .DVWvKIY3WEu9Uflifbq4ZZjWDR5Iz3X2Rzq_LkD6X3a..gmCOqBSRmWeAzNQSKUqhW9aBjL5_Mo
 Wgz.Qh2zxLEG3NJoVv79fGRlzP8Dvzk0T9iWf.ZXu2UnjGjvjjEHjBiPHOot1Az2p.k69C1E63FA
 oMuX0cYxbmhfJbJR3gWEGNcCb_RjftZNVKjGAgFtZYt14BLmjdF6vVJciRpLHCJqtWqa06Whwad7
 Dh_uyrTAIS21yr5CTBqnAUD9R4fDeC5roIwL3MZ9iPu.WqfOV46EHV74kR9AVfU9lQGoHaL1Dy8E
 mb5SgggZmDkjI1HickSt3MlVa4IxeurAwzagnWY5XQ.D7Lk2y5pFYxmdA4tiVGpf3qeiADWziGME
 1p3RbRyoO5xZDZkLoyqDXBmATlsrFfpqWeMC7135L_zVWnTF3gQr38hiArVFezDMqyocETUS2y98
 Fq9mxAh5rnvyU2xObeOjIEG_ZPZkt9pKAprdJaxwFhOgP9umh.gwGa4hZHx8WNyfeHjYTsXQrpYQ
 G.a.qG5rHzHkt3mNGfWqDHCSFaWS4ijZbJZb8edyNOJCSuH2S7tRAzu5XCrnzWSKs5GpS6OlOk0K
 WPswI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Mon, 22 Jul 2019 16:04:47 +0000
Received: by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8c782ef6c5850b49bb5f5068a6ba651a;
          Mon, 22 Jul 2019 16:04:44 +0000 (UTC)
Subject: Re: Dbus and multiple LSMs (was Preferred subj= with multiple LSMs)
To:     Simon McVittie <smcv@collabora.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <20190718131034.GA12581@horizon>
 <45661e97-2ed0-22e5-992e-5d562ff11488@schaufler-ca.com>
 <20190719121540.GA1764@horizon>
 <720880ca-834c-1986-3baf-021c67221ae2@schaufler-ca.com>
 <20190719184720.GB24836@horizon>
 <700301b3-b607-3234-15ae-b958df2b59d3@schaufler-ca.com>
 <20190722113636.GA12250@horizon>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <25fa7464-cd7a-330f-5a61-8837dd1a8a82@schaufler-ca.com>
Date:   Mon, 22 Jul 2019 09:04:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722113636.GA12250@horizon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/22/2019 4:36 AM, Simon McVittie wrote:
> On Fri, 19 Jul 2019 at 13:02:24 -0700, Casey Schaufler wrote:
>> On 7/19/2019 11:47 AM, Simon McVittie wrote:
>>> I was hoping the syscall wrappers in glibc would be a viable user-spa=
ce
>>> interface to the small amount of LSM stuff that dbus needs to use in =
an
>>> LSM-agnostic way.
>> I don't see how to do that without making the Fedora and Ubuntu user s=
pace
>> environments [not] remain functional.
> What I was thinking of was a second, parallel kernel <-> user-space
> interface (like the SO_PEERSECLABELS that I suggested) for future/updat=
ed
> user-space components. SO_PEERSEC would continue to return some
> hopefully-backwards-compatible thing, but would be deprecated, because =
it
> cannot fully represent the reality of LSM stacking while remaining
> backwards-compatible.

I will propose SO_PEERCONTEXT and /proc/.../attr/stack/context,
both of which will use the Hideous format, in the next round. I
appreciate the suggestion and discussion.

>> I see display being used in scripts:
>>
>> 	echo apparmor > /proc/self/attr/display
>> 	apparmor-do-stuff --options --deamon
>>
>> much more than inside new or updated programs.
> Note that this implicitly relies on echo being a shell builtin, which
> is common but not guaranteed (I don't think). It would work in bash or
> dash, though.

Yes, echo being built-in can't be guaranteed. Most shells have some
way of doing the equivalent.

> If apparmor-do-stuff no longer works, and you have to wrap a shell
> script around it, isn't that the same amount of user-space breakage as
> if apparmor-do-stuff no longer works and you have to install a newer
> version that does work?

True when there is such a newer version. I'm sure you're aware
of how much system software out there hasn't been updated in this
century.

> Either way, the sysadmin must take action to
> change user-space components. I think the attr/display thing only reduc=
es
> the magnitude of the user-space changes required to catch up, and doesn=
't
> eliminate the fact that those changes were needed.

Agreed. It's a tool for the times of transition.

>>> Lots of programs (including dbus-daemon) fork-and-exec arbitrary
>>> child processes that come from a different codebase not under our
>>> control and aren't necessarily LSM-stacking-aware. I don't really wan=
t
>>> to have to reset /proc/self/attr/display in our increasingly crowded
>>> after-fork-but-before-exec code path
>> My hope is that new and updated programs will have to tools
>> they need to get it right, and that those that don't won't
>> fall over on a well configured system.
> The problem I see here is that if we assume dbus-daemon is a new/update=
d
> program that has set /proc/self/attr/display =3D "hideous" in order to =
get
> the full stack of labels for its peer processes, then it will be causin=
g
> side-effects on its separately-maintained child processes - they will
> no longer be able to benefit from the backwards-compatility thing where=

> /proc/self/attr/display (effectively) defaults to the first LSM that
> has labels, because dbus-daemon overrode that (unless dbus-daemon takes=

> action to reverse it between fork and exec). This partially defeats the=

> semi-backwards-compatible handling of the existing kernel interfaces.

Point. /proc/self/attr/stack/context and SO_PEERCONTEXT comprise a better=
,
more reliable solution.

> If dbus-daemon could read SO_PEERSECLABELS instead of SO_PEERSEC and
> read /proc/<pid>/attr/current_stack instead of /proc/<pid>/attr/current=
,
> leaving /proc/self/attr/display untouched, then this concern would go a=
way.

I agree.

> Similarly, dbus-daemon can be linked to libselinux and/or libapparmor
> (on Debian it's linked to both, even in the non-stackable present,
> and the right one for the kernel configuration is chosen at runtime).
> If one of those libraries wrote to /proc/self/attr/display, then the re=
st
> of dbus-daemon's main thread and all child processes would implicitly b=
e
> getting the result of that - even if dbus-daemon itself had not yet bee=
n
> updated for stacked LSMs (in which case it cannot be expected to revers=
e
> their action between fork and exec, because it's an older codebase that=

> doesn't yet know that "big" LSMs can be stacked).

Yes.

> So I think libselinux and libapparmor should be enhanced to use
> new kernel interfaces that get the label they want to get (either
> just that label, or all the labels), instead of being enhanced to
> write /proc/self/attr/display to change the meaning of old kernel
> interfaces. Otherwise they can break other code in their process or
> their subprocesses.

The AppArmor team is already moving away from using the /proc/self/attr
intefaces. /proc/self/attr/smack is already there, and the transition
begun. The SELinux developers seem firmly set in the position that there
is no reason they should ever change. In the long term I think we'll get
the conflict sorted out. It's hard to say what value of "long term"
we're looking at.=20

>>> instead of repurposing /proc/<pid>/attr/current
>>> and SO_PEERSEC to have contents that vary according to ambient proces=
s
>>> state in their reader?
>> In addition, yes. Instead of? I don't think that we can have a
>> backward compatibility story that flies without it.
> Consider only SELinux and AppArmor for a moment (I know there are other=

> "big" LSMs like Smack, but this same reasoning applies to any pair, wit=
h
> appropriate search-and-replace on their names).
>
> Neither SELinux nor AppArmor: there are no labels, nothing changed.
>
> AppArmor is the only "big" LSM in the stack (Ubuntu): previously,
> the label was the AppArmor label; now, if attr/display is not altered,
> the label is the one used by the first "big" LSM in the stack, which is=

> AppArmor. Nothing changed.
>
> SELinux is the only "big" LSM in the stack (Red Hat): same as for AppAr=
mor
> being the only "big" LSM in the stack, but with s/AppArmor/SELinux/.
>
> SELinux and AppArmor stacked: this is a situation that could not exist
> before, so distro/sysadmin action must have been necessary to make it
> happen. However much ambient process state is invented, I don't see any=

> way to make both SELinux and AppArmor user-space work without modificat=
ions:
> at least one of them (the one that is second in the stack) has to use n=
ew
> kernel interfaces, or alter attr/display to change the meaning of the o=
ld
> kernel interfaces, or something similar, to get the second LSM's labels=
=2E
> So distro/sysadmin action in user-space is also going to be necessary h=
ere
> whatever happens - backward compatibility has already been broken, it's=

> only a question of how intrusive the user-space changes are. Is it real=
ly
> so much worse if the distro/sysadmin action taken to update user-space
> has to take the form of using new kernel interfaces that always do the
> same thing, rather than changing the meaning of old kernel interfaces?

In addition to the big name distros/systems like RedHat, Ubuntu and
Android there are a bunch of smaller players who don't have the
expertise and/or staffing and/or upstream clout to update system
services. Some of these are targets for stacked LSMs. They will be
delighted to get updated programs, but will muddle through with the
compatibility mechanisms if they have to.

>     smcv

Thank you again for your insights on this topic. My next round
should provide what you've suggested.
=C2=A0


