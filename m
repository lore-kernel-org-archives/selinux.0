Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v72Ll2Fw000884
 for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2017 17:47:02 -0400
Received: by mail-oi0-f49.google.com with SMTP id d71so52419898oih.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Aug 2017 14:45:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170802105018.GA2529@dhcp22.suse.cz>
References: <20170802105018.GA2529@dhcp22.suse.cz>
From: Paul Moore <pmoore@redhat.com>
Date: Wed, 2 Aug 2017 17:45:56 -0400
Message-ID: <CAGH-Kgt_9So8bDe=yDF3yLZHDfDgeXsnBEu_X6uE_nQnoi=5Vg@mail.gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jeff Vander Stoep <jeffv@google.com>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 2, 2017 at 6:50 AM, Michal Hocko <mhocko@kernel.org> wrote:
> Hi,
> while doing something completely unrelated to selinux I've noticed a
> really strange __GFP_NOMEMALLOC usage pattern in selinux, especially
> GFP_ATOMIC | __GFP_NOMEMALLOC doesn't make much sense to me. GFP_ATOMIC
> on its own allows to access memory reserves while the later flag tells
> we cannot use memory reserves at all. The primary usecase for
> __GFP_NOMEMALLOC is to override a global PF_MEMALLOC should there be a
> need.
>
> It all leads to fa1aa143ac4a ("selinux: extended permissions for
> ioctls") which doesn't explain this aspect so let me ask. Why is the
> flag used at all? Moreover shouldn't GFP_ATOMIC be actually GFP_NOWAIT.
> What makes this path important to access memory reserves?

[NOTE: added the SELinux list to the CC line, please include that list
when asking SELinux questions]

The GFP_ATOMIC|__GFP_NOMEMALLOC use in SELinux appears to be limited
to security/selinux/avc.c, and digging a bit, I'm guessing commit
fa1aa143ac4a copied the combination from 6290c2c43973 ("selinux: tag
avc cache alloc as non-critical") and the avc_alloc_node() function.

I can't say that I'm an expert at the vm subsystem and the variety of
different GFP_* flags, but your suggestion of moving to GFP_NOWAIT in
security/selinux/avc.c seems reasonable and in keeping with the idea
behind commit 6290c2c43973.

-- 
paul moore
security @ redhat
