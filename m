Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAAKg39d009545
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 15:42:05 -0500
Received: by mail-qg0-f44.google.com with SMTP id q107so6153123qgd.31
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 12:42:01 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: "selinux_nlmsg_perm: unrecognized netlink message: protocol=0
 nlmsg_type=0 sclass=30" warning on Linux 3.18-rc3
Date: Mon, 10 Nov 2014 15:41:57 -0500
Message-ID: <2373486.3IgvVOFVQB@sifl>
In-Reply-To: <20141105222537.GG5902@madcap2.tricolour.ca>
References: <CAHTgTXVyR3hoZDSp6QRTtJ9+cAuPXsPomfDBw0zisft=7H_7dA@mail.gmail.com>
 <18386541.xBZWpSPpcC@sifl> <20141105222537.GG5902@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: James Morris <james.l.morris@oracle.com>,
 Vinson Lee <vlee@twopensource.com>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, trinity@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, November 05, 2014 05:25:37 PM Richard Guy Briggs wrote:
> On 14/11/05, Paul Moore wrote:
> > In retrospect, we could probably do better.  I don't think it should be an
> > audit record, but I can see the point that a backtrace and scary WARNING!
> > display are probably a bit too much.
> > 
> > Richard, how about converting this WARN_ONCE() to a printk_once(), or
> > similar?
>
> I'd be agreeable to that.  While I was a bit concerned that a
> WARN_ONCE() could be lost in the noise (evidently that's not the case!)
> a printk_once() would more likely get lost in the noise.  Would it make
> sense to make it a bit less infrequent than printk_once() and rate-limit
> it at say, one per 5 seconds or more?

Let's just go with printk_once() for right now.  We probably need to have a 
better, more consistent approach to error messages not related to the normal 
access control stuff, however, I'd like to fix this for the v3.18-rcX releases 
and that is a bit out of scope for right now.

Ideally I'd like to fix it this week.  Richard, any chance you can submit a 
patch by the end of the day on Tuesday?  It really should be trivial; if you 
can't let me know and I'll take care of it.

-- 
paul moore
www.paul-moore.com
