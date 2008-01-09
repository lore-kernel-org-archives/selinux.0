Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <1316.1199904980@redhat.com>
References: <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil>
	 <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com> <17868.1199897484@redhat.com>
	 <1316.1199904980@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 14:19:18 -0500
Message-Id: <1199906358.9393.324.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 18:56 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Right, the latter is reasonable.
> > Requires adding the class and permission definition to
> > policy/flask/security_classes and policy/flask/access_vectors and then
> > regenerating the kernel headers from those files, ala:
> >   svn co http://oss.tresys.com/repos/refpolicy/trunk refpolicy
> >   cd refpolicy/policy/flask
> >   vi security_classes access_vectors
> >   <add new class to end>
> >   make
> >   make LINUX_D=/path/to/linux-2.6 tokern
> 
> Does this require rebuilding and updating all the SELinux rpms to know about
> the new class?

Policy ultimately has to be updated in order to start writing allow
rules based on the new class/perm.  libselinux et al doesn't have to
change.

If you have a "SELinux:  policy loaded with handle_unknown=allow"
message in your /var/log/messages, then new classes/perms that are not
yet known to the policy will be allowed by default, so the operation
will be permitted by the kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
