Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09MLSUW025178
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 17:21:28 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so7584770wib.8
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 14:21:26 -0800 (PST)
Message-ID: <1389306084.15747.41.camel@x220.localdomain>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Dominick Grift <dominick.grift@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Date: Thu, 09 Jan 2014 23:21:24 +0100
In-Reply-To: <52CF1A53.9080501@redhat.com>
References: <52CF1A53.9080501@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 16:53 -0500, Daniel J Walsh wrote:
> We would like to change
> 
> sid file_labels         gen_context(system_u:object_r:unlabeled_t,s0)
> 
> to something like
> 
> sid file_labels         gen_context(system_u:object_r:invalid_label_t,s0)

I think the file_labels isid is deprecated. Do you mean the unlabeled
isid instead?

But yes i think i also suggested this a couple times.

Add a new isid "invalid"

Then leave the unlabeled isid for netlabel ( i think netlabel also uses
the unlabeled isid )

That way we can also get rid of the inconsistency where "unlabeled"
nodes are labeled with the object_r role. (nodes are active entities so
i would argue the system_r role would be more sensible for nodes)

Then maybe while we are at it also see if we can fix that isid ordering
issue. If one in ones policy messes up the ordering of the isid context
specs one gets all kinds of weird behavior.

Maybe we can then also really get rid of those deprecated isids? They've
been marked deprecated for ages, but as soon as you remove them from
policy ; shed hits the fan. 
