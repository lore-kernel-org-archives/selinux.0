Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20294
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 11:36:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA24517
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 16:34:16 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id QAA24513
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 16:34:15 GMT
Date: Tue, 29 Oct 2002 17:36:07 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: New Apache policy
Message-ID: <20021029173606.A28387@lemuria.org>
References: <20021025164228.A18830@lemuria.org> <Pine.GSO.4.33.0210291020050.29605-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210291020050.29605-100000@raven>; from sds@tislabs.com on Tue, Oct 29, 2002 at 11:03:11AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 29, 2002 at 11:03:11AM -0500, Stephen Smalley wrote:
> A couple of questions about your Subversion policy, at least partly due to
> my ignorance of Subversion:
> 
> 1) Is there any way to run the server in a separate domain from httpd_t?
> Would this be possible via a domain transition on the module, or is the
> module not truly executed?  

Subversion is using an Apache module as the server, so it's run
entirely within Apache with no exec anywhere in sight. Same problem as
with PHP, which is why my current Apache/PHP policy is only for
PHP-as-CGI. 


> Alternatively, you might want to explicitly
> run the httpd that you use for SubVersion in a separate domain from any
> other instances of httpd so that there is no risk of the other daemons
> tampering with your repository.

Yes, that is definitely an option. However, all the tools assume a
regular webserver, e.g. the clients all assume port 80 for remote
access, etc.
How about offering this as an option, selectable via a define?
(only-svn-server, integrated-svn-server, seperated-svn-server)


> 2) How worthwhile is it to retain a separate domain for the client?  At
> present, the only important difference between the client domain and the
> ordinary user domain would appear to be the permissions to the repository.
> Does this correspond with the Linux protections (e.g. is the client
> program a setuid or setgid program for a user or group that has
> permissions to the repository, and ordinary users do not have any direct
> access to the repository)?  Why does the client need direct permissions to
> the repository at all if the server is used?  Is this for the local
> repository case?

Yes, Subversion offers both direct filesystem access and remote access
via the Apache/WebDAV_SVN server. For local access, it needs the
appropriate permission. I figured that the case of having a local
repository that your users shall _not_ access, while at the same time
having a remote one that they should is sufficiently rare that the
admin in that case should write his own policy.
Also, svnadmin requires local access to create new repositories. I'm 
not sure if this is intentional behaviour, but I've not been able to 
create a repository via remote access.

The main reason for giving the client tools a domain was to unify
server and client access, i.e. set up the repository so that it can
only be accessed by the proper tools. As with CVS, tampering directly
with the repository will corrupt it.
Also, this leaves the option of restricting access to the repository by
restricting access to the tools by using either unix or SELinux
permissions. I believe this consistency is worth the additional domain.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
