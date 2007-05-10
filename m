Subject: Re: Making Fedora a contributer friendly environment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmill@redhat.com>
Cc: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178812160.24335.35.camel@localhost.localdomain>
References: <1178291788.2702.10.camel@vorpal.macdev.com>
	 <200705091725.58679.opensource@till.name>
	 <1178805305.17816.29.camel@localhost.localdomain>
	 <200705101650.50233.opensource@till.name>
	 <1178812160.24335.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 May 2007 12:27:10 -0400
Message-Id: <1178814430.3504.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 11:49 -0400, Karl MacMillan wrote:
> [CC'd the selinux development list so that the developers are aware of
> these issues]
> 
> On Thu, 2007-05-10 at 16:50 +0200, Till Maas wrote:
> > On Do Mai 10 2007, Karl MacMillan wrote:
> > 
> > > When selinux is turned on again a full relabel of the filesystem is done
> > > to correct these problems. If the custom file context wasn't added to
> > > the database of file contexts (via a module or semanage) the file is set
> > > to the default label.
> > 
> > So will chcon in a scriptlet work, when an rpm is installed while selinux is 
> > not active?
> > 
> 
> Unfortunately it won't - does semanage / semodule work in this instance
> (it probably should so that users can turn selinux back on after
> disabling and doing package management).

semodule works with selinux disabled (it won't load the resulting policy
naturally, but it manipulates the policy store and regenerates the
policy files appropriately, so they would be used when selinux is next
enabled, and a relabel would happen at that time).  semanage has some
dependencies on libselinux (e.g. is_selinux_mls_enabled,
security_check_context) that should be converted to using libsemanage or
libsepol interfaces, and then there is the separate issue of the context
translation support.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
