Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3TJNm3s014873
 for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2016 15:23:49 -0400
Received: by mail-pa0-f67.google.com with SMTP id i5so13477481pag.3
 for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2016 12:23:18 -0700 (PDT)
Date: Sat, 30 Apr 2016 03:23:14 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 2/8] genhomedircon: move fallback user to
 genhomedircon_user_entry_t
Message-ID: <20160429192314.GA14636@meriadoc.perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-3-git-send-email-jason@perfinion.com>
 <b8ccf4b3-15b0-d50c-be4b-20c30a1a3af4@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8ccf4b3-15b0-d50c-be4b-20c30a1a3af4@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Apr 29, 2016 at 12:54:44PM -0400, Stephen Smalley wrote:
> On 04/23/2016 02:04 AM, Jason Zaman wrote:
> > The fallback user is used in all the write functions, making it use a
> > struct allows us to have everything consistent between normal and
> > fallback users.
> > 
> > Signed-off-by: Jason Zaman <jason@perfinion.com>
> 
> When you split a patch into a series, the goal is to ensure that the
> code remains in a working state after each patch in the series.
> Otherwise, git bisect will often find broken states in the future.
> So, we have two options:
> 1. You can refactor this patch set so that it does compile after each
> patch (currently breaks on this one at least).
> 2. I can squash them all into one logical change.

The best is squashing 2-4 into one then. The others are pretty self
contained. 2-4 was a really big change so I split it up even tho it
broke the build but if you'd prefer squashing them thats not a problem.

-- Jason
