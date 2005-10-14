Subject: Re: [PATCH] Conditional expression mapping fix
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129318103.2958.5.camel@twoface.columbia.tresys.com>
References: <1129318103.2958.5.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 16:56:56 -0400
Message-Id: <1129323416.3729.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-14 at 15:28 -0400, Joshua Brindle wrote:
> This patch fixes a condition where conditionals in modules did not have
> the boolean values in their expressions mapped correctly while linking.
> This would result in conditionals with incorrect expressions in the
> final policy.

Thanks, applied as of libsepol 1.9.18.  Also corrected an
unsigned/signed mismatch in the patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
