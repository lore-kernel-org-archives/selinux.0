Subject: Re: [RFC] new libsepol policy representation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1170688132.12293.245.camel@moss-spartans.epoch.ncsc.mil>
References: <45C23E5F.5050503@mentalrootkit.com>
	 <1170688132.12293.245.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:23:59 -0500
Message-Id: <1170689039.12293.263.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-05 at 10:08 -0500, Stephen Smalley wrote:
> I'm not fundamentally opposed; we have in the past called for an
> appropriate IR for policy as a common basis for tools and
> infrastructure.
> 
> In skimming through the patch set, I'm unclear as to which aspects are
> intended to be part of the shared library interface vs. the static
> library interface.  In the current libsepol, include/sepol/policydb/
> contains private state that is only made available to shared library

s/shared/static/

> users, while the top-level header files in include/sepol define the
> shared library interface.  Of course, libsepol.map is the authoritative
> definition of the shared library interface.  If you intend to export
> things like hashtabs to shared library users, then we naturally need
> proper encapsulation and namespacing of them.
> 
> As a nit, there is a name collision between the existing sepol_node
> struct (for node aka host records) and your new sepol_node struct for
> the tree. 
> 
> Similarly, you would need to reconcile your sepol_security_context*
> functions with the existing sepol_context* record functions.  There may
> be other points of duplication/overlap; I haven't yet looked thoroughly.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
