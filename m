Subject: Re: Labeling only policy and problems with booleans
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin.torok@level7.ro>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        fireflier-devel@lists.sourceforge.net, marius@cs.utt.ro
In-Reply-To: <1146058670.28745.117.camel@moss-spartans.epoch.ncsc.mil>
References: <200604021240.21290.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <200604172120.52193.edwin@gurde.com>
	 <200604232258.14004.edwin.torok@level7.ro>
	 <1146058670.28745.117.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 26 Apr 2006 10:13:09 -0400
Message-Id: <1146060789.15625.20.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-26 at 09:37 -0400, Stephen Smalley wrote:
> On Sun, 2006-04-23 at 22:58 +0300, Török Edwin wrote:
> > domain_auto_trans(unconfined_t,myapp_exec_t,myapp_t)
> > domain_auto_trans(initrc_t,myapp_exec_t,myapp_t)
> 
> Should be some higher level interface for running a program as a user
> app and as a daemon, right?  You don't want to make direct references to
> other modules' types if it can be avoided.

There isn't one currently for unconfined users, but that should be added
for 3rd party use.  There are two potentials for the initrc,
init_daemon_domain() and init_system_domain().  The first one is
(obviously) for daemons, and the second one is for short running
initialization-style processes such as mount and ifconfig; they both
have the same parameters, for example:

init_daemon_domain(myapp_t,myapp_exec_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
