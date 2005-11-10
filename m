Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
   SELinux-dev@tresys.com, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200511091630.53757.csellers@tresys.com>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
	 <Pine.LNX.4.63.0510271520390.24160@excalibur.intercode>
	 <1130443338.18805.364.camel@moss-spartans.epoch.ncsc.mil>
	 <200511091630.53757.csellers@tresys.com>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:13:04 -0500
Message-Id: <1131635584.19626.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 16:30 -0500, Chad Sellers wrote:
> Did this ever get resolved?  I see that this patch has made it into the 
> rawhide kernel.  This means that when installing a new policy rpm, my screen 
> is flooded with fixfiles relabeling lib_t to shlib_t, due to shlib_t being a 
> typealias of lib_t in targeted.  Are we worried about this right now, or are 
> these messages ok?

So the short answer is to not worry about these messages, as they do not
reflect actual changes in labels (and are an issue already with existing
targeted policy updates, not just refpolicy), and they will cease when
the rawhide kernel picks up the latest -git snapshot.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
