Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6OKhg4g032517
 for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2017 16:43:42 -0400
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com
 [209.85.217.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE6A622CA1
 for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2017 20:43:34 +0000 (UTC)
Received: by mail-ua0-f172.google.com with SMTP id 80so87998137uas.0
 for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2017 13:43:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500556382.22177.4.camel@tycho.nsa.gov>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <CALCETrWaEAMnxujZ4Y5NY+hO3zLD8nNr+VaL9gJ=4_B8hw6=Pw@mail.gmail.com>
 <CAHC9VhTSvcoxZ9uird=eJcgiisyiG2PykLvJ8kniWn7q64yXrA@mail.gmail.com>
 <1500556382.22177.4.camel@tycho.nsa.gov>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 24 Jul 2017 13:43:13 -0700
Message-ID: <CALCETrWmWVwiyvO9QO1xZZwRo3uaCHwoqFmcdUV-LNxjgJrqrw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Andy Lutomirski <luto@kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 20, 2017 at 6:13 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-07-19 at 17:08 -0400, Paul Moore wrote:
>> On Mon, Jul 17, 2017 at 4:06 PM, Andy Lutomirski <luto@kernel.org>
>> wrote:
>> > On Fri, Jul 14, 2017 at 9:46 AM, Stephen Smalley <sds@tycho.nsa.gov
>> > > wrote:
>> >
>> > At the risk of commenting on SELinux in general:
>> >
>> > > There is no way to clone all allow rules from
>> > > descendants to their ancestors in policy currently, and doing so
>> > > would
>> > > be undesirable even if it were practical, as it requires leaking
>> > > permissions to objects and operations into ancestor domains that
>> > > could
>> > > weaken their own security in order to allow them to the
>> > > descendants
>> > > (e.g. if a descendant requires execmem permission, then so do all
>> > > of
>> > > its ancestors ...
>> >
>> > In my mind, permissions like execmem aren't in the same category as
>> > normal permissions.  execmem is the right to do something that
>> > opens
>> > the subject to compromise, not the right to do something to an
>> > object
>> > that needs protection.  Maybe execmem should be exempt from
>> > typebounds.
>>
>> I just realized that this got lost in the rest of the discussion ...
>>
>> It's worth nothing that from a practical point of bounded type
>> transitions aren't likely going to be the solution that will likely
>> be
>> used to solve this current systemd problem (see the rest of the
>> thread).
>>
>> However, I understand you were speaking in general terms, and while
>> there may be some merit to your suggestion, that would be quite a
>> deviation from how things work at the moment and unless typebounds
>> takes off (which I am beginning to doubt will happen outside a few
>> special domains) I'm not sure it is worth the effort and headache.
>
> I also don't see how execmem is fundamentally different than the other
> examples I gave in the patch description; there would still be the
> problem of leaking execute access to files, read to symlinks, ...
>

It depends on exactly what the goal is.  For conventional security, if
you can play evil games and get a privilege to, say, write a file,
then SELinux or its policy has failed.  If you can play evil games and
get execmem, it's not really a big deal.

If you're running an app store and trying to completely prevent the
execution of unsigned binary code, that's a different story, but it
doesn't seem like the existing SELinux policy language is really
geared toward this use case.
