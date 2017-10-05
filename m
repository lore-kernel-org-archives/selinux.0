Date: Thu, 5 Oct 2017 00:47:39 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171005054739.GA10620@mail.hallyn.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-5-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002155825.28620-5-sds@tycho.nsa.gov>
Subject: Re: [RFC 04/10] netns,
 selinux: create the selinux netlink socket per network namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 02, 2017 at 11:58:19AM -0400, Stephen Smalley wrote:
> The selinux netlink socket is used to notify userspace of changes to
> the enforcing mode and policy reloads.  At present, these notifications
> are always sent to the initial network namespace.  In order to support
> multiple selinux namespaces, each with its own enforcing mode and
> policy, we need to create and use a separate selinux netlink socket
> for each network namespace.

...

> +static int __init selnl_init(void)
> +{
> +	if (register_pernet_subsys(&selnl_net_ops))
> +		panic("Could not register selinux netlink operations\n");
>  	return 0;
>  }

This doesn't seem right to me.  If the socket is only used to send
notifications to userspace, then every net_ns doesn't need a socket,
only the first netns that the selinux ns was associated, right?

So long as there is a way to find the netns to which an selinux ns
is tied, a userspace logger could even setns into that netns to listen
for updates, if it wasn't certain to be in the right ns when it ran.

Otherwise (I haven't peeked ahead) you'll have to keep the *list* of
net_ns which live in a given selinuxfs and copy all messages to all of
those namesapces?

-serge
