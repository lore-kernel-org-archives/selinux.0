Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0SB2U87025207
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2009 06:02:31 -0500
Received: from atoll.udmvt.ru (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0SAxR6o015218
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2009 10:59:28 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n0SB2Nn1059307
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2009 15:02:25 +0400 (SAMT)
	(envelope-from spg@udmvt.ru)
Date: Wed, 28 Jan 2009 15:02:22 +0400
From: selinux@udmvt.ru
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] [libsemanage] Also check for the uppoer bound on
	user ids in /etc/login.defs
Message-ID: <20090128110222.GA15391@ruber.office.udmvt.ru>
References: <87k599fidc.fsf@anzu.internal.golden-gryphon.com> <496353FA.5020906@redhat.com> <87fxjwlc7f.fsf@anzu.internal.golden-gryphon.com> <1231254550.9746.53.camel@localhost.localdomain> <4963873A.2040701@redhat.com> <87wsd8j6c8.fsf@anzu.internal.golden-gryphon.com> <1231333052.16760.14.camel@localhost.localdomain> <87priyubui.fsf@anzu.internal.golden-gryphon.com> <49651258.9080607@redhat.com> <87hc49uast.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87hc49uast.fsf@anzu.internal.golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for breaking into your conversation,
but it was me who posted the bugreport.

(My name is Alexey G. Shpagin, I am system administrator and I am posting
here for a first time.)

On Thu, Jan 08, 2009 at 08:33:54AM -0600, Manoj Srivastava wrote:
> Hi,
> 
>  [Trimming the patch and early discussion]
> 
> On Wed, Jan 07 2009, Daniel J Walsh wrote:
> > Manoj Srivastava wrote:
> >> On Wed, Jan 07 2009, Stephen Smalley wrote:
> >>> As Dan pointed out, the UID_MAX value in login.defs is only used by
> >>> useradd, and is not even strictly enforced (useradd -u 60002 john works
> >>> just fine).  In an environment with a large number of users and a global
> >>> user database, you can certainly exceed 60000 users or you may even
> >>> happen to generate your uids in a manner that happens to put them all in
> >>> the upper part of the uid space.  There are real systems with uids >
> >>> 60000 for real users, yet the login.defs UID_MAX value has not been
> >>> changed on such systems because it is irrelevant and it isn't enforced
> >>> by anything.  So this patch would change behavior of libsemanage on such
> >>> systems in an undesirable manner.  And it wouldn't help with cases like
> >>> oracle where the pseudo user is added via useradd without any specified
> >>> uid at all.

I should note, that useradd -u 52 john works not even worse. What about the
systems, that have legal user uids below UID_MIN?
UID_MIN is also not enforced anywhere except the automatic uid generation in
useradd or maybe some custom pam modules (don't know of any).

> 
> >>> I think Dan's earlier posting gets to more of the fundamental problems
> >>> with genhomedircon's heuristics for finding home directory locations,
> >>> and we need to address his points if we want it to work in general.
> 
> >>         Fair enough. In that case, I would like to point out that the
> >>  current situation of only checking UID_MIN is causing actual problems
> >>  right now on real user systems, and making genhomedircon to incorrectly
> >>  guess where home directories exist.
> 
> >>         I'll treat this as an imperfect workaround until we fix
> >>  semodule, and then I'll just revert the patch for Debian systems.
> 
> > What does the passwd entry that it is getting fooled by look like?  Does
> > the account really need a real shell?  IE Do people actually login to
> > the home directory?
> 
>         I do not have passwd data from the machine in question, though I
>  can ask. What I do have are the results of fixfiles relabel / :

The accounts were created not by hand, but by (pre|post)install script of qmail
package. That script is not perfect (and already have some minor issues), but
still I'm not sure if adding system users with /bin/sh was done by mistake
or for some reason, yet to be checked.
In the case you are still curious, here they are:

alias:x:64010:65534:qmail alias,,,:/var/qmail/alias:/bin/sh
qmaild:x:64011:65534:qmail daemon,,,:/var/qmail:/bin/sh
qmails:x:64012:64010:qmail send,,,:/var/qmail:/bin/sh
qmailr:x:64013:64010:qmail remote,,,:/var/qmail:/bin/sh
qmailq:x:64014:64010:qmail queue,,,:/var/qmail:/bin/sh
qmaill:x:64015:65534:qmail log,,,:/var/qmail:/bin/sh
qmailp:x:64016:65534:qmail pw,,,:/var/qmail:/bin/sh

What I can't keep in mind anymore is the way I want it to be:

 1. Every nontrivial behavior (you call it heuristics) of libsemanage must be
    documented prior deployment (and documentation be referenced from at least
    semanage(8) man page). It looks like libsemanage already have enough
    heuristics and deserves it's own manpage in (8).
      I think, that the way of dependency of something perceived as component
    of selinux (that stated to have no relation to UNIX uids and accounts) on 
    records from /etc/passwd is pretty nontrivial. Something tells me, that it
    should somehow map UNIX accounts to selinux labels, but I can only guess about
    what is the exact process.
      Even more, hidden dependency on some_but_not_others config parameters from
    logins.defs is just the example of nontrivial and counterintuitional behavior.
    (It will be easier for me (without need for sources) to track down the issue if
    UID_MIN were not used too, or UID_(MIN|MAX) were used both).

 2. It is hard for me to determine, what are the login.defs' UID_MIN and UID_MAX for,
    and especially what they are not.
    The (only|best) way they can be used is during the initial configuration of
    libsemanage by postinstallation scripts that create SEPARATE configuration
    file for libsemanage and copy there all the needed settings from whatever
    you want. Maybe asking the administrator some questions. Also allowing him
    to reconfigure that again at his request.
    
    Only in separate configs should exists that UID_MIN, optional UID_MAX (and maybe
    also useful UIDS_EXCLUDE, USERS_EXCLUDE, and even better - GIDS_EXCLUDE,
    GROUPS_EXCLUDE) that will affect applications deploying libsemanage.
    They should be documented also, but if not, it will already be easier to guess
    their effect if they will live inside something like
    /etc/selinux/libsemanage/automatic_accounts_mapping.conf
    (well, at least easier for me).
    And it will be natural for [new] system administrator, who changed /etc/login.defs
    in some way, not to hope that it will affect selinux components in some other way.
    It will be natural for him to make an attempt to find corresponding selinux
    configuration parameters to correct them accordingly
    (if that seem appropriate for him).

Still I wonder whether some other selinux components (in other libraries) depend on
some old (more traditional than SELinux) UNIX configuration files in some way...

Consider this as a subjective opinion of a mediocre system administrator, that have
to deal with your creatures.
Thanks for your time and many thanks for that creatures.

--
Alexey G. Shpagin
System administrator
Volga Telecom

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
