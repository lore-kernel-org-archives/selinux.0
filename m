Date: Fri, 19 Apr 2002 10:51:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, <SELinux@tycho.nsa.gov>,
        "'hdholm@epoch.ncsc.mil'" <hdholm@epoch.ncsc.mil>
Subject: Re: Generic SELinux Package
In-Reply-To: <20020418172054.1ADDB28606@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204191046390.18117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Russell Coker wrote:

> It probably wouldn't be that difficult to make mount_root() not load the
> policy when an initrd is being used and to then have change_root() do it
> later.  In fact it seems to easy that I might have a hack at it later tonight
> (although maybe Steve knows of something that'll make this extremely
> difficult and painful).

I don't think that this would be difficult, but it seems less desirable
than the alternative you mention below, i.e. placing a minimal policy on
the initrd to allow bootstrapping and reloading the policy once the
real root filesystem has been mounted.  It might be good to have an
additional hook to permit the security module to try reloading the policy
itself after a change in the root filesystem, rather than requiring init
to do it.

> That said, it shouldn't be that difficult to have a mini-policy on the initrd
> which is used to keep the system going until after init has been run, so init
> can then run load_policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
