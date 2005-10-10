Subject: Re: matchpathcon regcomp return code
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Johan Fischer <jfischer@cmcrc.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 10:03:04 -0400
Message-Id: <1128952985.22129.131.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-05 at 09:19 -0400, Stephen Smalley wrote:
> Yes, file contexts ordering/precedence is a known problem.  It is
> exacerbated by the new policy module support, and Tresys has introduced
> a sorting algorithm for their reference policy
> (http://serefpolicy.sf.net) based on fixed string vs. regex (already
> done by matchpathcon), stem length, string length, and presence of the
> file type specifier.
[cut]
> Chris, is there a reason you kept it as a separate helper
> specific to reference policy versus submitting it as a patch to
> matchpathcon itself?

We were thinking about this a little more.  Since sorting the file
contexts is a relatively expensive operation, wouldn't it be better to
just sort the file contexts once on install, rather than redoing it on
every matchpathcon/setfiles/restorecon?  Source policies that need more
than the simple sort already done in matchpathcon_init can sort the file
contexts on install, and the loadable modules infrastructure can sort
for loadable modules.  This has the advantage of not disturbing the
example policy.  Then the sorting would be added to libselinux as a
library function, along with a util program for source policies to use
for sorting.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
