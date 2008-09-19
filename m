Subject: Re: typebounds lookup from userspace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48D3B220.1060903@manicmethod.com>
References: <48D3B220.1060903@manicmethod.com>
Content-Type: text/plain
Date: Fri, 19 Sep 2008 10:26:13 -0400
Message-Id: <1221834373.25857.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-09-19 at 10:07 -0400, Joshua Brindle wrote:
> For symbol labeling purposes for policy access control we need to be
> able to look up symbol hierarchy relationships. I expect we'll do this
> by exporting the symbol hierarchy via selinuxfs. Does anyone have
> suggestions on what that should look like? Do we want to export
> additional information on the symbols at the same time?

I would have thought that the policy server would have its own internal
policydb that it could consult to check hierarchy relationships?

In any event, if we were to export such info via selinuxfs, then yes,
we'd want to also export other information about the symbols, such as
the user role and level authorizations, so that that information could
be used by libselinux and we could ultimately deprecate /selinux/user
aka security_compute_user().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
