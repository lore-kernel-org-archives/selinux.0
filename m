Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200706121927.20068.russell@coker.com.au>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
	 <20070611204336.GA30846@sergelap.austin.ibm.com>
	 <200706121927.20068.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:09:28 -0400
Message-Id: <1181650168.17547.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-12 at 19:27 +1000, Russell Coker wrote:
> On Tuesday 12 June 2007 06:43, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > If we decide to have this take the place of the file capabilities i
> > guess we're all set, but if both are going upstream, do you think
> > CONFIG_SECURITY_FILE_CAPABILITIES and selinux should be mutually
> > exclusive?
> 
> This is the sort of thing that can be revised at some future time when there 
> are some users for FILE_CAPABILITIES.  While there are no users for either of 
> the options there seems little incentive to make them work together in the 
> short term.
> 
> The potential interactions between FILE_CAPABILITIES and cap_override are not 
> obvious, I can think of several options for how these things might work - 
> basically determining how much SE Linux will permit FILE_CAPABILITIES to do 
> what it wants.  If we are going to make them work together then before code 
> is written it would probably be more effective to have some agreement on how 
> it will work - which will depend on some sample implementations of both 
> systems and public comment.

Serge's file capabilities patch is already in -mm, so it is fairly
straightforward to see how they interact currently.  The SELinux
checking is applied when a process tries to use a capability, whereas
the file capabilities logic is applied when the process' capability
masks are computed at execve time.  Thus, the file capabilities logic
merely changes the base Linux capability computation upon execve and
affects the process' capability mask that is later checked on use.  The
old SELinux logic checked the process' capability mask (via the
capability module), and then if granted there, it would apply the
SELinux capability check as a further restriction.  The new SELinux
logic checks the SELinux cap_override check first; if that is denied,
then all is as it was before; if it is allowed, then the process'
capability mask is ignored and the SELinux capability check can
authoritatively grant the capability.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
