Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h915IgsJ022999
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 01:18:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h915IfCG022321
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 05:18:41 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h915IdqJ022317 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 05:18:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bill Laut <wlsel@verizon.net>,
   SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: SE-X and Crypto Discussions
Date: Wed, 1 Oct 2003 15:18:30 +1000
References: <200309302141.31559.wlsel@verizon.net>
In-Reply-To: <200309302141.31559.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310011518.30077.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003 11:41, Bill Laut wrote:
> I think this question is likely best directed to either Stephen or Howard.
>
> I'm breaking this specific question out of the "X Windows Discussion"
> thread so that it can be addressed separately by the appropriate authority.
>  Namely, it is my understanding that NSA employees are forbidden from
> discussing cryptology in forums such as this one.  Unfortunately, the X
> Windows thread will eventually have to address such topics if we are to
> have meaningful dialog on how best to transmit policy data over potentially
> untrustworthy networks.

Why not just tunnel it over ssh?

X tunneling over ssh works well, what do you think needs to be done that can't 
be done via ssh?

ssh allows the client and the server to cryptographically prove their identity 
to each other.  The ssh client has appropriate authorization to connect to 
the X server, and the ssh server can start the X client process.

The problem we need to solve is how to manage different X connections having 
different privs.  If I login to a trusted-host and want to run a trusted 
application and an IRC client, then how do I make sure that my trusted 
application's X window is protected from my IRC client?  As ssh currently 
doesn't support a choice of login contexts this is difficult to arrange 
unless we login to different Unix accounts.  It's not difficult to create two 
accounts with the same UID but different default roles for SE Linux, it is a 
bit of a hack though.

Another possibility is to use different identity files in ssh and have 
different environment= options in the authorized_keys file.  This is perhaps 
a grosser hack, but it's user-controlled.  If we are going to implement hack 
solutions then perhaps we want both administrator and user controlled 
versions.

If we determine that ssh in it's current form is incapable of doing what we 
want then we can modify it.  Such modifications do not require any changes to 
the crypto code, and as the NSA has already published similar ssh patches 
(the SE Linux patch) they obviously have no problems with such things.

For upstream X server development the addition of SSL support would probably 
be a good thing.  But I don't think that has to be directly related to SE 
Linux work (although we will surely use it if someone else develops it).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
