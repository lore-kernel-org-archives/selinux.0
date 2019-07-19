Return-Path: <SRS0=dlxx=VQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07159C7618F
	for <selinux@archiver.kernel.org>; Fri, 19 Jul 2019 20:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AF42186A
	for <selinux@archiver.kernel.org>; Fri, 19 Jul 2019 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BzeQ46IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfGSUC3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:02:29 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44002
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbfGSUC3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jul 2019 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563566546; bh=qeE1e3etaziWp3w+RWUgDzIJ0smrTNQvePO0N+EDU6Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BzeQ46IVvrSR5FtVQJmyEQm/xCpKRoa7Zj/i3q8Z9mw0SSTdyjBYwO4aH+7rjcEONGn0u654NhvsA2n9S4XK4IvNUZfhYt6E+oL5N3iUQTzZYmg9xrhaOeUHnMP88rLBOlnGu06XPq1KQ+rESl2nHFpsq/Yk5DYUw/YpWxhViAc1BtuusrBgiOs8/eankhVKa65eadEhmkhq2ufv73XlbuFfRx1EAI5iwMQfhPrMneRXAi9JpKvF223srafRq4bwoff8BmhEBV0Uq0aTWZ6xuaJ3vM24x8mSVBJfGLXoxYoZq1XEtqm1AvO6OqKos8SNejfaf+7Lk9mqu5GdBq8OEg==
X-YMail-OSG: eA3bt2QVM1mMfr87TvzKJDa_xqj.8izvqJkwu5W2lP1I02cAi8pmOvVBvSWL4TH
 NuJ2KpIl_CbwvOtkVBsyUY.ehJelzcJR7V4Qc.Ulpcb1.aI2vVwFF2h4HxAzUoKZg7GTq_UPyRqX
 1hFOECjv00JB_vkUJFTTK8jAsK3fyypb1SZ1xfgUbpzGIX0oqE.E8d1hBTYg6oJQC68POuuKxYSj
 4saE9NauToATvBAUJwbNPUYX0.kTqmwvK33ccsDtrio2_XccPPtITbiV44K7KGFFSQ4KAXzMEead
 h1ydO1N6dejyOzpyLg7NEnKXwxYyVoSoqD9g95hMTTvyotsyBoA32oRZsLEhsm4mzEPSfPrQOKKl
 U7pij.Ww5K82Wiwmpdq.9QNsVmVXl.DVH28E3woqSl0.JJJb5rQui6VvsLuKSRcCL1532sDrX8ri
 8kqTd9aleh2.Tsnx4D_x4H3oXaK5sPTFySFskTQ9mwlg9_ZFlbNs0lD0xHnW85neqKYN3Es9MNSW
 QAhdkRNhufZK0Qrz5ewTvv.oAZq0.B5VSNnJK.aM5jWszawSMlKN.tKGe7ntx7yg0NPftluYsT3Z
 kgggALWcVPoQW_IaVMHt6IwgSPQLIwx0UcHJ87TDklM9EaZ.t31mTc2fWdhk7QUbI4z189OU_jsf
 bfPnnXGdKHxrFllODbMgCgajRLWi3Vgc.3CpLsu_mqOjN3XzTDJffaJO_9K72V1GFJZOg0nuvy5T
 JOMBh.lHo9C_4Kj8lUfbrYur88iJ1aLgXgcN7h9KqYOmGolSa7T08Ol.R1KGMyOMAeyo4.EAVT11
 XzpovffddzPGevqrkNynlGk6dZnaYhPklBD1RYLKeTjj1YEejt_kbgEwAvNPRpLY2qkZaq4Z8PBB
 fv20e7O1N2muUD0j4uFEenquB8SGiTyXtNitZmIh6_dhFEC76MGTZAkrd6pctnhm5FDa1apL0Ly0
 8i8pZ91WGXELbgJySjG7ufrAF3CMFcmPeWbiNl1pvJ30y9uj9TJV0EcOJjk5jSefEL4ujlY0c87y
 z3y7b7DXvJ21PVYPwWY4qkRnmMBf6qDZcBLGwX8Z5HaDsEGbDabgIlAg1VQCUamhfzSg498jwyXN
 DfbWlavl6PJFVaxEsDFPD5fjQjK5DOxJNHAQ4_YLk2n6bCohDYJt88nx9P_R5VtFV7j2ae22LQyf
 e2PBfmKB0VzHDCzVD4WuNvF3FVMd3llpiq4qg0.I0AODiCv3SQ4xhjX9fcbKcrMtAfo4dGo5fkI.
 udusGj0qmGHafiA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Jul 2019 20:02:26 +0000
Received: by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 678414199c710243eb384f38fea31f5f;
          Fri, 19 Jul 2019 20:02:26 +0000 (UTC)
Subject: Dbus and multiple LSMs (was Preferred subj= with multiple LSMs)
To:     Simon McVittie <smcv@collabora.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com,
        SELinux <selinux@vger.kernel.org>
References: <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <20190718131034.GA12581@horizon>
 <45661e97-2ed0-22e5-992e-5d562ff11488@schaufler-ca.com>
 <20190719121540.GA1764@horizon>
 <720880ca-834c-1986-3baf-021c67221ae2@schaufler-ca.com>
 <20190719184720.GB24836@horizon>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <700301b3-b607-3234-15ae-b958df2b59d3@schaufler-ca.com>
Date:   Fri, 19 Jul 2019 13:02:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719184720.GB24836@horizon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/19/2019 11:47 AM, Simon McVittie wrote:
> Thanks for considering user-space in this, and sorry if I'm hijacking
> this thread a bit (but I think some of the things I'm raising might be
> equally applicable for audit subjects).

Thank you for asking these questions. I think that if we
can address the issues around dbus we'll be in pretty good
shape in general.

> On Fri, 19 Jul 2019 at 09:29:17 -0700, Casey Schaufler wrote:
>> On 7/19/2019 5:15 AM, Simon McVittie wrote:
>>> However, I think it would be great to have multiple-"big"-LSM-aware
>>> replacements for those interfaces, which present the various LSMs as
>>> multiple parallel credentials.
>> Defining what would go into liblsm* is a task that has fallen to
>> the chicken/egg paradox. We can't really define how the user-space
>> should work without knowing how the kernel will work, and we can't
>> solidify how the kernel will work until we know what user-space
>> can use.
> I was hoping the syscall wrappers in glibc would be a viable user-space=

> interface to the small amount of LSM stuff that dbus needs to use in an=

> LSM-agnostic way. That's what we use in dbus at the moment (in practice=

> just getsockopt, but I'd also be reading /proc/self/attr/current if the=
re
> was a specification for how to normalize it to match SO_PEERSEC results=
)
> and it's no harder than the rest of the syscall-level APIs.

I don't see how to do that without making the Fedora and Ubuntu user spac=
e
environments remain functional.

> A single LSM-agnostic shared library would be the next best thing from
> my point of view.

Good, that's how it looks to me as well.

>> An option that hasn't been discussed is a display option to provide
>> the Hideous format for applications that know that's what they want.
>> Write "hideous" into /proc/self/attr/display, and from then on you
>> get selinux=3D'a:b:c:d',apparmor=3D'z'. This could be used widely in l=
iblsm
>> interfaces.
> If the way to parse/split it is documented, then this would be easier
> for dbus-daemon than continually resetting attr/display. It would be
> especially good if you can document a way to find out which one of the
> many labels would have been seen by an older user-space process that ne=
ver
> wrote to attr/display ("it's the first one in the list" would be fine),=

> so that we can put that one in our backwards-compatible API to clients.=


/sys/kernel/security/lsm provides the list of all LSMs active on the syst=
em.
It would be trivial to add /sys/kernel/security/default-display-lsm which=

would contain that.

> Or, alternatively, we could pass it on directly to our clients and let
> *them* parse it (possibly by using liblsm), the same way AppArmor-aware=

> D-Bus clients have to know how to use either aa_splitcon() or their
> own parsing to go from the raw SO_PEERSEC result
> "/usr/bin/firefox (enforce)" to the pair ("/usr/bin/firefox", "enforce"=
)
> that they probably actually wanted.
>
>>> Do you mean that if process 11111 writes (for example) "apparmor" int=
o
>>> /proc/11111/attr/display, and then reads /proc/22222/attr/current
>>> or queries the SO_PEERSEC of a socket opened by process 22222,
>>> it will specifically see 22222's AppArmor label and not 22222's SELin=
ux
>>> label?
>> Process 11111 would see the AppArmor label when reading
>> /proc/22222/attr/current. The display value is controlled
>> by process 11111 so that it can control what data it wants
>> to see.
> OK, that's what I'd hoped.
>
>> The display is set at the task level, so should be thread safe.
> OK, good. However, thinking more about this, I have other concerns:
>
> * In library code that can be used by a thread (task) that also uses ot=
her
>   arbitrary libraries, or in an executable that uses libraries that mig=
ht
>   be interested in LSMs, the only safe way to deal with attr/display wo=
uld
>   be this sequence:
>
>     - write desired value to /proc/self/attr/display
>     - immediately read /proc/other/attr/current or query SO_PEERSEC
>
>   and it would not be safe to rely on writing /proc/self/attr/display
>   just once at startup, because some other library might have already
>   changed it between startup and the actual read. Paradoxically, this
>   maximizes the chance of breaking a reader that was relying on writing=

>   /proc/self/attr/display once during startup.
>
> * If an async signal handler needs to know a LSM label for whatever
>   reason, it will break anything in the same thread that was relying on=

>   that sequence, because it might have interrupted them between their
>   write and their read:
>
>     main execution path                  signal handler
>     -------------------                  --------------
>
>     write "apparmor" to attr/display
>     (interrupted by async signal)
>                                          write "selinux" to attr/displa=
y
>                                          read attr/current or SO_PEERSE=
C
>                                          do other stuff with SELinux la=
bel
>                                          return
>     (resumes)
>     read attr/current or SO_PEERSEC
>     expect an AppArmor label
>     get a SELinux label
>     sadness ensues
>
>   Of course it's probably crazy for an async signal handler to do
>   this... but people do lots of odd things in async signal handlers,
>   and open(), read(), write(), getsockopt() are all async-signal-safe
>   functions, so it's at least arguably valid.

Stephen Smalley has already pointed out some of these issues.
I see display being used in scripts:

	echo apparmor > /proc/self/attr/display
	apparmor-do-stuff --options --deamon

much more than inside new or updated programs.

>> Writing to display does not require privilege, as it affects only
>> the current process. The display is inherited on fork and reset on
>> a privileged exec.
> Another concern here: are you sure it shouldn't be reset on *any*
> exec?

Yes, because so much of the user-space ecosystem depends on programs
that rarely get updated there has to be a way to specify it externally.
I don't like the situation, but we can't ignore it.

> Lots of programs (including dbus-daemon) fork-and-exec arbitrary
> child processes that come from a different codebase not under our
> control and aren't necessarily LSM-stacking-aware. I don't really want
> to have to reset /proc/self/attr/display in our increasingly crowded
> after-fork-but-before-exec code path (which, according to POSIX, is not=

> a safe place to invoke any non-async-signal-safe function, so we can't
> easily do error handling if something goes wrong there).

My hope is that new and updated programs will have to tools
they need to get it right, and that those that don't won't
fall over on a well configured system.

> Is there any possibility of having a parallel kernel API that,
> if it exists, always returns the whole stack, maybe something
> like /proc/<pid>/attr/current_stack and the SO_PEERSECLABELS that I
> suggested previously,

/proc/<pid>/attr/current_stack is easy. SO_PEERSECLABELS will be
harder to sell, but would not be hard to implement if we can get
agreement on the Hideous format.
=C2=A0

> instead of repurposing /proc/<pid>/attr/current
> and SO_PEERSEC to have contents that vary according to ambient process
> state in their reader?

In addition, yes. Instead of? I don't think that we can have a
backward compatibility story that flies without it.

>  (Bonus points if they are documented/defined with
> a particular syntactic normalization this time, unlike the situation
> with /proc/<pid>/attr/current and SO_PEERSEC where in principle you
> need LSM-specific knowledge to know whether a trailing "\n" or "\0"
> is safe to discard.)

I think that's necessary.

>
>     smcv

