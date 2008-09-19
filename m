Subject: Re: typebounds lookup from userspace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <48D3B802.1000505@manicmethod.com>
References: <48D3B220.1060903@manicmethod.com>
	 <1221834373.25857.25.camel@moss-spartans.epoch.ncsc.mil>
	 <48D3B802.1000505@manicmethod.com>
Content-Type: text/plain
Date: Fri, 19 Sep 2008 11:07:22 -0400
Message-Id: <1221836842.25857.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-09-19 at 10:32 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2008-09-19 at 10:07 -0400, Joshua Brindle wrote:
> >> For symbol labeling purposes for policy access control we need to be
> >> able to look up symbol hierarchy relationships. I expect we'll do this
> >> by exporting the symbol hierarchy via selinuxfs. Does anyone have
> >> suggestions on what that should look like? Do we want to export
> >> additional information on the symbols at the same time?
> > 
> > I would have thought that the policy server would have its own internal
> > policydb that it could consult to check hierarchy relationships?
> > 
> 
> We want to avoid loading more policydb's since RAM usage and
> performance were issues with the expand-based access control.

libsemanage already has to load the policydb into memory for its
transactions.  Will this change in the future?  If not, then it seems
that you could simply leverage that.

> > In any event, if we were to export such info via selinuxfs, then yes,
> > we'd want to also export other information about the symbols, such as
> > the user role and level authorizations, so that that information could
> > be used by libselinux and we could ultimately deprecate /selinux/user
> > aka security_compute_user().
> > 
> 
> So, something like
> /selinux/symbols/types/httpd_cgi_t
> bounds: httpd_t
> 
> /selinux/symbols/users/user_u
> bounds: staff_u
> roles: user_r 
> levels: s0-s0:c0.c128
> 
> ?
> 
> or maybe
> 
> /selinux/symbols/users/user_u/roles
> user_r
> 
> /selinux/symbols/users/user_u/bounds
> staff_u

I know that at one point the trend was toward one value per file, but
that carries a cost of course, and I'm not sure the /selinux/class
interface turned out to be ideal.  Maybe others have opinions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
