Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HI0bri006025
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 14:00:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6HI0bf6025437
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 18:00:37 GMT
Subject: Re: Fedora refpolicy patches
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <487E57CE.8010806@kutulu.org>
References: <20080716165634.GA8072@hardeman.nu>
	 <487E2C1F.4010308@redhat.com>  <20080716174410.GA9226@hardeman.nu>
	 <1216232357.21191.76.camel@gorn>  <487E57CE.8010806@kutulu.org>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 14:00:12 -0400
Message-Id: <1216317612.21191.89.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-16 at 16:19 -0400, Mike Edenfield wrote:
> Christopher J. PeBenito wrote:
> 
> Having built up a few patches myself, I can say that my employer is (so 
> far) willing to let me work on this kind of thing in my down time.  I'd 
> be happy to help out, but I'm not sure where to jump in.
> 
> > The main points which would improve upstreaming efficiency from Dan's
> > set are:
> > 
> > 1. description / justification
> > 
> > What this means tends to vary depending on what access is added by a
> > patch.  A patch that allows reading of usr_t files probably doesn't need
> > a big description while a patch that allows reading shadow_t does.
> > "myapp breaks without this rule" isn't a very good explanation,
> > especially if the access is questionable.  The app may be incorrectly
> > requesting extra access or it might be a bug in the app.
> 
> I guess from my perspective there are two different things that I think 
> I could help with if I knew how to proceed:
> 
> * Clearing the backlog from the current patchset.  For this, would it be 
> helpful to go through the patches that Dan already posted and try to 
> break them out and figure out what the justification was?  It would be 
> time consuming, but for example, some of the samba changes I'm pretty 
> sure I know what the motivation was, since I've made similar changes.

Yes.

> * Keeping the backlog from building up.  For this, would it help to have 
> more people (e.g. like myself) watching bugzilla for problems and 
> working up patches?

You could do that, or if Dan has his patch set available from a repo or
even just a ftp/web site, you could just look through that.

>   My main issue doing this right now is I don't run 
> FC (I run Gentoo) but I could probably set up an environment to help 
> out.  I'm also particularly aware of the problem Dan mentioned: other 
> distributions aren't getting the benefits of his patches, and in some 
> cases, even when they are upstreamed they are stuck behind an "if 
> redhat" conditional.

Well we definitely want distro-specific behaviors to be controlled by
build options like distro_redhat, distro_gentoo, etc.  If something
turns out to be general, then theres nothing wrong with pulling it out
of an ifdef block.

> > 2. style
> > 
> > The changes need to meet the refpolicy style guidelines.  Dan is pretty
> > good about this, but with the volume, things still get by.
> 
> Are these published?  I try to make my changes "look like" existing 
> policy but that's just my subjective guessing.

There is an interface naming guide, but not a written up style guide for
the remainder of the policy.  If people are becoming interested in
helping out, then I can write that up.  In short, most things tend to be
in alphabetical order.  In the TE policy, you do the declarations, then
the raw allow rules, then calls to other modules interfaces' sorted
first by layer (bottom up) then by alpha order.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
