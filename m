Subject: Re: How to disable/remove MLS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ioannis Aslanidis <iaslanidis@flumotion.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <485FCB72.9030407@flumotion.com>
References: <485FC1FB.3030605@flumotion.com>
	 <1214237136.32762.64.camel@moss-spartans.epoch.ncsc.mil>
	 <485FCB72.9030407@flumotion.com>
Content-Type: text/plain
Date: Mon, 23 Jun 2008 12:31:47 -0400
Message-Id: <1214238707.32762.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-23 at 18:12 +0200, Ioannis Aslanidis wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello and thank you for the reply.
> 
> The problem here is that we also work with older systems (FC5) which do
> not have MCS implemented and cause compatibility problems when saving
> configuration file contexts. Migrating to a newer version is planned,
> but it will take a long while. In the meanwhile we need an intermediate
> solution.
> 
> In RHEL 5.1/5.2 is where I see the ':s0' tag when I do ls -Z. Any clues
> about that?

I believe that FC5 and RHEL5 have MCS enabled.  But the :s0 is hidden if
you are running mcstrans.

/sbin/service mcstrans status

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
