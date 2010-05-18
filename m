MIME-Version: 1.0
In-Reply-To: <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 18 May 2010 22:40:00 +0500
Message-ID: <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
Subject: Re: How to cross install policy store?
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> The policy is in a binary format, but the binary format is
>> architecture-independent.  policy is a .noarch package in Fedora.
>> Policy is always written little endian and converted to cpu order at
>> load time.

I still don't get it.

> BTW, as Dan noted, if I were building policy for such a system, I would
> do it entirely on the build/development host and then only deploy the
> generated policy files to the target system.  Then you don't even
> need /etc/selinux/$SELINUXTYPE/modules/* or /usr/share/selinux/* on the
> target system, nor do you need libsemanage, semodule, or semanage on it.
> When you want to make a change to policy, you do it on the
> build/development host, regenerate the policy, and then distribute the
> generated policy files to the target systems using your favorite
> distribution mechanism.

Indeed the libs you listed are not required on target even for our
current usecase but we have a usecase for it in mind so trying to
figure out all the technical stuff before hand and in one go because
it's tough to change mental set over and over again. I deal with many
things all at the same time. We will have problem of performance but
after all it starts with experiments :) And performance for embedded
systems is improving at a good pace.

> I'd also consider just building the policy monolithically for such a
> system rather than modularly.  Then you can easily just install directly
> to the target image without having to touch /etc/selinux on the
> build/devel host.

The usecase as I mentioned earlier is better this way but our future
usecases need modular policy this and much more then booleans etc.

> Lastly, I'm not sure I'd start from refpolicy.  It depends on how close
> the target environment matches a typical Linux distribution.  If it is
> radically different in the userspace and the filesystem layout (e.g.
> Android), I'd be tempted to instead start from a minimal policy (e.g.
> one generated via scripts/selinux/mdp in the kernel source tree or a
> hand-crafted one) and work my way up to construct a working system.

We work on debian derivatives and I was thinking to look at the
reference policy sister policy for ubuntu to try. I was also thinking
to try the selinux-notebook sources but I am still not sure .... still
too many priority issues before that.

> --
> Stephen Smalley
> National Security Agency
>
>

Anyways, thanks for the tips Steven. We will need your guidance with
more sophisticated issues all along.

-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
