Subject: Re: LSM caps issue, selinux affected?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <407AE96B.5010500@snu.edu>
References: <407AE96B.5010500@snu.edu>
Content-Type: text/plain
Message-Id: <1081798373.20135.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Apr 2004 15:32:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-04-12 at 15:09, Joshua Brindle wrote:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108153697611991&w=2
> 
> Since Smalley or others haven't responded on that thread yet and I'm no 
> longer on the LSM list (the spam...) I'd like to get the opinion here, 
> how effective is this against selinux and is it serious enough that we 
> should issue security advisories? Pebenito says we should be unaffected 
> since we block ptrace by default, is that the common configuration?

It has to do with the separation of the capabilities logic from the core
kernel, not anything SELinux-related, although it should certainly be
fixed.  For SELinux, there are two scenarios:

1) If there was no domain transition on the program execution, then the
calling domain would need to be allowed to use the capabilities by the
SELinux policy.  Otherwise, it can't use them.

2) If there was a domain transition on the program execution, then the
program domain would need to be allowed to use the capabilities by the
SELinux policy, and the calling domain would be prevented from
interfering with the program domain by the policy, and the domain
transition would trigger inheritance controls and enable glibc secure
mode.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
