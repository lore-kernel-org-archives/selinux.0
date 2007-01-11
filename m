Subject: Re: [RFC] clarifications for -l to newrole.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Klaus Weidner <klaus@atsec.com>
In-Reply-To: <45A6A064.2040707@us.ibm.com>
References: <45A6A064.2040707@us.ibm.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 16:02:00 -0500
Message-Id: <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-11 at 14:39 -0600, Michael C Thompson wrote:
> Based on some discussion from irc and some complaints I have received, 
> I'm proposing this addition (comments or other suggestions welcome) to 
> the newrole manage. This example section would slot in right after the 
> DESCRIPTION section. Patch below.
> 
> EXAMPLE
>         Changing sensitivity only:
>            # id -Z
>            user:role:type:SystemLow-SystemHigh
>            # newrole -l Unclassified
>            # id -Z
>            user:role:type:Unclassified-SystemHigh

How does SystemLow differ from Unclassified here (in meaning, not just
value)?  If SystemLow is supposed to be a special label for system
objects, then why have users login at that level at all?

>         Changing sensitivity and clearance:
>            # id -Z
>            user:role:type:SystemLow-SystemHigh
>            # newrole -l Unclassified-Unclassified
>            # id -Z
>            user:role:type:Unclassified-Unclassified

When would you envision a user doing the above?  Trying to ensure that
any process he subsequently starts cannot escalate to higher levels?

If you are going to provide an example, use real output (i.e. not just
user:role:type).  Please include an example of changing roles too since
that is more common.  Also, fix the SEE ALSO list please (runas ->
runcon, and drop su as it is no longer relevant).

AUTHORS list is also badly out of date there.  Let's see...you, Dan
Walsh, Steve Grubb, and Darrel Goeddel should likely be added, and while
the earlier authors should be retained, their email addresses are
obsolete and should be dropped.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
