Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GIJcP1004923
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 14:19:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6GIJcCD003117
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 18:19:38 GMT
Subject: Re: Fedora refpolicy patches
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <20080716174410.GA9226@hardeman.nu>
References: <20080716165634.GA8072@hardeman.nu>
	 <487E2C1F.4010308@redhat.com>  <20080716174410.GA9226@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 16 Jul 2008 14:19:17 -0400
Message-Id: <1216232357.21191.76.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-16 at 19:44 +0200, David Härdeman wrote:
> On Wed, Jul 16, 2008 at 01:13:03PM -0400, Daniel J Walsh wrote:
> >David Härdeman wrote:
> >> While working on SELinux-enabling a Debian system, I often Google for
> >> avc messages that show up in dmesg and 90% of the time it seems that the
> >> problem has already been solved in Fedora's version of the refpolicy but
> >> not in the upstream version.
> ...
> >> The question is how to treat the patches after that? Should I post them
> >> as I go through them (a couple per day for a couple of weeks?) and hope
> >> that someone at Tresys will apply them?
[...]
> I guess what I'm really wondering is if I can help you in some way? 

The main points which would improve upstreaming efficiency from Dan's
set are:

1. description / justification

What this means tends to vary depending on what access is added by a
patch.  A patch that allows reading of usr_t files probably doesn't need
a big description while a patch that allows reading shadow_t does.
"myapp breaks without this rule" isn't a very good explanation,
especially if the access is questionable.  The app may be incorrectly
requesting extra access or it might be a bug in the app.

2. style

The changes need to meet the refpolicy style guidelines.  Dan is pretty
good about this, but with the volume, things still get by.

3. patch composition

A patch should be a changeset.  So if a rule is added to a bunch of
domains for the same reason, then that should be in a single patch by
itself.  If you add an interface so some modules can call it, that
should be a single patch that includes the new interface and the
additions to the callers.  This enables me to review the change as a
whole, and not have distractions from unrelated changes.  A set of small
fixes to a single module can be a single patch.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
