Date: Fri, 17 Dec 2010 16:26:16 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: define permissions for DCB netlink messages
In-Reply-To: <1292521938-21874-1-git-send-email-eparis@redhat.com>
Message-ID: <alpine.LRH.2.00.1012171625300.20400@tundra.namei.org>
References: <1292521938-21874-1-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Dec 2010, Eric Paris wrote:

> Commit 2f90b865 added two new netlink message types to the netlink route
> socket.  SELinux has hooks to define if netlink messages are allowed to
> be sent or received, but it did not know about these two new message
> types.  By default we allow such actions so noone likely noticed.  This
> patch adds the proper definitions and thus proper permissions
> enforcement.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
