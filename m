Subject: Re: libsetrans and libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Chad Hanson <chanson@TrustedCS.com>, Daniel J Walsh <dwalsh@redhat.com>,
   russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43BA11DD.4000907@tresys.com>
References: <200601031411.13500.russell@coker.com.au>
	 <43B9FAAD.10809@redhat.com>  <43BA11DD.4000907@tresys.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 12:06:18 -0500
Message-Id: <1136307978.27632.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 00:55 -0500, Joshua Brindle wrote:
> The only users of libsetrans are ones that use context functions in 
> libselinux, and several apps that link to libselinux but don't use those 
> (such as load_policy, init, etc)
> 
> Further, IIRC libsetrans is being maintained by RH and is not in the nsa 
> mainline cvs tree. And as Dan was saying, the whole reason for 
> libsetrans to begin with was for drop in translation libraries (such as 
> Mitre's)

Yes, Dan earlier proposed integrating libsetrans into libselinux IIRC,
and I resisted.  However, if libsetrans were made suitably generic such
that it wouldn't need to be replaced entirely in order to support things
like the MITRE library, then it might be reasonable to fold it into
libselinux.  It is true that subtle bugs and memory leaks can crop up
now due to the separation.

MITRE also thought it possible that their translation library could be
open sourced, if that would help.  Not sure how long it would take to
gain approval though...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
