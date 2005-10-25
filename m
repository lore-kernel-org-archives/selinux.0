Subject: Re: [ SEMANAGE 2 ] Booleans, parser fixes/improvements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <435D9456.9070502@cornell.edu>
References: <435D9456.9070502@cornell.edu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 08:54:16 -0400
Message-Id: <1130244856.17609.282.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-24 at 22:11 -0400, Ivan Gyurdiev wrote:
> This patch gets booleans working - well... sort of. They still aren't 
> loaded right - I think it's because genbools goes and overrides them 
> after my changes, which is not very nice. I suspect the semanage loading 
> code is working just fine - I can see the file commit code working, at 
> least.

load_policy defaults to preserving current boolean settings (via
genbools_array), so that an update doesn't disturb your active settings
(which may have been adjusted by the admin or by crond for a time-of-day
policy or by your IDS...).  You can disable all user and boolean
manipulation by load_policy by setting the load policy args in
semanage.conf to include -b (turns off preservebools) and_by setting
SETLOCALDEFS=0 in your /etc/selinux/config (turns off genusers/genbools
from the local flat files).

> -  dropped perr_fatal - this was supposed to be a flag to allow us to 
> skip records that do not parse. However, (1) it leaks the record 
> skipped, (2) it is currently not passed down through the call stack, and 
> most importantly, (3) I was assuming one record per line again, which is 
> just not the case - implementing this feature in the general case looks 
> really hard (if possible at all). So, all parse errors are fatal - this 
> is probably the safer choice too.

Hmmm...as long as this happens on updates and unwinds the transaction, I
suppose it is ok.  Load-time manipulation tries to survive individual
record errors since we don't want to lose all boolean settings just
because of a single error (or even because one of the booleans vanished
in the base policy).

> There's still a memory leak which I can't find... but I will track it 
> down eventually - I am now running all code through valgrind, and 
> auditing for leaks.

Note that I always see a small leak coming from Dan's libsetrans library
(dlopen'd by libselinux for context translations for MCS).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
