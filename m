Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Janak Desai <jdesai@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120076573.20484.93.camel@celtics.boston.redhat.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
	 <1120075771.3553.234.camel@moss-spartans.epoch.ncsc.mil>
	 <1120076573.20484.93.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:54:45 -0400
Message-Id: <1120139685.11798.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 16:22 -0400, Ivan Gyurdiev wrote:
> I don't have the list archived that far back,
> but from reading about this online it looks like an analog
> to file_type_auto_trans, which doesn't work, because
> of ambiguity. Pre-creating things is required, which
> currently works via matchpathcon....

So far, the polyinstantiated directory support has only considered
automated creation of the per-user/role/level directories, not anything
within them (except for setup code for preserving X-related sockets
in /tmp and .Xauthority in $HOME to allow it to work with gdm).  Hence,
it would need to be extended to allow more general setup, e.g. copying
in skeleton files when a per-role directory is first created and setting
up their contexts as appropriate.  Which might require some kind of
configuration, not necessarily file_contexts/matchpathcon.

> That makes sense for the mount point itself, but not
> for sub-content.

Yes, it is only dealing with the per-role directory at present.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
