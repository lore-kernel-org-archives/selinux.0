Subject: Re: [PATCH] permission value inconsistency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1128436261.28919.6.camel@twoface.columbia.tresys.com>
References: <1128436261.28919.6.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 12:00:46 -0400
Message-Id: <1128528046.24059.195.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-04 at 10:31 -0400, Joshua Brindle wrote:
> These patches fix permission and common permission values being
> incremented before they were successfully added. This may cause an
> inconsistency in the policy in the error case.

Isn't the error case fatal anyway?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
