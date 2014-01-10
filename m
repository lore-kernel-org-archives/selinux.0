Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0A0NWo0030856
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 19:23:33 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so3728342pbc.33
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 16:23:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1389309772.20258.6.camel@x220.localdomain>
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain>
 <1453694.LHeEgrvlzg@sifl>
 <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
 <1389309772.20258.6.camel@x220.localdomain>
Date: Thu, 9 Jan 2014 19:23:31 -0500
Message-ID: <CAHC9VhQnYC2gBgnqxOGgj74+VC6W7f6_URUSOdyPrEdRU=ydxw@mail.gmail.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Paul Moore <paul@paul-moore.com>
To: Dominick Grift <dominick.grift@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 9, 2014 at 6:22 PM, Dominick Grift <dominick.grift@gmail.com> wrote:
> On Thu, 2014-01-09 at 18:07 -0500, Eric Paris wrote:
>>
>> I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....
>
> For what it is worth ; i would not prefer the name invalid_label
>
> Although it is an accurate name i do not think its optimal, i would go
> for "invalid" with the invalid_t type sid associated with it.

I agree, I tend to like SECINITSID_INVALID/invalid/invalid_t a bit more.

> Invalid_label can give the impression that the whole context is invalid,
> and although the context as a whole is invalid, it is usually only due
> to one or more invalid sids (usually just one).

Don't forget that a sid, including the initial sids, represents a full
label/context.

-- 
paul moore
www.paul-moore.com
