Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IGr4kf023722
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 12:53:04 -0400
Received: from office.cardomain.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IGr3oF002580
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 16:53:03 GMT
Received: from cardomain.com (exnode02.intra.cardomain.com [172.21.0.5])
	by office.cardomain.com (Postfix) with ESMTP id 725B782CD
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 09:53:02 -0700 (PDT)
Subject: Re: Fedora refpolicy patches
From: Brett Lentz <blentz@cardomain.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
        selinux@tycho.nsa.gov
In-Reply-To: <1216384354.21191.106.camel@gorn>
References: <20080716165634.GA8072@hardeman.nu>
	 <487E2C1F.4010308@redhat.com> <20080716174410.GA9226@hardeman.nu>
	 <1216232357.21191.76.camel@gorn> <487E451C.5000603@redhat.com>
	 <20080716192942.GA11166@hardeman.nu>  <487E4EAD.5070207@redhat.com>
	 <1216238975.4832.11.camel@blentz>  <1216384354.21191.106.camel@gorn>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2008 09:52:49 -0700
Message-Id: <1216399969.22997.27.camel@blentz>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-18 at 08:32 -0400, Christopher J. PeBenito wrote:
> On Wed, 2008-07-16 at 13:09 -0700, Brett Lentz wrote:
> > On Wed, 2008-07-16 at 15:40 -0400, Daniel J Walsh wrote:
> > > David Härdeman wrote:
> > > > On Wed, Jul 16, 2008 at 02:59:40PM -0400, Daniel J Walsh wrote:
> > > >> Christopher J. PeBenito wrote:
> > > >>> On Wed, 2008-07-16 at 19:44 +0200, David Härdeman wrote:
> > > >>>> On Wed, Jul 16, 2008 at 01:13:03PM -0400, Daniel J Walsh wrote:
> > > >>>>> David Härdeman wrote:
> > > >>>>>> While working on SELinux-enabling a Debian system, I often Google for
> > > >>>>>> avc messages that show up in dmesg and 90% of the time it seems
> > > >>>>>> that the
> > > >>>>>> problem has already been solved in Fedora's version of the
> > > >>>>>> refpolicy but
> > > >>>>>> not in the upstream version.
> [...]
> > To be honest, from my perspective as an SELinux consumer and long-time
> > follower of this list, it seems to me that Fedora's policy is very
> > nearly becoming the de facto reference policy just by virtue of its more
> > active development.
> 
> What is probably not clear to you is that I focus on large scale
> changes/policy architecture, such as the experiment with ubac/rbac
> separations, building the enforcing X desktop policies, and the FCGlob
> file contexts experiment.  Being a distribution policy person, Dan is on
> the front lines handling bugs, while I am somewhat disconnected (Gentoo
> doesn't have nearly as many SELinux users).  As mentioned by others, Dan
> is working mainly on get things functioning.  Obviously, as upstream, I
> want things to work too, but Dan deserves much credit for the many
> policy adjustments that are required as software gets updated.  But to
> say that the Fedora policy has more active development is dead wrong.
> 


I completely agree.  Apologies for my poor wording. I didn't mean to
characterize it quite like that. I've been following the list long
enough to have seen several of your contributions. I believe that, like
Dan and Stephen, you've been very key in selinux development.

What I meant was this. The Fedora policy tends to be very quick to fix
bugs and make adjustments. It's maintainers are generally very
responsive.

When it comes to maintaining the refpolicy, these are qualities that I
would find desirable. I believe that refpolicy's value is diminished if
key fixes begin to lag behind specific distros, because then every other
distro that ships selinux either need to port the changes from Fedora,
or wait until refpolicy gets around to merging these changes.

There's nothing wrong with focusing on developing large features. It's
very necessary work. However, this may just be a sign that the refpolicy
has matured enough that its needs are changing. This seems similar to
the discussions of changing from a monolithic policy to a modular
policy.

Perhaps it needs more than a single point of contact for merging
patches. Alternately, similar to Linus' current role with the kernel, it
may just need someone whose focus is on merging the work of others
rather than developing large features themselves.



 ---Brett.


Having nothing, nothing can he lose.
		-- William Shakespeare, "Henry VI"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
