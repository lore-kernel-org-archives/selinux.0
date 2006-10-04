Subject: Re: newrole - adding capabilities for polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4523E1E5.7030907@us.ibm.com>
References: <451AEC39.2090409@us.ibm.com>
	 <1159450384.11489.5.camel@moss-spartans.epoch.ncsc.mil>
	 <451C3A37.8080509@us.ibm.com>  <4522E6DA.1000200@us.ibm.com>
	 <1159973532.19176.84.camel@moss-spartans.epoch.ncsc.mil>
	 <4523E1E5.7030907@us.ibm.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 12:52:22 -0400
Message-Id: <1159980742.19176.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 11:31 -0500, Michael C Thompson wrote:
> Stephen Smalley wrote:
> > That is not correct.  File system operations in Linux are based on the
> > fsuid, which shadows the euid unless explicitly set.
> 
> hmm, you are right (and I, alas, was wrong). However, the files will be 
> created with the egid being the calling user (as it stands). I imagine 
> we'd want to change that.

Not clear that it matters.  IIUC, pam_namespace already sets the user
and group ownership after creation, so the only reason we care about
euid/fsuid is ensuring that the directory isn't temporarily accessible
to the caller.  As long as the directory mode is owner-only (as I think
it is), the initial gid on the directory shouldn't matter.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
