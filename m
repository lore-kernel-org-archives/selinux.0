Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA21027
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:46:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA28470
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 17:44:48 GMT
Received: from unicorn.lemuria.org (b067018.adsl.hansenet.de [62.109.67.18])
	by jazzswing.ncsc.mil  with ESMTP id RAA28465
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 17:44:47 GMT
Date: Tue, 29 Oct 2002 18:45:39 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: New Apache policy
Message-ID: <20021029184539.A16049@lemuria.org>
References: <20021029173606.A28387@lemuria.org> <Pine.GSO.4.33.0210291146020.29605-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210291146020.29605-100000@raven>; from sds@tislabs.com on Tue, Oct 29, 2002 at 12:09:30PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 29, 2002 at 12:09:30PM -0500, Stephen Smalley wrote:
> > The main reason for giving the client tools a domain was to unify
> > server and client access, i.e. set up the repository so that it can
> > only be accessed by the proper tools. As with CVS, tampering directly
> > with the repository will corrupt it.
> 
> It would offer some limited integrity protection in terms of ensuring that
> the transactions on the repository are well-formed (i.e. only permitting
> transactions implemented via svn, svnlock, or svnadmin commands).  But it

Correct. It protects from mistakes, not malicious intent.

I still see the value in it, especially given that Subversion is still
in development - who knows what kinds of access controls and other fine
print the team might still add? Running in its own domain, the policy
is ready for whatever they come up with.

Also, I may think about restricting _local_ access for these tools,
because they are connecting outwards to potentially hacked and/or
malicious servers.


> > Also, this leaves the option of restricting access to the repository by
> > restricting access to the tools by using either unix or SELinux
> > permissions.
> 
> With a client program domain, this would take the form of only specifying
> svn_domain() for certain user domains as opposed to all of them.  Without
> a client program domain, it would simply consist of only allowing certain
> user domains to directly access the repository type.

You're right, it doesn't make much of a difference.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
