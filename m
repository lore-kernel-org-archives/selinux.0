From: lonnie@outstep.com
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: User Policy Setup
Message-ID: <1008630113.3c1e796119000@mail.outstep.com>
Date: Mon, 17 Dec 2001 18:01:53 -0500 (EST)
Cc: SELinux Mailing <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0112171501191.10304-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112171501191.10304-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Stepnen,

That got the network up and running.

No I just need to figure out how to set up these user policies to lock the 
users. Your method shounds good, but I am not sure how to do it.

Best Regards,
Lonnie

Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Mon, 17 Dec 2001 lonnie@outstep.com wrote:
> 
> > I am still trying to work out my issues with getting the network
> working as I
> > am getting messages like "cannot send dump request" and "Error adding
> address
> > 192.168.1.5 for eth0".
> 
> Check your kernel configuration for your network driver and your
> network
> options.  Did you enable the Netlink support?  This seems to be
> necessary
> on RH7.2.
> 
> > My question is really about setting up the user policies. I have a
> special
> > project in which I need to confile the users to their HOME directories
> so that
> > they can NEVER navigate out of them. I also need to allow them to run
> just a
> > single application such as StarOffice, but still not let them navigate
> out of
> > their HOME directories even through the application.
> 
> I raised concerns about the practical feasibility of this kind of
> policy
> in my previous response to you.  However, if you really want to go
> down
> this road, you'll need to significantly pare down the example policy.
> You'll want to have a kernel with the Development Module option running
> in
> permissive mode so that you can easily experiment with policy changes
> without breaking your system.
> 
> You'll need to remove many of the file-related rules in
> policy/domains/every.te.  This file contains rules that are applied to
> every domain and assumes a relatively open environment with regard to
> read/search access to standard filesystem locations.  When you remove
> those rules, you'll find that many of the system domains will no
> longer
> have permissions that they need, so you will need to add back more
> specific rules to the individual files in policy/domains/system/*.te
> and
> policy/domains/program/*.te that grant these permissions to just the
> domains that need them.  Then you can work on pruning the user_domain
> macro in policy/domains/user/user.te to something more minimal.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
