Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AEgl2v005187
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 09:42:48 -0500
Received: by mail-qa0-f54.google.com with SMTP id j7so4176043qaq.13
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 06:42:45 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
Date: Fri, 10 Jan 2014 09:42:42 -0500
Message-ID: <3759401.6Dr53NRPXC@sifl>
In-Reply-To: <1389354738.20258.20.camel@x220.localdomain>
References: <52CF1A53.9080501@redhat.com>
 <CAHC9VhQnYC2gBgnqxOGgj74+VC6W7f6_URUSOdyPrEdRU=ydxw@mail.gmail.com>
 <1389354738.20258.20.camel@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 10, 2014 12:52:18 PM Dominick Grift wrote:
> On Thu, 2014-01-09 at 19:23 -0500, Paul Moore wrote:
> > Don't forget that a sid, including the initial sids, represents a full
> > label/context.
> 
> Yes sorry, I will try to keep that in mind.

No worries, the terminology here has always been a bit messy ...

> I use the terminology a bit different since i do not look at it from a
> code perspective.
> 
> To me a sid is just what the name suggests: a security identifier.
> 
> user_u -> identity security identifier
> role_r -> role security identifier
> type_t -> type security identifier
> s0 -> sensitivity security identifier
> c0 -> compartment security identifier

Perhaps this is the difference between someone who works on policy versus 
someone who works with the SELinux code :)

>From my point of view, a security label is pretty much an opaque blob most of 
the time.  While there are different "fields" (what I choose to call the user, 
role, type, and MLS information), security decisions are made based on the 
label as a whole, not individual fields.

I also tend to cringe a bit when I hear the term "sid" used outside the 
context of kernel patch.  A sid is really just a private convenience item used 
by the kernel to make it easier and faster to pass around labels.  In my mind 
the term "sid" should never be used outside kernel patch discussions.

> I guess from that perspective i would probably also refer to for example
> traditional uids as sids.
> 
> uid=1000(joe)

Argh, please no ... we have enough three letter acronyms floating around this 
place, that last thing we want is to start swapping them around! :)

> key/value pairs, were the key ("uid") is a security attribute and the
> value (1000/(joe)) is a/are security identifier(s)

I see your point, but a UID is such a fundamental term and has a widely 
accepted definition, I think calling it a sid is only going to be a problem.

> I know its probably technically incorrect. I have the same thing with
> the term domain.
> 
> I use that term in a different context than everyone else. What you call
> a domain i call a domain type.

Technically a domain is a type ...

> To me a particular domain encapsulates all rules associated with a
> particular domain type

This to me isn't a major difference.  I suppose it is similar to the 
difference between a word itself and what that word represents.

-- 
paul moore
www.paul-moore.com
