Date: Wed, 23 Jan 2002 09:38:21 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Adding Accounts
In-Reply-To: <1440.192.168.1.12.1011792535.squirrel@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0201230929350.12859-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 23 Jan 2002, Lonnie Cumberland wrote:

> Is there an easier way to add users now that I have SELinux installed
> and running?

At present, to add new users that are recognized by the SELinux policy,
you must add an entry for the user to policy/users and reload the policy
(run 'make load' in the policy directory), and you must add contexts for
the user to the /etc/security/{default_context,cron_context} files.  The
need for per-user entries in the /etc/security files will go away once
we migrate to a new set of libsecure functions (see the
/etc/security/default_context vs. /etc/security/default_contexts thread
on the mailing list), pending on someone taking the time to finish that
work.

However, that will still leave the policy/users file.  Mark Westerman
suggested adding a general unprivileged user to the SELinux policy that
can be used for all unspecified users, and has been working on a patch to
implement support for such a user - see the General Users thread on the
mailing list.  This will work as long as you are ok with merely mapping
all such users to the same set of authorized roles (i.e. you do not need
the policy to separate such users) and you do not care about per-user
accountability for such users.   Otherwise, you will need to update
policy/users and reload the policy for new users.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
