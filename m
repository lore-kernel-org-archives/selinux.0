Subject: Re: which tool i should use for policy generation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <46959D3B.7040202@gmail.com>
References: <46959D3B.7040202@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Jul 2007 08:09:00 -0400
Message-Id: <1184242140.3392.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-07-12 at 11:17 +0800, Ken YANG wrote:
> 
> i find three papers about policy generation tools:
> 
> <<Guided Policy Generation for Application Authors>>
> <<Madison: A New Approach to Policy Generation>>
> <<Madison – A New Approach to Policy Generation>>
> 
> 
> it seems the last one is the last, so is that mean we
> should use sepolgen rather than madison.
> 
> BTW, i notice the madison is not in fedora rawhide
> repository, is this another reason we should use
> sepolgen?

Madison was the original name for sepolgen, but it was renamed to
sepolgen to make the name meaningful and generic to its purpose.  In the
SELinux trunk (2.x series) and Fedora >= 7, audit2allow has been
rewritten to use sepolgen for its internals.

MITRE Polgen is a separate tool from Madison/sepolgen, but its pieces of
distinctive functionality is likely to be folded into other tools.

SLIDE is a tool for policy authoring that includes support for remote
debugging of policy on a separate VM or remote host.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
