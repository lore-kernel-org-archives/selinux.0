Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09NMuM7028206
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 18:22:56 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so7625753wid.5
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 15:22:54 -0800 (PST)
Message-ID: <1389309772.20258.6.camel@x220.localdomain>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Dominick Grift <dominick.grift@gmail.com>
To: Eric Paris <eparis@parisplace.org>
Date: Fri, 10 Jan 2014 00:22:52 +0100
In-Reply-To: <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain> <1453694.LHeEgrvlzg@sifl>
 <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 18:07 -0500, Eric Paris wrote:

> 
> I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....

For what it is worth ; i would not prefer the name invalid_label

Although it is an accurate name i do not think its optimal, i would go
for "invalid" with the invalid_t type sid associated with it.

Invalid_label can give the impression that the whole context is invalid,
and although the context as a whole is invalid, it is usually only due
to one or more invalid sids (usually just one).

By leaving out the "label" part, you leave less room for
misinterpretation.

Not a big deal i know..
