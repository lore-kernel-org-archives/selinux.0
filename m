Date: Mon, 8 Jul 2002 07:24:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: new LSM ver
In-Reply-To: <1025911273.8785.1.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207080720350.19100-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 5 Jul 2002, Timothy Wood wrote:

> Anyone notice that the default context for root in the new lsm package
> is a user_r and not sysadm_r?  Any specific reason for this change or is
> it a mistake?

This is mentioned in the selinux/ChangeLog, so it is a safe bet that it
wasn't a mistake.  As mentioned earlier on the list in discussing the
recent sshd bugs, I removed direct transitions from sshd_t to sysadm_t
from the sshd.te file, thus requiring an explicit newrole.  Hence, it was
only logical to also change the default login context for root to user_r.
This is also simply safer as a default behavior.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
