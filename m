Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91LdnsJ029126
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 17:39:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h91Ldm7d002427
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 21:39:48 GMT
Received: from out002.verizon.net (out002pub.verizon.net [206.46.170.141])
        by jazzband.ncsc.mil  with ESMTP id h91LdmRn002424 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 21:39:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: russell@coker.com.au, SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: SE-X and Crypto Discussions
Date: Wed, 1 Oct 2003 17:42:09 -0400
References: <200309302141.31559.wlsel@verizon.net> <200310011518.30077.russell@coker.com.au>
In-Reply-To: <200310011518.30077.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200310011742.09393.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I digested what you said here, Eamon's earlier comments about authentication, 
and my initial sketches of SE-N.

I concur that SSH already solves the authentication and tunneling concerns.

The issue now is how to transmit the remote Xclient's security context to the 
Xserver in a secure and trustworthy manner, so that the Xserver can (per your 
example) protect your trusted application from your IRC client.

The simplest approach would be to modify SSH to obtain the Xclient's context 
and then send it through the tunnel such that it is made available to the 
Xserver via the existing kernel interfaces.  The problem is that this is a 
ugly hack, it limits future inter-system context exchanging to an SSH 
paradigm, and worse will likely become a vulnerability as it presents an 
target for a skillful adversary to spoof the client security context to the 
Xserver--or whichever other server might choose to follow this precedent.

Properly, there has to be a uniform isolation of the inter-system security 
context exchanging apparatus so that it is completely invisible (and thereby 
inaccessible) to the end users.  Security-aware apps/servers would only 
indirectly invoke the apparatus when, for example, they requested a security 
context via, say, getsockopt() (and whose security extension can be 
controlled within policy).  System Administrators would see it only when they 
have to configure their hosts (more on this later).

The only way I can see to achieve this level of protection is to enhance the 
labeled networking option's concept of a "security perimeter" by encrypting 
the security contexts it stores in the IP Options field, using keys that are 
maintained by the kernel, so that the machine can not only accept both 
labeled and unlabeled traffic but can also securely transmit the security 
contexts over untrusted networks without the potential for being spoofed.

Cooperating SysAdmins can configure which hosts they'll exchange security 
contexts with (thus defining which security perimeters they are members of) 
by installing the public keys of those hosts within their machines (and maybe 
some mapping information to deal with heterogenous policy differences).  They 
would also have to open their firewalls to allow incoming traffic to the 
apparatus's listener.

The result of this is that when a security-aware server--not just Xserver, but 
any server--receives an incoming connection request, it can ask for the 
client's security context with a simple getsockopt() and enforce policy 
accordingly (or whatever it wants to do based on the context).  If 
getsockopt() reports no context associated with the socket, then the server 
can resort to a "catch-all" policy or perhaps refuse the connection.

This is SE-N:  Simple, elegant, and minimizes if not outright eliminates 
altogether openings for hackers to attack and/or spoof.  I just don't see how 
SSH, with the client side hopelessly under user control, can be made as 
secure for the purpose of exchanging security contexts that ultimately will 
affect policy enforcement.  If it can, show me where and how I'm missing it.

If it would help, I'll be happy to flesh SE-N out further in the form of a 
design specification.

Bill


On Wednesday 01 October 2003 01:18 am, Russell Coker wrote:
> On Wed, 1 Oct 2003 11:41, Bill Laut wrote:
> > I think this question is likely best directed to either Stephen or
> > Howard.
> >
> > I'm breaking this specific question out of the "X Windows Discussion"
> > thread so that it can be addressed separately by the appropriate
> > authority. Namely, it is my understanding that NSA employees are
> > forbidden from discussing cryptology in forums such as this one. 
> > Unfortunately, the X Windows thread will eventually have to address such
> > topics if we are to have meaningful dialog on how best to transmit policy
> > data over potentially untrustworthy networks.
>
> Why not just tunnel it over ssh?
>
> X tunneling over ssh works well, what do you think needs to be done that
> can't be done via ssh?
>
> ssh allows the client and the server to cryptographically prove their
> identity to each other.  The ssh client has appropriate authorization to
> connect to the X server, and the ssh server can start the X client process.
>
> The problem we need to solve is how to manage different X connections
> having different privs.  If I login to a trusted-host and want to run a
> trusted application and an IRC client, then how do I make sure that my
> trusted application's X window is protected from my IRC client?  As ssh
> currently doesn't support a choice of login contexts this is difficult to
> arrange unless we login to different Unix accounts.  It's not difficult to
> create two accounts with the same UID but different default roles for SE
> Linux, it is a bit of a hack though.
>
> Another possibility is to use different identity files in ssh and have
> different environment= options in the authorized_keys file.  This is
> perhaps a grosser hack, but it's user-controlled.  If we are going to
> implement hack solutions then perhaps we want both administrator and user
> controlled versions.
>
> If we determine that ssh in it's current form is incapable of doing what we
> want then we can modify it.  Such modifications do not require any changes
> to the crypto code, and as the NSA has already published similar ssh
> patches (the SE Linux patch) they obviously have no problems with such
> things.
>
> For upstream X server development the addition of SSL support would
> probably be a good thing.  But I don't think that has to be directly
> related to SE Linux work (although we will surely use it if someone else
> develops it).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
