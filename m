Date: Tue, 18 Dec 2001 13:29:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <lonnie@outstep.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
In-Reply-To: <1008698374.3c1f8406aded5@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0112181324340.4844-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 18 Dec 2001 lonnie@outstep.com wrote:

> Now then, after making the new domain, should I presume that I can simply use
> the standard "adduser" to put a user in that domain, and also use the
> standard "chown" to change the ownership of files to belong to the new domain?

No.  adduser hasn't been modified to be aware of SELinux, and chown only
deals with the Linux user and group attributes.  You need to define an
entry for the new user and his authorized roles in policy/users and an
entry for the new role and its authorized domain(s) in policy/rbac.  To
set the security context on the user's home directory, you can use the
new 'chcon' program.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
