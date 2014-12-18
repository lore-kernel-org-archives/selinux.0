Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBIK4Kd8013084
 for <selinux@tycho.nsa.gov>; Thu, 18 Dec 2014 15:04:20 -0500
From: Paul Moore <pmoore@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: linux-next 20141216 BUG: sleeping function called from invalid
 context at mm/slab.c:2849
Date: Thu, 18 Dec 2014 15:03:54 -0500
Message-ID: <3969718.H7hYOeJgY9@sifl>
In-Reply-To: <1418929486.5162.22.camel@localhost>
References: <2966.1418778594@turing-police.cc.vt.edu>
 <20141218184420.GF29998@madcap2.tricolour.ca>
 <1418929486.5162.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org,
 Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, December 18, 2014 02:04:46 PM Eric Paris wrote:
> I'd suggest just sending the GFP type, not the who audit_buffer, but
> that's up to you.

That would be my preference too, especially since we will want to send this to 
stable and smaller is generally better there.

-- 
paul moore
security and virtualization @ redhat
