Message-ID: <48D3B802.1000505@manicmethod.com>
Date: Fri, 19 Sep 2008 10:32:34 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: typebounds lookup from userspace
References: <48D3B220.1060903@manicmethod.com> <1221834373.25857.25.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1221834373.25857.25.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-09-19 at 10:07 -0400, Joshua Brindle wrote:
>> For symbol labeling purposes for policy access control we need to be
>> able to look up symbol hierarchy relationships. I expect we'll do this
>> by exporting the symbol hierarchy via selinuxfs. Does anyone have
>> suggestions on what that should look like? Do we want to export
>> additional information on the symbols at the same time?
> 
> I would have thought that the policy server would have its own internal
> policydb that it could consult to check hierarchy relationships?
> 

We want to avoid loading more policydb's since RAM usage and performance were issues with the expand-based access control.

> In any event, if we were to export such info via selinuxfs, then yes,
> we'd want to also export other information about the symbols, such as
> the user role and level authorizations, so that that information could
> be used by libselinux and we could ultimately deprecate /selinux/user
> aka security_compute_user().
> 

So, something like
/selinux/symbols/types/httpd_cgi_t
bounds: httpd_t

/selinux/symbols/users/user_u
bounds: staff_u
roles: user_r 
levels: s0-s0:c0.c128

?

or maybe

/selinux/symbols/users/user_u/roles
user_r

/selinux/symbols/users/user_u/bounds
staff_u

?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
