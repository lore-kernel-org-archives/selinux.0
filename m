Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0ABqMGw027680
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 06:52:22 -0500
Received: by mail-wg0-f54.google.com with SMTP id x13so1021202wgg.21
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 03:52:20 -0800 (PST)
Message-ID: <1389354738.20258.20.camel@x220.localdomain>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Dominick Grift <dominick.grift@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jan 2014 12:52:18 +0100
In-Reply-To: <CAHC9VhQnYC2gBgnqxOGgj74+VC6W7f6_URUSOdyPrEdRU=ydxw@mail.gmail.com>
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain> <1453694.LHeEgrvlzg@sifl>
 <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
 <1389309772.20258.6.camel@x220.localdomain>
 <CAHC9VhQnYC2gBgnqxOGgj74+VC6W7f6_URUSOdyPrEdRU=ydxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 19:23 -0500, Paul Moore wrote:

> 
> Don't forget that a sid, including the initial sids, represents a full
> label/context.
> 

Yes sorry, I will try to keep that in mind.

I use the terminology a bit different since i do not look at it from a
code perspective.

To me a sid is just what the name suggests: a security identifier.

user_u -> identity security identifier
role_r -> role security identifier
type_t -> type security identifier
s0 -> sensitivity security identifier
c0 -> compartment security identifier

I guess from that perspective i would probably also refer to for example
traditional uids as sids.

uid=1000(joe)

key/value pairs, were the key ("uid") is a security attribute and the
value (1000/(joe)) is a/are security identifier(s)

I know its probably technically incorrect. I have the same thing with
the term domain.

I use that term in a different context than everyone else. What you call
a domain i call a domain type.

To me a particular domain encapsulates all rules associated with a
particular domain type
