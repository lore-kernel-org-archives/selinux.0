Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OElLOb007210
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 10:47:21 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430C820B.3090905@trustedcs.com>
References: <430A33E5.1030100@redhat.com>
	 <1124804758.7874.46.camel@moss-spartans.epoch.ncsc.mil>
	 <430C820B.3090905@trustedcs.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 10:34:47 -0400
Message-Id: <1124894087.11553.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 09:19 -0500, Darrel Goeddel wrote:
> We (TCS) are including the label translation files under /etc/selinux
> (protected at system high as selinux_config_t) because we view this as part of
> the SELinux configuration.

Ok, but what happens when this mapping (plus the Linux user->{SELinux
user, allowed category set} mapping) gets pushed into an LDAP directory?
One of the points of separating it from the policy is so that you can
ship a single relatively static policy and local admins can manage their
site-specific settings without touching the policy proper, iirc.

>   This works for us because we have a daemon which is
> the single user of this file other than the security admin.  Our libsetrans is
> simply a communication library to the daemon.  If the file is read directly by
> users of libselinux, it needs to be protected in such a way that everyone who
> can make a call into libselinux can read the file.  Note that we have a similar
> issue regarding users of libselinux - they must be able to contact the daemon.
> We have created a policy macro for things that use our daemon via libselinux.
> Perhaps we should introduce an attribute that identifies users of libselinux.
> This attribute can then be used to grant read access to the config file in
> RedHat's case and access to the daemon in our case.
> Any thoughts on that?  Maybe 'privsetrans'?

Explicit macro interfaces are preferable, e.g.
uses_libselinux(name_of_domain).  But a point to note here is that
different users of libselinux have different permission requirements,
e.g. some only need to use interfaces like getfilecon/getcon and do not
need access to the policy files (other than the translation mapping) or
selinuxfs.  There are already macros for things like can_getcon and
can_getsecurity, so possibly we want specific macros along those lines
rather than a generic uses_libselinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
