Date: Thu, 15 Aug 2002 08:50:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: security_t:security compute_av
In-Reply-To: <200208142211.WAA00113@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0208150846560.5077-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 15 Aug 2002, Carsten Grohmann wrote:

> I found follow rule in the crond and fcrond rules.
>
> allow crond_t security_t:security compute_av;
>
> But I don't found enough about it. Only the type declaration in
> policy/types/security and other little things. I missing something a
> documentation the object classes and the permissions.
>
> Can anybody give me a hint in which documentation I can found more.

This rule allows crond to call the new security_compute_av system call,
whic is used to perform permission checks.  The modified crond performs
a file entrypoint permission check between the user cron job security
context and the crontab file security context to protect against the
execution of jobs by a more privileged context from a malicious crontab
created by a less privileged context.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
