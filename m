Date: Tue, 12 Mar 2002 10:05:24 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Reino Wallin <reino@oribium.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Firewall Policy
In-Reply-To: <1015894650.23617.1464.camel@matilda.oribium.com>
Message-ID: <Pine.GSO.4.33.0203120933540.10942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 12 Mar 2002, Reino Wallin wrote:

> I just posted a new release of my policy scripts for an application
> layer firewall. The scripts can be found at
> http://www.oribium.com/selinux/
> This release is pretty much better then the initial one. They are not
> yet ready for a production environment though.

Thanks.

> I have a few suggestions to improve the example policy as well.
>
> named_t:
>
> To make the nameserver to work as a slave server, we may consider to
> grant write permissions to named_conf_t:dir and named_conf:file:

I'd agree with Russell Coker's suggestion of defining a new type for
this purpose.

> inetd_t:
>
> If we allow inetd to setuid, then it will be more flexible, and the
> daemons can run as non root.

Ok.

> It seems the following line is needed on my machine, but I haven't
> actually checked this up more in detail.
>
> allow system_crond_t var_lib_rpm_t:dir { add_name remove_name write };

We've defined a new domain for the rpm utilities when run as system cron
jobs, and granted that domain the necessary permissions.  That domain
(along with many other changes to the example policy) will be included in
the next public release, which should be soon.

> I have modified the network.te, and net_contexts, to allow multiple
> NIC's and IPSEC features. Patches are enclosed. This will allow a more
> fine grained control as well.

Thanks.  These patches probably won't make it into the next public
release, but possibly in future releases.

> I think most policy developers will use the example policy as a starting
> point for their work. I suggest that all new policy scripts for domains
> should contain all the required networking capabilities, so we don't
> have to grant full networking rights to all domains anymore.

This is more difficult than it might seem.  Many applications end up
accessing the network transparently for various services, e.g. NIS lookups
to map uids to usernames, DNS lookups to lookup hosts and IP addresses,
NFS accesses, etc.  Hence, removing can_network for a given domain might
work in one environment that isn't using certain services but prevent the
application from functioning in other environments.

Nonetheless, the example policy is undergoing some changes to make it
easier to selectively apply the every.te rules to particular domains, and
to partition those rules into finer-grained subsets.

> As far as I can understand there is no need to grant an ftpuser or a
> popuser the right to change role, neither to have access to a shell. It
> seems appealing, just to grant a very limited set of rights to the
> default user, and add a few more user types, like a shell user and a
> trusted user. Am I wrong here? I am figuring to add a few new user types
> to my firewall policy. Please let me know your thoughts, and I may put
> something together that suits the example policy as well.

This depends on the degree of flexibility that you need from a given
service.  If you want the policy to be able to enforce different
restrictions based on the authorized domains for a given ftp user, then
you would presumably want a modified ftpd that transitions to a security
context with the user's identity, an appropriate role, and a derived
domain (similar to the derived domains used for user cron jobs).
A prototype of a modified ftpd was included in the initial public
release of SELinux along with a macro to define derived domains, but
this was phased out later and ultimately superseded by the modified sshd.
If you simply want the policy to treat all ftp sessions identically, then
you can use an unmodified ftpd with a very limited ftpd_t domain, as in
the current example policy.  In that case, you don't need to define any
user domains for ftp users.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
