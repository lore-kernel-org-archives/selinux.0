Date: Fri, 6 Mar 2009 09:05:18 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: open perm for sock files
In-Reply-To: <1236278435.10235.2.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0903060905080.1773@tundra.namei.org>
References: <1236278435.10235.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Mar 2009, Eric Paris wrote:

> When I did open permissions I didn't think any sockets would have an open.
> Turns out AF_UNIX sockets can have an open when they are bound to the
> filesystem namespace.  This patch adds a new SOCK_FILE__OPEN permission.
> It's safe to add this as the open perms are already predicated on
> capabilities and capabilities means we have unknown perm handling so
> systems should be as backwards compatible as the policy wants them to
> be.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=475224
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
