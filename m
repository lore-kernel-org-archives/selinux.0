Date: Mon, 10 Dec 2001 10:49:55 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: New security policy
In-Reply-To: <3C144994.8010308@pcez.com>
Message-ID: <Pine.GSO.4.33.0112101028390.13300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 9 Dec 2001, Shaun Savage wrote:

> sysdm_r    this for root to admin the system but can't change security
> of "system" types
> secoff_r    The is for security officer to set up the security for the
> system
> dataoff_r    this is the only person that can "see" users personal
> files/directories

You are likely to encounter difficulty in truly enforcing separation among
these roles.  Obviously, you can't let sysadm_r update the kernel or
its modules if you want to separate secoff_r, but even this is not
sufficient.  For example, if you let sysadm_r update /bin/login or
/etc/shadow, what prevents him from entering any role he wants?  Or if you
let sysadm_r update system libraries or programs executed by the other
roles, what prevents him from inserting arbitrary code of his choosing to
be executed by the other roles?  I'm not sure about dataoff_r - what
constitutes "personal" files/directories.  Obviously, if dataoff_r can
read a user's private keys, then he can obtain access to the user's
account and thus may be able to enter the other roles.

> I have compiled some of the selinux utils for RH7.2, I hope to do the
> rest this week.

As I've mentioned previously on the list
(http://marc.theaimsgroup.com/?l=selinux&m=100687390219347&w=2), we've
been working on updating the utility patches to RH7.2 and have updated
several of them already, so it seems that there is some duplication of
work here.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
