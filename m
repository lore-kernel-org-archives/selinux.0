Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBKMUXo4018766
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 17:30:33 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so2123902qcx.31
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 14:30:31 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] audit: use supplied gfp_mask from audit_buffer in
 kauditd_send_multicast_skb
Date: Sat, 20 Dec 2014 17:30:29 -0500
Message-ID: <1707208.eM92rXqJdO@sifl>
In-Reply-To: <74385.1419036779@turing-police.cc.vt.edu>
References: <d261c547d8018a18f2092e1907b06e190162b088.1418947557.git.rgb@redhat.com>
 <74385.1419036779@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com, selinux@tycho.nsa.gov,
 sgrubb@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, December 19, 2014 07:52:59 PM Valdis.Kletnieks@vt.edu wrote:
> On Thu, 18 Dec 2014 23:09:27 -0500, Richard Guy Briggs said:
> > Eric Paris explains: Since kauditd_send_multicast_skb() gets called in
> > audit_log_end(), which can come from any context (aka even a sleeping
> > context) GFP_KERNEL can't be used.  Since the audit_buffer knows what
> > context it should use, pass that down and use that.
> > 
> > See: https://lkml.org/lkml/2014/12/16/542
> > 
> > Reported-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > 
> >  kernel/audit.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 7b83c55..ce484fb 100644
> 
> I was reliably triggering 3-4 BUGs an hour, and with this patch applied I've
> gone 9 hours without seeing one.
> 
> So feel free to add a Tested-By:  when it goes out.

Added, thanks for your help.

-- 
paul moore
security @ redhat
