Subject: Re: general security lib (was: 2.6.0-test3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1061574715.28960.25.camel@columbia>
References: <1061468940.1665.16.camel@kusturica>
	 <200308212337.59952.russell@coker.com.au>
	 <1061487623.22355.27.camel@columbia>  <1061555921.1648.142.camel@kusturica>
	 <1061559409.28086.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1061574715.28960.25.camel@columbia>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061577167.28086.311.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Aug 2003 14:32:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 13:51, Colin Walters wrote:
> Stephen,
> 
> What do you think about Magosányi's point of sending more of these
> patches upstream?
> 
> At least some projects like openssh have active upstreams with an
> interest in security, so I think they would be receptive.
> 
> Other stuff like cron is unfortunately basically unmaintained, so
> there's not much we can do there.

Yes, this would likely be worthwhile, given that the mainline kernel now
provides the necessary support for the new SELinux API and the SELinux
patches have been ported to the new API.  There are some likely
conflicts that would have to be resolved:

1) OpenSSH may want a patch written to a common API that can be mapped
to either the SELinux API or the TrustedBSD API.

2) Patches that deal with managing file security contexts may overlap
with the generic xattr patches from acl.bestbits.at.  Unfortunately, the
generic xattr patches don't support an aspect of the SELinux API - the
ability to create a file with a specified security context (using
setfscreatecon prior to the file creation) rather than just using a
default inheritance model based on the parent directory.  This
distinction is security-relevant, as the generic xattr patches will
leave files temporarily in a security label that may be less restrictive
than the final target security label.  Note that our patches make
extensive use of setfscreatecon(), whereas the xattr patches simply set
the label after the file has already been created (when it may be too
late).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
