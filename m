Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5H3FQrT007256
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 23:15:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5H3FMot027338
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 03:15:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "bmcmurphy@dor.state.ma.us" <bmcmurphy@dor.state.ma.us>
Subject: Re: RBAC with Unix Groups/GUIDs
Date: Thu, 17 Jun 2004 13:14:03 +1000
Cc: selinux@tycho.nsa.gov, "Stephen C. Tweedie" <sct@redhat.com>
References: <6.1.1.1.0.20040616175353.02db7030@dor-exchange.dor.state.ma.us>
In-Reply-To: <6.1.1.1.0.20040616175353.02db7030@dor-exchange.dor.state.ma.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406171314.03961.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 17 Jun 2004 07:54, "bmcmurphy@dor.state.ma.us" 
<bmcmurphy@dor.state.ma.us> wrote:
> I think I know the answer to this, but is there any way in selinux to
> assign an entire group (GUID) to a selinux role instead of just adding
> individual users? We are using LDAP-based authentication and I'd like to be
> able to assign a GUID to a selinux role and be done with it, rather than
> having to muck with the selinux policy whenever I add a new user into the
> group. Maybe I'm missing something obvious. Wouldn't be the first time...

The mapping of Unix UID/GID to SE Linux identity is determined by the code in 
the login program, this can be a patched sshd or xdm type program or a PAM 
module called by /bin/login.  The SE Linux identity determines the permitted 
roles.

The code to map UID/GID to SE Linux identity currently tries to assign an 
identity of the Unix user-name, and failing that it uses an identity of 
"user_u" as a generic identity.

It would not be a difficult coding task to change the library code that does 
this to use the group name based on the GID as the SE Linux identity in some 
situations.

We could have an algorithm of:
1)  Try Unix login name (NB not the result of getpwuid() on the UID) as SE 
Linux identity and use it if it exists.
2)  Call getgrgid() on the primary GID for the user and try the group name as 
the SE Linux identity and use it if it exists.
3)  Use user_u if possible, otherwise fail the login.


I think that this would solve some problems raised by Steve Tweedie (among 
other people) regarding the use of NIS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
