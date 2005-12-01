Subject: Re: matchpathcon_init overhead
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Tom London <selinux@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <438E23C6.6040509@redhat.com>
References: <1133385496.26593.405.camel@moss-spartans.epoch.ncsc.mil>
	 <438E23C6.6040509@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 07:23:13 -0500
Message-Id: <1133439793.26593.410.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-30 at 17:12 -0500, Daniel J Walsh wrote:
> Why can't we confirm after the match.
> 
> IE Match /dev/mydevice, now verify you have a good context.
> 
> Then allow restorcon/fixfiles ... to do it the old way.

That would avoid the overhead of context canonicalization/validation,
but wouldn't avoid the overhead of the regex compilation on all of
file_contexts.  We can try that first if you want, but allowing
applications to select a subset of file_contexts entries for matching
seems useful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
