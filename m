Date: Tue, 15 Jan 2002 14:05:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: newrole logging
In-Reply-To: <3C44712E.2020807@pcez.com>
Message-ID: <Pine.GSO.4.33.0201151354430.2365-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 15 Jan 2002, Shaun Savage wrote:

> The information in the log is not enough.  I want "time, who,
> old_context, new_context, result"
> Should I just add a syslog routine into newrole, or is there a way to
> doit via the selinux auditallow?

It might be sufficient to audit the process transition permission checks.
There are two such checks performed during a newrole - the first is
between the original user domain and the newrole_t domain and the second
is between the newrole_t domain and the new user domain.  To audit all
uses of newrole to transition from user_t to sysadm_t, you would do:
	auditallow user_t newrole_t:process transition;
	auditallow newrole_t sysadm_t:process transition;

> But it does not like the umount one, any help??

The permission is named 'unmount'.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
