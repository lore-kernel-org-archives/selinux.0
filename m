Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UH5fDo016428
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 12:05:41 -0500 (EST)
Received: from web31606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j2UH4Uo4008223
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:04:30 GMT
Message-ID: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
Date: Wed, 30 Mar 2005 09:04:26 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Desktop apps interoperability
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> On Wed, 2005-03-30 at 07:52 -0800, Casey Schaufler
> wrote:
> > --- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > > On Wed, 2005-03-30 at 07:05 -0800, Casey
> Schaufler
> > > wrote:
> > > ...
> > > > > Desktop apps will be restricted to only
> access
> > > the
> > > > > appropriate one.
> > > > > "Downloading" apps will be restricted to
> > > download to
> > > > > untrusted_content_t. 
> > > > 
> > > > Am I the only one wary of a slippery slope
> here?
> > > 
> > > What's the problem?
> > 
> > Unless I read your intent incorrectly (which
> > is possible) you're talking about requiring
> > the rearchitecting of the data storage schemes
> > for every user application on the planet to
> > accomodate the presence of DTE. And you're
> > talking about it as if it might actually happen.
> 
> Do you have a better proposal for restricting
> desktop applications
> to minimum privilege?

Well, the old unix way was for them to run as
a normal (unprivileged) user. No privilege, no
problem, right?

OKay, I know that's not being helpful.

I am concerned about the way y'all are going
about this. It appears that you are deriving
policy from behavior and then suggesting changes
to the behavior so that the policy makes sense.
While this is consistant with commercial software
development practice it is highly out of line
with secure system development practice. The
good reason to use policy derived from behavior
is to avoid changing existing applications.
If you are going to change the application you
will better serve the community by deciding first
what the policy ought to be then changing the
application to suit it rather than doing the
derive-tweek two step.

> Nothing needs to be rearchitectured. The user just
> needs
> to be made aware that this is where the documents
> belong, and
> the app can't write all over the place like it would
> in a non-selinux
> environment.

Yes, and I'm sure that you can do a configuration
of most application defaults that will be good
enough to demo. Application developers tend to
have their own ideas regarding data storage and
it is a bad idea for a system developer to
interfere with said application developer's
freedom to inovate.

> Apps that still run in user_t would be
> unaffected until
> their policy is changed.

But the policy change is being made for them,
outside the program, by people who's needs the
typical application developer is not considering.
Back to my point, the policy mechanism needs to
be either transparent to the application or
integral to it.

> Of course, I'm thinking in the future such folders
> would be prominently
> displayed in Gnome with their own little icons, and
> their windows-style
> names like "My Media" or whatever (which should not
> be the same 
> as the actual dir. name), and those would go in the
> Places menu or
> something, and sound juicer for example would know
> to write there by
> default as opposed to somewhere else. 

Chuckle. I worked on a scheme much like this.
On Unix. In 1980. It was not a popular product.

> I guess this discussion now becomes more
> GNOME-oriented, now that I
> think about it. Maybe I should go bother the GNOME
> people to see what
> they think about adding content-specific folders to
> /home that we can
> label with different contexts..

Yes.

> ... or am I missing something fundamental here? 

Is DTE application transparent or does it require
modification to the applications? If the latter
your proposals are reasonable but the whole DTE
scheme is more sophisticated than it needs to be.
If the former, you need to relax your expectations
of application behavior and work harder on the
policy you want to impose.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
