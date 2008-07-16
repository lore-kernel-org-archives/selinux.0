Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GKGb3T028491
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 16:16:37 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GKGbwW005480
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 20:16:37 GMT
Message-ID: <487E57CE.8010806@kutulu.org>
Date: Wed, 16 Jul 2008 16:19:26 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Fedora refpolicy patches
References: <20080716165634.GA8072@hardeman.nu>	 <487E2C1F.4010308@redhat.com>  <20080716174410.GA9226@hardeman.nu> <1216232357.21191.76.camel@gorn>
In-Reply-To: <1216232357.21191.76.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

Having built up a few patches myself, I can say that my employer is (so 
far) willing to let me work on this kind of thing in my down time.  I'd 
be happy to help out, but I'm not sure where to jump in.

> The main points which would improve upstreaming efficiency from Dan's
> set are:
> 
> 1. description / justification
> 
> What this means tends to vary depending on what access is added by a
> patch.  A patch that allows reading of usr_t files probably doesn't need
> a big description while a patch that allows reading shadow_t does.
> "myapp breaks without this rule" isn't a very good explanation,
> especially if the access is questionable.  The app may be incorrectly
> requesting extra access or it might be a bug in the app.

I guess from my perspective there are two different things that I think 
I could help with if I knew how to proceed:

* Clearing the backlog from the current patchset.  For this, would it be 
helpful to go through the patches that Dan already posted and try to 
break them out and figure out what the justification was?  It would be 
time consuming, but for example, some of the samba changes I'm pretty 
sure I know what the motivation was, since I've made similar changes.

* Keeping the backlog from building up.  For this, would it help to have 
more people (e.g. like myself) watching bugzilla for problems and 
working up patches?  My main issue doing this right now is I don't run 
FC (I run Gentoo) but I could probably set up an environment to help 
out.  I'm also particularly aware of the problem Dan mentioned: other 
distributions aren't getting the benefits of his patches, and in some 
cases, even when they are upstreamed they are stuck behind an "if 
redhat" conditional.

> 2. style
> 
> The changes need to meet the refpolicy style guidelines.  Dan is pretty
> good about this, but with the volume, things still get by.

Are these published?  I try to make my changes "look like" existing 
policy but that's just my subjective guessing.

--Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
