Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6JL9Ear023050
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 17:09:14 -0400
Received: by mail-lf0-f66.google.com with SMTP id p11so578299lfd.1
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 14:09:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALCETrWaEAMnxujZ4Y5NY+hO3zLD8nNr+VaL9gJ=4_B8hw6=Pw@mail.gmail.com>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <CALCETrWaEAMnxujZ4Y5NY+hO3zLD8nNr+VaL9gJ=4_B8hw6=Pw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jul 2017 17:08:03 -0400
Message-ID: <CAHC9VhTSvcoxZ9uird=eJcgiisyiG2PykLvJ8kniWn7q64yXrA@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 17, 2017 at 4:06 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jul 14, 2017 at 9:46 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> At the risk of commenting on SELinux in general:
>
>> There is no way to clone all allow rules from
>> descendants to their ancestors in policy currently, and doing so would
>> be undesirable even if it were practical, as it requires leaking
>> permissions to objects and operations into ancestor domains that could
>> weaken their own security in order to allow them to the descendants
>> (e.g. if a descendant requires execmem permission, then so do all of
>> its ancestors ...
>
> In my mind, permissions like execmem aren't in the same category as
> normal permissions.  execmem is the right to do something that opens
> the subject to compromise, not the right to do something to an object
> that needs protection.  Maybe execmem should be exempt from
> typebounds.

I just realized that this got lost in the rest of the discussion ...

It's worth nothing that from a practical point of bounded type
transitions aren't likely going to be the solution that will likely be
used to solve this current systemd problem (see the rest of the
thread).

However, I understand you were speaking in general terms, and while
there may be some merit to your suggestion, that would be quite a
deviation from how things work at the moment and unless typebounds
takes off (which I am beginning to doubt will happen outside a few
special domains) I'm not sure it is worth the effort and headache.

-- 
paul moore
www.paul-moore.com
