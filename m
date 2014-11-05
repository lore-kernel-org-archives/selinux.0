Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA5LvhQT011958
 for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2014 16:57:44 -0500
Received: by mail-qa0-f53.google.com with SMTP id n8so1230185qaq.12
 for <selinux@tycho.nsa.gov>; Wed, 05 Nov 2014 13:57:32 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Richard Guy Briggs <rgb@redhat.com>
Subject: Re: "selinux_nlmsg_perm: unrecognized netlink message: protocol=0
 nlmsg_type=0 sclass=30" warning on Linux 3.18-rc3
Date: Wed, 05 Nov 2014 16:57:29 -0500
Message-ID: <18386541.xBZWpSPpcC@sifl>
In-Reply-To: <545A8DE8.1010106@tycho.nsa.gov>
References: <CAHTgTXVyR3hoZDSp6QRTtJ9+cAuPXsPomfDBw0zisft=7H_7dA@mail.gmail.com>
 <1588252.T4atn8E9DE@sifl> <545A8DE8.1010106@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: James Morris <james.l.morris@oracle.com>,
 Vinson Lee <vlee@twopensource.com>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, trinity@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, November 05, 2014 03:51:52 PM Stephen Smalley wrote:
> On 11/05/2014 03:48 PM, Paul Moore wrote:
> > On Tuesday, November 04, 2014 12:12:56 PM Vinson Lee wrote:
> >> Hi.
> >> 
> >> trinity triggered this kernel warning in selinux_netlink_send on Linux
> >> 3.18-rc3.
> > 
> > It looks like trinity sent a bogus netlink message to the kernel and
> > SELinux responded as I would expect it to, with a WARN_ONCE() message. 
> > Thank you for your help in testing, but I don't see a problem here that
> > needs to be resolved.
> 
> I guess the only thing new here is that this message used to be directed
> to the audit system via audit_log() and was changed to use WARN_ONCE().
> Why was that change made (the change description gives no rationale)?

My understanding was that the audit record didn't fit the hoped-for-but-not-
really-a-standard name value pair format that the audit folks like.  Richard 
wanted to either normalize the audit record or replace it with something else.

> Is this an appropriate use of WARN_ONCE()?

In retrospect, we could probably do better.  I don't think it should be an 
audit record, but I can see the point that a backtrace and scary WARNING! 
display are probably a bit too much.

Richard, how about converting this WARN_ONCE() to a printk_once(), or similar?

-- 
paul moore
www.paul-moore.com
