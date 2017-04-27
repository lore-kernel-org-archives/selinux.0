Message-ID: <1493296789.2524.1.camel@tycho.nsa.gov>
Subject: Re: is_selinux_enabled() always returns 0 after
 selinux_set_policy_root()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Date: Thu, 27 Apr 2017 08:39:49 -0400
In-Reply-To: <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
References: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
 <1493238298.32540.13.camel@tycho.nsa.gov>
 <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-26 at 16:43 -0400, Colin Walters wrote:
> On Wed, Apr 26, 2017, at 04:24 PM, Stephen Smalley wrote:
> > 
> > Your analysis and proposed fix sound correct to me.  I blame Dan ;)
> 
> Thanks.  I tested the patch and confirmed it fixed ostree as it
> stands today,
> but I'm going to change ostree to cache the result of
> `is_selinux_enabled()`
> itself to work around this, since for our use cases it should never
> really
> change dynamically.
> 
> Here's a git-format-patch version attached:

Thanks, applied.
