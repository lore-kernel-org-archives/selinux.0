Reply-To: <jayendren@hivsa.com>
From: "Jayendren Anand Maduray" <jayendren@hivsa.com>
To: "'steven harp'" <steven.harp@adventiumlabs.org>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Limiting the power of can_network, improving the security of strict policy.
Date: Wed, 27 Oct 2004 19:27:48 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAAtvBgX3z5LkOux3E0aOx0UAEAAAAA@hivsa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200410271017.59218.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi ppl!

Just wondering about SELinux,
Are there n e plans to incorporate biometrics as well as VOS (Virtual
Operating System) architecture to allow a more secure method of
authentication?
God bless. 

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of steven harp
Sent: 27 October 2004 05:18 PM
To: SELinux
Subject: Re: Limiting the power of can_network, improving the security of
strict policy.

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 27 October 2004 10:04 am, Daniel J Walsh wrote:
> We have been talking about ways of improving the security of strict 
> policy.  So I have been working
> ...
> Finally we are looking into limiting the power of can_network.  
> Currently any daemon that has can_network can receive
> and establish TCP/UDP connections.  The only thing not provided is 
> name_bind.  I want to break this out to eliminate the
> ability for daemons also to connect.  So an incoming only daemon, can 
> not establish a connection back out.  To do this
> I have modified create_socket_perms and eliminated the connect call.  I 
> have added a connect_socket_perms which includes
> the create_socket_perms.  This has caused many changes to be made in 
> policy, and I am not sure if it was a good idea?
> 
> Also I modified can_network to take a second parameter of the type of 
> the connection (udp or tcp).  This allows you to turn off tcp, connections
> on a UDP application.  (I am not sure you can do this for a tcp only app 
> if they are going to use name service.)
> 
> Is this a good idea or am I wasting my time?

I like the direction of suggested mods to can_network.  I've mostly
abandoned 
use of this macro for a suite of distributed applications I'm working
on since it does usually offer more than any one of the apps really needs.
Providing more modular connection-oriented constructions would be useful.

Steven Harp

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBf7whPcFX9H2zuSkRAkH5AJ4k9QD/ORwZMIwVRMHdOP3BRb322gCeJzH1
y7M2WZa0BwL14wz8/gwbPn8=
=p0WO
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
