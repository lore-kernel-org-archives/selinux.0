Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA22714
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 10:03:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA14853
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 14:03:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA14849
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 14:03:05 GMT
Date: Tue, 23 Jul 2002 10:03:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brian May <bam@snoopy.apana.org.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux question
In-Reply-To: <20020723131932.EE9B4116C@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207230927000.4721-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 23 Jul 2002, Russell Coker wrote:

> On Wed, 17 Jul 2002 04:51, you wrote:
> > one thing I am still not clear on, how does selinux know to deny this:
> > >chsid system_u:object_r:user_netscape_rw_t ~/untrusted
> >
> > /home/bam/untrusted: Permission denied
> >
> > but not this:
> > >chsid bam:object_r:user_netscape_rw_t ~/untrusted

The first operation is denied by the policy/constraints configuration.  As
noted in the Configuring the SELinux Policy report, the constraint
definitions specify additional restrictions on permissions that can be
based on a combination of information from the user identity, TE, and RBAC
models.  These additional restrictions are specified as boolean
expressions that must be satisfied in order for certain permissions to be
granted.  The relevant statement from policy/constraints is:

constrain dir_file_class_set { create relabelto relabelfrom }
	( u1 == u2 or t1 == privowner );

This statement limits the ability to create or relabel files with
different user identities to domains that have the "privowner" attribute.

> I've run into a similar issue, some scripts such as dh_installdocs call "cp
> -a" which tries to do such a chsid and fails.  I think that "cp -a" should
> not preserve sids to avoid breaking compatability in such situations.
> Generally when "cp -a" is called you don't even want to preserve the UID,
> just the mode.
>
> What do you think?

cp -a or cp -p does attempt to preserve the owner and group as well as the
mode.  cp -a or cp -p will treat a failed chown as an error if the user is
root but will silently ignore failure if the user is non-root.  The
comment from the code says "If non-root uses -p, it's ok if we can't
preserve ownership. But root probably wants to know, e.g. if NFS disallows
it, or if the target system doesn't support file ownership."  The same
copying code is used by cp, install, and mv (for cross-filesystem moves).

We could have these utilities merely warn on failed chsid calls and not
return an error by default.  However, if we make such a change, we should
definitely add a command line option to force the utility to treat it as
an error for cases where this is desired.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
