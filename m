From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Labeling only policy and problems with booleans
Date: Wed, 26 Apr 2006 21:18:20 +0300
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net,
        marius@cs.utt.ro
References: <200604021240.21290.edwin@gurde.com> <1146058670.28745.117.camel@moss-spartans.epoch.ncsc.mil> <1146060789.15625.20.camel@sgc>
In-Reply-To: <1146060789.15625.20.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604262118.21217.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 April 2006 17:13, Christopher J. PeBenito wrote:
> On Wed, 2006-04-26 at 09:37 -0400, Stephen Smalley wrote:
> >
> > Should be some higher level interface for running a program as a user
> > app and as a daemon, right?  You don't want to make direct references to
> > other modules' types if it can be avoided.
>
> There isn't one currently for unconfined users, but that should be added
> for 3rd party use. 
What about interface(`unconfined_domain',  (in unconfined.fc)?
> There are two potentials for the initrc, 
> init_daemon_domain() and init_system_domain().  The first one is
> (obviously) for daemons, and the second one is for short running
> initialization-style processes such as mount and ifconfig; they both
> have the same parameters, for example:
>
> init_daemon_domain(myapp_t,myapp_exec_t)
I'll use this one and unconfined_domain.

Is using unconfined_domain enough, or should I also add init_daemon_domain? 
Does init_daemon_domain grant any privileges that unconfined domain doesn't 
have?

I also need to remove the ability to load policy from an unconfined domain 
(see my previous mail), if I remove that from unconfined.te, build a base.pp, 
and distribute that along with fireflier, will that be ok? 
Or will you consider including a boolean to disable policy loading for 
unconfined domains (separate from the boolean that restrict policy loading 
for the kernel), so that I can turn off policy loading for unconfined 
domains, but keep it for "privileged" domains?


Thanks,
Edwin




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
