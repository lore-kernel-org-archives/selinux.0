Date: Wed, 27 Mar 2002 13:33:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Forwarding X connections using ssh
In-Reply-To: <1017251782.2102.12.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0203271324060.8022-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 27 Mar 2002, Justin Smith wrote:

> I am using the latest release (2.4.18) of SELinux with no patches
> (beyond the bare release) and
>
> OpenSSH_3.1p1, SSH protocols 1.5/2.0, OpenSSL 0x0090602f
> (with the sshd on the remote machine provided by SELinux)
>
>  and have a problem forwarding X connections.
>
> Whenever I log in to a remote machine that is in enforcing mode
> I get the message
>
> Last login: Wed Mar 27 12:36:49 2002 from
> pool-141-158-41-46.phil.east.verizon.net
> /usr/X11R6/bin/xauth:  timeout in locking authority file
> /home/jsmith/.Xauthority
>
>
> and X connections are not authorized. When the remote machine is in
> permissive mode, there's no problem.
>
> The STRANGE thing is that there are no error messages from the kernel
> (so I can't modify the security policy to allow this).

I don't seem to have any problems forwarding X connections via ssh between
two SELinux systems here that are both running in enforcing mode.  Restart
klogd and trying it again, and verify that no messages are logged by the
AVC (avc:) or the security server (security_compute_sid:).  What are your
security option settings in your .config file?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
