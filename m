Date: Wed, 24 Apr 2002 08:43:04 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Reino Wallin <reino@oribium.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: iptables err
In-Reply-To: <1019631854.26933.12.camel@matilda.oribium.com>
Message-ID: <Pine.GSO.4.33.0204240841390.17117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 24 Apr 2002, Reino Wallin wrote:

> When I am executing /etc/init.d/iptables stop, the following error message appears:
>
> iptables: libiptc/libip4tc.c:384: do_check:
> Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
>
> It works just fine with the standard RedHat kernel.

You might need a newer version of iptables that corresponds with our base
kernel version.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
