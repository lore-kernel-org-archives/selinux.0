Subject: Re: [RFC v2][PATCH] refpolicy:  add memprotect and cap_override
	definitions and interfaces
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1181918560.17547.757.camel@moss-spartans.epoch.ncsc.mil>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil>
	 <1181918560.17547.757.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 12:56:10 +0000
Message-Id: <1182257770.4077.83.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-15 at 10:42 -0400, Stephen Smalley wrote:
> Introduce policy definitions and interfaces for the new memprotect and
> cap_override classes recently added to the kernel.
> 
> Since the prior version of the patch, two changes have been made:
> 
> - As observed by Eric Paris, we also need to exclude the file type for
> any domain that has cap overrides from being created or relabeled-to by
> unconfined_t or unconfined_t can create its own entrypoint program into
> such a domain, so add a files_cap_override() interface in addition to
> the domain_cap_override() interface.  I would have preferred a single
> interface but it doesn't seem to fit with the module encapsulation.
> 
> - Added a domain_mmap_low() interface for memprotect:mmap_zero.

I merged the memprotect portion, but I'm going to hold off on the
cap_override portion until the kernel support starts going upstream.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
