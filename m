Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2PFJZx6010155
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 10:19:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2PFJKR1016042
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 15:19:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h2PFJHj9016038 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 15:19:19 GMT
Date: Tue, 25 Mar 2003 10:17:50 -0500 (EST)
From: Chris Vance <cvance@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>, Chris Vance <cvance@tislabs.com>
Subject: Re: essential patches
In-Reply-To: <200303241800.48962.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0303251008370.31512-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Mar 2003, Russell Coker wrote:

> On Mon, 24 Mar 2003 16:33, Chris Vance wrote:
> > It seems that the errors you are seeing is a conflict with the concept of
> > "Core" policy and attempting to create a policy that provides least
> > privilege.  It's very difficult to have a policy that provides only "core"
> > services yet is usable as a general-purpose machine.
>
> No, the errors I am seeing are a result of the policy being so complex that
> it's beyond the ability of any small group of people to fully test it, so any
> removal of allow rules is likely to result in some breakage before it has
> gone through some public testing.
>
> > For example, the dhcpd domain was removed from the core policy, so
> > natually, it will fail to run correctly under a least privilege policy.
> > By removing domains from the core policy, programs may fail to transition
> > as you would like them to. In the case of ifconfig/dhclient, the
> > transition no longer occurs -- but this does not imply that all
> > permissions required by dhcpc_t should now be rolled into the policy for
> > ifconfig.
>
> I am aware of this.  I intentionally installed the dhcpc.te file in my policy
> as mentioned twice in my email.
>
> The issue is not something inherantly specific to dhcpc_t, the issue is that
> ifconfig lost some functionality and that dhclient was one (of potentially
> many) programs that rely on such functionality.

Sorry, this is a mistake on my part.  The interaction between some of
these domains is not clear, especially when it's not a configuration I
typically use.  Wayne has added the necessary rule back to the ifconfig
domain and cleanup up netutils.te.  I just committed these two changes to
Sourceforge.

> > Perhaps ssl clients should be running in a more
> > restrictive domain - don't they also require access to privileged
> > information, such as private keys?  Why run them directly in the user
> > domain?
>
> SSL clients don't require any special access to files or other local
> resources.  Consider an SSL web browser, it does not require any special
> access to files on disk (netscape runs in a separate domain to intentionally
> give it LESS access to files because of it's history).  But for a web browser
> to actually provide a benefit from SSL then it needs a source of good random
> numbers.  I recall an attack against an early version of Netscape which
> didn't generate pseudo-random numbers well enough.
>
> SSL is used for POP, IMAP, FTP, HTTP, and probably other protocols.  Currently
> apart from Netscape/Mozilla we don't have special domains for any of the
> clients for those protocols.

Even without using client-side certificates, the SSL protocol normally
requires a PKI.  Nearly all SSL clients will maintain a list of trusted
roots.  Replacing or inserting a new root can severely impact the security
of the SSL protocol.  I would consider this to be privileged information.
Sorry, private keys was just a simple example.

> There are more useful limitations that could be put in the core which would
> probably be less painful:
> Prevent sysadm_t from reading symlinks from untrusted users (along with a
> special policy for ls to allow sysadm_t to see what the links are).
>
> Support for multiple run_init type programs to allow delegating daemon
> start/stop permissions for some daemons (IE the database administrator can
> re-start the database).  I've already done more than half the work for
> this...
>
> We have to keep a balance between security and usability though if we want SE
> Linux to become popular.  My tree will continue to be usable by most people
> without too much pain, regardless of what is done with the NSA tree.

I would definitely agree that there is much work that must be done to get
make the policy useful for a larger audience.  I think the core policy is
a step in the right direction, an unfortunate side effect is that some
programs will no longer run under the core policy.  Otherwise, it's
impossible to secure a machine running an arbitrary set of applications
with unknown interaction.  The difficult problem has always been
understanding what programs do and why.

Look for commits to Sourceforge later today that cleanup some additional
core domains.  At a minimum, these will include syslogd, klogd, crontd,
logrotate.  If you have the opportunity to test them on non-redhat
systems, that would be great.

chris.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
