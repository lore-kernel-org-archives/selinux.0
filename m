From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
Date: Thu, 10 Nov 2005 10:22:12 -0500
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
   SELinux-dev@tresys.com, Daniel J Walsh <dwalsh@redhat.com>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode> <200511091630.53757.csellers@tresys.com> <1131635584.19626.43.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131635584.19626.43.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511101022.12631.csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 10 November 2005 10:13, Stephen Smalley wrote:
> On Wed, 2005-11-09 at 16:30 -0500, Chad Sellers wrote:
> > Did this ever get resolved?  I see that this patch has made it into the
> > rawhide kernel.  This means that when installing a new policy rpm, my
> > screen is flooded with fixfiles relabeling lib_t to shlib_t, due to
> > shlib_t being a typealias of lib_t in targeted.  Are we worried about
> > this right now, or are these messages ok?
>
> So the short answer is to not worry about these messages, as they do not
> reflect actual changes in labels (and are an issue already with existing
> targeted policy updates, not just refpolicy), and they will cease when
> the rawhide kernel picks up the latest -git snapshot.

OK.  Anyone have an idea when this will hit rawhide?  Before test1?

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
