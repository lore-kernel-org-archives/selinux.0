Message-ID: <3E598D32.390F96D9@att.net>
Date: Sun, 23 Feb 2003 19:10:42 -0800
From: Gerald E <gwe3409@att.net>
MIME-Version: 1.0
To: Brian May <bam@snoopy.apana.org.au>
CC: Joshua Brindle <JBrindle@snu.edu>, SELinux@tycho.nsa.gov
Subject: Re: XML ACL standard ratified
References: <se55ee2c.092@atlas.snu.edu> <20030222034752.GC25815@snoopy.apana.org.au>
Content-Type: multipart/alternative;
 boundary="------------003F1F5BA0DD9A366DF4157C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------003F1F5BA0DD9A366DF4157C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Having read at least part of the XACML standard and sat through some
presentations on it I could call my self an expert, but I am not.

Basically it is an extension to SAML, with eXtentions for how to exchange
security tokens for permissions for authorization.
 http://www.oasis-open.org/committees/security/
For SAML
http://www.oasis-open.org/committees/xacml/
for XACML
in addition there is additional mechanisms for security management.
This standard will become more important as things like web services are
implemented.

I am on the W3C Web Services Architecture group for my company, and security is
being addressed.

Gerald Edgar

Brian May wrote:

> On Fri, Feb 21, 2003 at 09:14:52AM -0600, Joshua Brindle wrote:
> > http://www.eweek.com/article2/0,3959,893831,00.asp
> > XACML (extensible access control markup language) ratified
> >
> > will selinux be taking advantage of this? i know someone was working on
> > some xml stuff a while back but everytime i go look at where it is it
> > hasn't changed.. anyone else planning on implementing an XML policy
> > translator or something? Thanks..
>
> So far I only have had a quick look at XACML (and may be totally
> mistaken, I am still downloading the specs), but it would appear to
> serve a different purpose to SE-Linux.
>
> XACML, while a central policy, like SE-Linux, appears to be focused
> around what actions individual users can/can't do. eg. Can a user log in
> at time X:XXam?.
>
> SE-Linux on the other hand is focused on what processes can access
> what resources. eg. Can Mozilla access the user's PGP private key?
> Can inetd bind on port 80?
>
> These aren't necessarily mutually exclusive goals, just different
> goals.
> --
> Brian May <bam@snoopy.apana.org.au>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--------------003F1F5BA0DD9A366DF4157C
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Having read at least part of the XACML standard and sat through some presentations
on it I could call my self an expert, but I am not.
<p>Basically it is an extension to SAML, with eXtentions for how to exchange
security tokens for permissions for authorization.
<br>&nbsp;<a href="http://www.oasis-open.org/committees/security/">http://www.oasis-open.org/committees/security/</a>
<br><a href="http://www.oasis-open.org/committees/security/">For SAML</a>
<br><a href="http://www.oasis-open.org/committees/xacml/">http://www.oasis-open.org/committees/xacml/</a>
<br><a href="http://www.oasis-open.org/committees/xacml/">for XACML</a>
<br>in addition there is additional mechanisms for security management.
<br>This standard will become more important as things like web services
are implemented.
<p>I am on the W3C Web Services Architecture group for my company, and
security is being addressed.
<p>Gerald Edgar
<p>Brian May wrote:
<blockquote TYPE=CITE>On Fri, Feb 21, 2003 at 09:14:52AM -0600, Joshua
Brindle wrote:
<br>> <a href="http://www.eweek.com/article2/0,3959,893831,00.asp">http://www.eweek.com/article2/0,3959,893831,00.asp</a>
<br>> XACML (extensible access control markup language) ratified
<br>>
<br>> will selinux be taking advantage of this? i know someone was working
on
<br>> some xml stuff a while back but everytime i go look at where it is
it
<br>> hasn't changed.. anyone else planning on implementing an XML policy
<br>> translator or something? Thanks..
<p>So far I only have had a quick look at XACML (and may be totally
<br>mistaken, I am still downloading the specs), but it would appear to
<br>serve a different purpose to SE-Linux.
<p>XACML, while a central policy, like SE-Linux, appears to be focused
<br>around what actions individual users can/can't do. eg. Can a user log
in
<br>at time X:XXam?.
<p>SE-Linux on the other hand is focused on what processes can access
<br>what resources. eg. Can Mozilla access the user's PGP private key?
<br>Can inetd bind on port 80?
<p>These aren't necessarily mutually exclusive goals, just different
<br>goals.
<br>--
<br>Brian May &lt;bam@snoopy.apana.org.au>
<p>--
<br>This message was distributed to subscribers of the selinux mailing
list.
<br>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
<br>the words "unsubscribe selinux" without quotes as the message.</blockquote>
</html>

--------------003F1F5BA0DD9A366DF4157C--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
