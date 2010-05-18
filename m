Subject: Re: How to cross install policy store?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 May 2010 09:20:41 -0400
Message-ID: <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-18 at 18:17 +0500, Shaz wrote:
> 2010/5/18 Daniel J Walsh <dwalsh@redhat.com>:
> > You should be able to build the policy on a different maching and just
> > install it on the ARM box.
> 
> You mean it does not require to be cross compiled on a different
> machine for the target and you can just load it! I cannot agree to
> this until I try it. If it means that you cross compile it on a
> different machine and then load it on target seems to be what you mean
> .... the policy as far as I understand is suppose to be binary when it
> builds ...

The policy is in a binary format, but the binary format is
architecture-independent.  policy is a .noarch package in Fedora.
Policy is always written little endian and converted to cpu order at
load time.

> Today we got modular reference policy installed and loaded
> successfully after a weeks effort and crashing my special (most
> stable) build system. Setfiles was giving us problem. Tomorrow we do
> testing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
