Subject: Re: unconfined_t Domain with MLS Policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Henley, Tim-P64420" <Timothy.Henley@gdc4s.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <EC684739C863494FB46F604CEDEC3E241BBA2F@AZ25EXM01.gddsi.com>
References: <EC684739C863494FB46F604CEDEC3E241BBA2F@AZ25EXM01.gddsi.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 15:41:19 -0400
Message-Id: <1205869279.6466.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-18 at 11:31 -0700, Henley, Tim-P64420 wrote:
> Is the unconfined_t Domain available when running with the MLS Policy?
> I was attempting to assign a Perl script to the domain using chcon
> (with the -t switch). The result is that I get an "Invalid argument"
> error message. I'm doing this on a development box (the Perl script is
> for dev use only) as a means of trying to avoid having to stop and
> write a policy for every script/executable I create during
> development. Is this how I should be handling this or is there a more
> appropriate way to do this? Thanks in advance.

unconfined_t is generally only present in -targeted policy, not -strict
or -mls, although one can build it into any policy.

But the bigger question is why you think you need to roll a policy for
every script/executable - you should only need to introduce a separate
domain when the program requires a different set of permissions than its
caller, and in many cases, you can just use an existing domain for a
related program that requires similar access.  For user programs, most
of them should just run in the user's domain without a problem.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
