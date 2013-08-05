Date: Mon, 5 Aug 2013 14:07:32 -0500
From: Dan Pou <danielp@sgi.com>
To: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Programmatic domain change to unprivileged role
Message-ID: <20130805190732.GT18909@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have an existing daemon that I am working to enable in an MLS setting,
but I am running into difficulties with calls to get a context of an
unprivileged user from the daemon context
(system_u:system_r:<name-of-service>_t:s0-s15:c0.c1023).
The deamon will run an executable with ID of an authenticated user, so I
looked at trying to replicate the method used by sshd.
When sshd calls get_default_context, there is a transition defined to go
to the user_u:user_r:user_t domain, but there is not one available from
the daemon context I have developed.
Is there a simpler example than ssh that I could look at to understand
how to specify transitions?
The daemon uses the fork+execve method, so I don't think that I need the
dyntransition method, but it is not clear to me how to specify all the
required transitions for executing any file available to an unprivileged
user.

Thanks,
Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
