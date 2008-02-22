Subject: Re: ps aux output under sysadm context in refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203692165.3669.910.camel@bluejay.goodinassociates.com>
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>
	 <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>
	 <1203692165.3669.910.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 10:01:19 -0500
Message-Id: <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-22 at 08:56 -0600, Jeremiah Jahn wrote:
> I wonder if I'm using apol incorrectly. I have:
> Analysis type = Doman Transition
> Direction = Forward
> source domain = sysadm_t
> use access filters = checked
> included object types = mysecure_t
> included object classes = dir & file
> permission for dir = getattr & read & search
> permissions for file = getattr & read
> 
> results tree = sysadm_t & nothing else, no possible expansions.
> 
> I read this as, there is no possible path from sysadm_t to mysecure_t
> 
> yet, I get the following output from pas auxZ
> system_u:system_r:mysecure_t:s0  mysecure   3531  0.0  0.0 139276  2396 ?        Sl   Feb14   0:00 /usr/local/mysecure/bin/mysecure -Umysecure
> 
> I'm stumped :)

Domain transitions are process transitions, i.e. can sysadm_t transition
to mysecure_t.  Not can it read from it.

You can use the rule searching facilities to look for direct read rules,
or can use the information flow analysis to see if there is any path by
which mysecure_t can flow to sysadm_t, but the latter is likely less
useful because there is almost always at least one indirect path by
which information can flow.

> 
> On Fri, 2008-02-22 at 09:35 -0500, Stephen Smalley wrote:
> > On Thu, 2008-02-21 at 15:22 -0600, Jeremiah Jahn wrote:
> > > I'm having a heck of a time limiting the ps aux output to show only what
> > > I think sysadm should be able to see.
> > > 
> > > I have a number of types that are running and I get a ptrace denied, but
> > > sysadm can still see the process. I'm really not sure why this is the
> > > case. I've set all the build options correctly, ie left the defaults,
> > > the booleans are set to no. Somewhere there is something going on that
> > > lets sysadm see all of this stuff, and I just can't find it.
> > > 
> > > According to apol there is not way for me to read the proc files as
> > > sysadm. What Am I missing, or where should I look.
> > 
> > Access to the basic /proc/pid information is allowed by:
> > 	# search the /proc/pid directory for the target domain
> > 	allow <source domain> <target domain>:dir search;
> > 	# read public information about the target domain
> > 	allow <source domain> <target domain>:file read;
> > since the /proc/pid files are labeled with the domain of the associated
> > process.
> > 
> > Certain /proc/pid nodes are further limited by ptrace since they reveal
> > what should be private information to the process.
> > 
> > > 
> > > thanx,
> > > -jj-
> > > 
> > > 
> > > 
> > > He thought he saw an albatross That fluttered 'round the lamp. He looked
> > > again and saw it was A penny postage stamp. "You'd best be getting
> > > home," he said, "The nights are rather damp."
> Political T.V. commercials prove one thing: some candidates can tell all
> their good points and qualifications in just 30 seconds.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
