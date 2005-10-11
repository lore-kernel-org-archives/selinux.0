Subject: Re: matchpathcon regcomp return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Johan Fischer <jfischer@cmcrc.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128952985.22129.131.camel@sgc.columbia.tresys.com>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
	 <1128952985.22129.131.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:07:05 -0400
Message-Id: <1129032425.3308.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-10 at 10:03 -0400, Christopher J. PeBenito wrote:
> We were thinking about this a little more.  Since sorting the file
> contexts is a relatively expensive operation, wouldn't it be better to
> just sort the file contexts once on install, rather than redoing it on
> every matchpathcon/setfiles/restorecon?  Source policies that need more
> than the simple sort already done in matchpathcon_init can sort the file
> contexts on install, and the loadable modules infrastructure can sort
> for loadable modules.  This has the advantage of not disturbing the
> example policy.  Then the sorting would be added to libselinux as a
> library function, along with a util program for source policies to use
> for sorting.

I'm uneasy about leaving this to policy (re)generation; I would prefer
that matchpathcon apply a well-defined ordering/precedence to file
contexts (including file_contexts.homedirs and file_contexts.local,
which at least presently can be changed without going through a policy
build).  Note that this only occurs during initialization
(matchpathcon_init), not on every matchpathcon call by an application.
I'm also unclear on whether the overhead from sorting the entries in
memory is actually substantial compared to the rest of what
matchpathcon/matchpathcon_init does already.  The regex compilation and
matching seems more costly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
