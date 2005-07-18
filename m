Subject: Re: Patches: libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1121454809.10134.11.camel@celtics.boston.redhat.com>
References: <1121454809.10134.11.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 10:30:37 -0400
Message-Id: <1121697037.32546.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-15 at 15:13 -0400, Ivan Gyurdiev wrote:
> The following patch adds a new debugging system, which
> allows setting the printf function, and provides a separate 
> field for the function name. 
> 
> libsepol-1-debug.diff

Merged.

> The following patch marks more functions extern, and provides
> two new functions - policydb_from_image, and policydb_to_image.
> Those helper functions will be used in future code.
> 
> libsepol-4-policydb_convert.diff

Merged.

> The following patch is attached for comments only.
> It is intended as a replacement for genusers.c, to provide
> an interface for libsemanage to work with users.
> 
> libsepol-5-users.diff
> 
> Note that no new functions are added to the shared interface,
> following up with the plan to make this library static. Also,
> I've dropped patches which make the policydb an opaque structure,
> as they will not be necessary, and may cause instability.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
