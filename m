Subject: Re: Firewall Policy
From: Reino Wallin <reino@oribium.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Russell Coker <russell@coker.com.au>, Rik van Riel <riel@conectiva.com.br>,
        SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0203120933540.10942-100000@raven>
References: <Pine.GSO.4.33.0203120933540.10942-100000@raven>
Content-Type: text/plain
Date: 13 Mar 2002 02:48:27 +0100
Message-Id: <1015984108.1595.45.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tis 2002-03-12 klockan 16.05 skrev Stephen Smalley:
> 
> > To make the nameserver to work as a slave server, we may consider to
> > grant write permissions to named_conf_t:dir and named_conf:file:
> 
> I'd agree with Russell Coker's suggestion of defining a new type for
> this purpose.
> 
I agree this is more secure. Should I use named_conf_t just for
/etc/named.conf and then use a new type like dns_masterzone_t for
/var/named/master and dns_slavezone_t for /var/named/slave ?

> > I think most policy developers will use the example policy as a starting
> > point for their work. I suggest that all new policy scripts for domains
> > should contain all the required networking capabilities, so we don't
> > have to grant full networking rights to all domains anymore.
> 
> This is more difficult than it might seem.  Many applications end up
> accessing the network transparently for various services, e.g. NIS lookups
> to map uids to usernames, DNS lookups to lookup hosts and IP addresses,
> NFS accesses, etc.  Hence, removing can_network for a given domain might
> work in one environment that isn't using certain services but prevent the
> application from functioning in other environments.
> 
> Nonetheless, the example policy is undergoing some changes to make it
> easier to selectively apply the every.te rules to particular domains, and
> to partition those rules into finer-grained subsets.
> 
Thanks. Since there are just a few applications, and a few user accounts
on a firewall, Russel Coker's suggestion to use nscd might be a good
solution in this particular case. I will continue to define fine grained
networking capabilities to the type enforcement files I am writing, and
hopefully get more experiences.
-- 
Reino Wallin, Oribium Labs
reino@oribium.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
