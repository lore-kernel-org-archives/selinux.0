Message-ID: <45C8E749.4000606@mentalrootkit.com>
Date: Tue, 06 Feb 2007 15:38:33 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] new libsepol policy representation
References: <45C23E5F.5050503@mentalrootkit.com> <1170688132.12293.245.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170688132.12293.245.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> 
> I'm not fundamentally opposed; we have in the past called for an
> appropriate IR for policy as a common basis for tools and
> infrastructure.
> 
> In skimming through the patch set, I'm unclear as to which aspects are
> intended to be part of the shared library interface vs. the static
> library interface.  In the current libsepol, include/sepol/policydb/
> contains private state that is only made available to shared library
> users, while the top-level header files in include/sepol define the
> shared library interface.

I'm currently undecided about this, so I'm creating APIs that are 
appropriate for export and not planning on exporting them intially.

   Of course, libsepol.map is the authoritative
> definition of the shared library interface.  If you intend to export
> things like hashtabs to shared library users, then we naturally need
> proper encapsulation and namespacing of them.
> 
> As a nit, there is a name collision between the existing sepol_node
> struct (for node aka host records) and your new sepol_node struct for
> the tree. 
> 

Good catch - thanks.

> Similarly, you would need to reconcile your sepol_security_context*
> functions with the existing sepol_context* record functions.  There may
> be other points of duplication/overlap; I haven't yet looked thoroughly.
> 

I'm planning to reconcile these at a future point - my plan is that the 
records and the new policy structures will be fully merged at the end of 
this.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
