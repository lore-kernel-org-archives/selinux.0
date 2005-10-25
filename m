Subject: Re: [ SEPOL 6 ] Fix all the bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435A7614.8000706@cornell.edu>
References: <435A7614.8000706@cornell.edu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 08:37:51 -0400
Message-Id: <1130243871.17609.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 13:25 -0400, Ivan Gyurdiev wrote:
> - simplify the port key check a bit - I'll probably have to have another 
> look at this, because I don't think it will do the right thing on 
> modify() - only on query. When you modify a range with a key as the 
> subset of that range, we want it to punch a hole in the range, and split 
> the declaration, but it will replace it entirely. This is easy to fix in 
> sepol, but I also have to fix it in semanage, where it is not as easy - 
> I'd rather think about this some more than do it the wrong way right now.

The current approach is to simply put the more specific entries at the
beginning of the list, and to use the first matching entry.  Thus, you
don't need to modify the existing larger range at all - you just need to
insert your more specific entry before it in the list.  checkpolicy
simply preserves the matching order specified in the net_contexts
configuration, and we order those entries manually to keep the more
specific ones at the front.  checkpolicy does treat it as an error if it
finds that one of the later entries would be completely hidden (or
duplicated) by an earlier entry, but overlap is permitted.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
