Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6ICX2Fb006663
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 08:33:02 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6ICX1AI022099
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 12:33:02 GMT
Subject: Re: Fedora refpolicy patches
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Brett Lentz <blentz@cardomain.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
        selinux@tycho.nsa.gov
In-Reply-To: <1216238975.4832.11.camel@blentz>
References: <20080716165634.GA8072@hardeman.nu>
	 <487E2C1F.4010308@redhat.com> <20080716174410.GA9226@hardeman.nu>
	 <1216232357.21191.76.camel@gorn> <487E451C.5000603@redhat.com>
	 <20080716192942.GA11166@hardeman.nu>  <487E4EAD.5070207@redhat.com>
	 <1216238975.4832.11.camel@blentz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 18 Jul 2008 08:32:34 -0400
Message-Id: <1216384354.21191.106.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-16 at 13:09 -0700, Brett Lentz wrote:
> On Wed, 2008-07-16 at 15:40 -0400, Daniel J Walsh wrote:
> > David Härdeman wrote:
> > > On Wed, Jul 16, 2008 at 02:59:40PM -0400, Daniel J Walsh wrote:
> > >> Christopher J. PeBenito wrote:
> > >>> On Wed, 2008-07-16 at 19:44 +0200, David Härdeman wrote:
> > >>>> On Wed, Jul 16, 2008 at 01:13:03PM -0400, Daniel J Walsh wrote:
> > >>>>> David Härdeman wrote:
> > >>>>>> While working on SELinux-enabling a Debian system, I often Google for
> > >>>>>> avc messages that show up in dmesg and 90% of the time it seems
> > >>>>>> that the
> > >>>>>> problem has already been solved in Fedora's version of the
> > >>>>>> refpolicy but
> > >>>>>> not in the upstream version.
[...]
> To be honest, from my perspective as an SELinux consumer and long-time
> follower of this list, it seems to me that Fedora's policy is very
> nearly becoming the de facto reference policy just by virtue of its more
> active development.

What is probably not clear to you is that I focus on large scale
changes/policy architecture, such as the experiment with ubac/rbac
separations, building the enforcing X desktop policies, and the FCGlob
file contexts experiment.  Being a distribution policy person, Dan is on
the front lines handling bugs, while I am somewhat disconnected (Gentoo
doesn't have nearly as many SELinux users).  As mentioned by others, Dan
is working mainly on get things functioning.  Obviously, as upstream, I
want things to work too, but Dan deserves much credit for the many
policy adjustments that are required as software gets updated.  But to
say that the Fedora policy has more active development is dead wrong.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
