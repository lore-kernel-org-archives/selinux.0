Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15301
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:18:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA19819
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:16:35 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA19815
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:16:34 GMT
Date: Thu, 11 Jan 2001 13:17:57 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101111917.NAA33477@tomcat.admin.navo.hpc.mil>
To: bet@rahul.net, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: IPSEC integration (was Re: SELinux and covert channels)
Cc: Stephen Smalley <sds@tislabs.com>, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Bennett Todd <bet@rahul.net>:
> 
> Sounds like you're thinking along the same lines I am.

I've been "involved" (criticizing the lack of facility control) with
Legion and most of the other GRID/Metacomputing elements. To me this
is what would "fix" most of the shortcomings in all of them. My problem
is that they ASSUME that any mapping of security policy will be acceptable
to the various facilities they want to use for a common computational
environment. (No I don't trust RSA certificates from a university
proxy server... I don't trust kerberos tickets from a proxy server....
I don't care if they think is equivalent, it isn't the same.)

> Seems to me like there are a few very, very hard parts to this
> problem.

I've tried thinking about it too, from a host point of view.

> One is designing a database capable of flexibly representing the
> sort of permission and delegation relationships that show up in real
> organizations. That's a currently open problem, and I know lots of
> people are working on it. I kinda suspect by the time it gets
> solved, the other bits will be all lined up.
> 
> Another piece to the puzzle is providing facilities for a
> centralized policy specification database to be consistently
> enforced with a single mechanism; it seems like it's within the
> bounds of possibility that selinux, with some suitable integration
> with ipsec, may possibly provide the needed mechanism.
> 
> I could believe that a PK database of some sort may provide the glue
> required to associate identities as specified in the above policy
> database with real entities. I'd be happier if it didn't look so
> likely that the PK database will end up being based on the
> ugliest-of-all-possible-worlds design X.509, but I suppose that can
> be lived with.
> 
> Another component I've been thinking about is more a piece of
> plumbing that'll be needed to make things work as they should,
> rather than a fundamentally separate security component. The fantasy
> of a fine-grained integration of ipsec security associations with
> fine-grained, user/app level security policy specification, implies
> that ipsec security associations are going to be coming up and going
> down in a very fluid fashion. It seems to me that making working
> distributed apps is going to end up requiring dynamic routing
> through these transient tunnels. I'm still pondering that one,
> though. On the one hand it seems like OSPF's dynamically
> self-configuring, multicast flooding nature would be the responsive
> and maintainable approach to desire; on the other hand it seems like
> BGP4's simplicity of running through straight TCP connections is
> more likely to actually _work_ over ipsec. I'm hoping that this new
> evolution won't require actually inventing another working dynamic
> routing protocol, but I've not yet gotten a really happy feeling
> about that question.

Personally, I wouldn't be happy having to trust a routing protocol
for distributing security information. I think it would be too easy
to leak the security info to intermediate routers that have no business
examining the data. Even though routers should get trusted routing updates,
I don't think they should be responsible for forwarding other security
data on (less potential exposure that way).

I've been thinking about it as a "2 1/2" solution:

1. The SAD currently identified for IPSec is a long term cache for
   associations - current users logged in, current processes active. "Long
   term" here would mean hours. The SAD feeds the kernel security server
   (think module SELinux?) which has a short term cache (current processes
   and open connections). The SAD would be initialized from local configuration
   files only.

2. The SAD is given SA entries from a "authorization database server" that
   is long term. This database contains user login information, which when
   merged with a connection during login (whether local login or net login)
   is passed to the SAD for "active" enforcement.

1/2. The "authorization database server" could/should be able to communicate
   (over IPSec protected paths) to a "distributed security service". The
   DSS could be implemented as an extension of an LDAP server that is willing
   to accept updates from the various hosts (that it trusts for updates of
   course, and knows how to handle security labeled data). The contacted DSS
   would then pass the data up/down the a distribution tree of DSS servers
   in the same manner as an LDAP server should.

The DSS should only communicate with other trusted DSS units, passing
any signature traces or other autditing features supported/required.
That way a distributed application that starts on a server would gradually
(several minutes/hours) become known and accessable by clients.

The users view of this is:

Login to a host via current methods - A currently unencrypted telnet would
suddently become encrypted IFF both sides used IPSec. The SAD on the server
host would negotiate an encryption with the client host. The server socket
could be a normal telnet daemon (now a trusted daemon) using PAM. The PAM
authentication module would contact the authorization data base server to
establish the access rights and initial labeling of the users shell process.

If the user were using kerberos, then the target socket/SA should be able
to recognize the kerberos handshake:
a. the SA passes the connection to the authorization database server, which
   validates the service ticket and determines the authorizations of the user
   (this would probably be a client process of the database).
b. the authorization database server passes the results back to the SAD, which
   caches the results, and forwards them to the telnet daemon.
c. The telnet daemon uses the obtained SA and creates the user process. If
   forwarded tickets are provided, then they should be passed to the
   SAD/authorization database server for possible later use.

Note: the user may not be allowed access to sockets. The normal link between
the shell and the telnet daemon should be through local domain socket. The
user could be prevented from allocating/binding/listen on a socket. The
user could use trusted facilities (ftp, telnet for instance).

In this scenario, the user does not have direct access to the kerberos
tickets. (This way, he can't give them away..)

If the user can use sockets, then any socket created/conected to/listened on
would be mediated by the SA in the kernel at the time the user logged in (plus
any updates for other reasons...). The allocated socket would recieve the
label of the user, and the SA of the initial connection or a specified
authentication method.

This way, the user could not bypass controls over what/how/where communications
takes place.

This concepual outline tries to isolate the various parts of of the system.
The format of the databases is a major problem, allowing detection of
kerberos/RSA/... is still unknown (though it SHOULD be done in the AH/ESP
handshake during initial connection requests done by the remote security
server.

All data bases still have to be defined....
network handshaking...
creation of new daemons...
modification of daemons/clients...
acceptance by some standards body...

First, we have to get a platform to work from....
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
