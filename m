Date: Tue, 2 Jul 2002 12:25:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: ssh
In-Reply-To: <1025626012.1541.47.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207021222290.16879-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 2 Jul 2002, Timothy Wood wrote:

> Is there any particular reason openssh needs a patch to work with SE and
> ssh does not?.

The sshd daemon (whether from OpenSSH or not) needs to be patched to
transition to an appropriate security context for the user and to relabel
the user's ptys properly, just like login.  Strictly speaking, you could
run an unmodified sshd daemon, but you would be limited to a single user
domain and would lack the SELinux user identity information.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
