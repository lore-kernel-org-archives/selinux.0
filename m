Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3TC1EDn005244
 for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2016 08:01:14 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so14438801pac.2
 for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2016 05:01:12 -0700 (PDT)
Date: Fri, 29 Apr 2016 20:01:08 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 5/8] genhomedircon: Add uid and gid to struct user_entry
Message-ID: <20160429120108.GA24508@meriadoc>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-6-git-send-email-jason@perfinion.com>
 <4a2931ae-680d-71f3-36d8-51077e93a761@tycho.nsa.gov>
 <20160428175337.GA26112@meriadoc>
 <289e173b-e19f-4de2-d862-c5736bbcffa7@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <289e173b-e19f-4de2-d862-c5736bbcffa7@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 28, 2016 at 02:13:30PM -0400, Stephen Smalley wrote:
> On 04/28/2016 01:53 PM, Jason Zaman wrote:
> > On Wed, Apr 27, 2016 at 01:04:25PM -0400, Stephen Smalley wrote:
> >> On 04/23/2016 02:04 AM, Jason Zaman wrote:
> >>> +		if (snprintf(uid, sizeof(uid), "%d", pwent->pw_uid) < 0
> >>> +		 || snprintf(gid, sizeof(gid), "%d", pwent->pw_gid) < 0) {
> >>
> >> Should you be using %u instead of %d?
> > yes, its unsigned, will fix.
> > 
> >> Also, snprintf returns >= size if the output was truncated, not < 0.
> > 
> >>From the man page:
> > RETURN VALUE
> > [...] Thus, a return value of size or more means that the output was truncated.
> > If an output error is encountered, a negative value is returned.
> > 
> > I definitely need to check <0. but do I *also* need to check >= size? I
> > dont think that can ever happen since 10chars+NULL fits fine.
> 
> I don't think either case is actually possible here (< 0 should only
> occur with printf or fprintf variants, not s*printf, and as you note,
> the truncation case should be covered).

So I think this is correct but i noticed a few more things in the man
page so I am just going to be cautious and check them all anyway.

1) glibc changed bahaviour:
"The glibc implementation of the functions snprintf() and vsnprintf()
conforms to the C99 standard, that is, behaves as described above, since
glibc  version  2.1.   Until  glibc 2.0.6, they would return -1 when the
output was truncated."

2) it looks like there might possibly be locale issues for some of the
stranger ones? i dont think it'd be an issue but having the check doesnt
exactly harm anything since genhomedircon is only run once when building
a policy. This also raises the issue of if there are locale issues
should semodule and friends be checking/resetting LANG/LC_NUMERIC for
sanity early on?

I'm going to send v3 of this patch with these fixes. Do you want me to
re-send the whole set or is just this one enough?

-- Jason
