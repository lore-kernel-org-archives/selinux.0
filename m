Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81GevrT022432
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 12:40:57 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81Ge8Y2013649
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:40:08 GMT
Subject: Re: DBus session bus -> separate security class?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <rcoker@redhat.com>
In-Reply-To: <1094054625.11084.34.camel@nexus.verbum.private>
References: <1094054625.11084.34.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1094056754.13328.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 12:39:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 12:03, Colin Walters wrote:
> I'm working on updating the DBus policy to handle the addition of the
> user session DBus instance.

In its own derived domain, using a macro, I hope.  $1_dbusd_t for $1 in
userdomain.

> So I think we really want:
> 
> allow cupsd_t userdomain:system_dbus { send_msg };
> allow user_mozilla_t user_networkmanager_t:session_dbus { send_msg };

Not clear that even this is what you want, as you may want to allow
different flows through the different user session bus instances.

It seems like a more general solution would be to alter the manner in
which dbusd labels its connections.  Instead of simply labeling them
with the peer context, you could call security_compute_create (which
internally maps to the kernel's security_transition_sid interface and
uses type_transition rules) on the peer context and the bus context, and
define type transition rules to map to derived types based on the pair
of contexts.

> I think unfortunately it's a bit late to change this for Fedora Core 3,
> so likely what we'll do is just not have the session bus be a userspace
> policy enforcer, or just run as user_t.  But long term I think we need
> separate security classes.

I don't think you want it to run in user_t or dbusd_t.  You want a
derived domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
