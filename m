Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0A0Q2Zb030941
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 19:26:02 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so3727797pbc.10
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 16:26:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1389307796.15747.47.camel@x220.localdomain>
References: <52CF1A53.9080501@redhat.com>
 <1389306084.15747.41.camel@x220.localdomain>
 <1389307796.15747.47.camel@x220.localdomain>
Date: Thu, 9 Jan 2014 19:26:00 -0500
Message-ID: <CAHC9VhTBxCicSjgG5vUuNfspyKbkL0bvWD8SWnETO2EwB68Atg@mail.gmail.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Paul Moore <paul@paul-moore.com>
To: Dominick Grift <dominick.grift@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 9, 2014 at 5:49 PM, Dominick Grift <dominick.grift@gmail.com> wrote:
> On Thu, 2014-01-09 at 23:21 +0100, Dominick Grift wrote:
>> On Thu, 2014-01-09 at 16:53 -0500, Daniel J Walsh wrote:
>> Then leave the unlabeled isid for netlabel ( i think netlabel also uses
>> the unlabeled isid )
>>
>> That way we can also get rid of the inconsistency where "unlabeled"
>> nodes are labeled with the object_r role. (nodes are active entities so
>> i would argue the system_r role would be more sensible for nodes)
>
> Not sure if it was peers, nodes or both but i know i was a little
> annoyed by the inconsistency. I like consistency and intuitiveness.
>
> ( on a side note: "system_u:object_r:node_t" is also associated with the
> node isid currently, not sure if "system_u:system_r:node_t" would be
> more appropriate -- same for netlabel_peer i guess )
>
>> Then maybe while we are at it also see if we can fix that isid ordering
>> issue. If one in ones policy messes up the ordering of the isid context
>> specs one gets all kinds of weird behavior.
>
> Not the isid contexts specification ordering but the isid declarations
> ordering (in the initial_sids file)

In general I'm not opposed to reworking the initial sid bits,
including adding/removing initial sids, but it's pretty low on my
priority list as there are still bugs that need squashing.  I also
haven't dug into the toolchain aspect of the initial sid stuff, that
could change my opinion.

-- 
paul moore
www.paul-moore.com
