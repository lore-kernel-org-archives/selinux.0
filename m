Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EBY5Wt017686
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 07:34:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9EBXw0p001834
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 11:33:58 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
	by jazzswing.ncsc.mil  with ESMTP id h9EBXvr7001830
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 11:33:57 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: trusted vs untrusted packages
Date: Tue, 14 Oct 2003 13:33:39 +0200
References: <200310141107.53852.russell@coker.com.au>
In-Reply-To: <200310141107.53852.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200310141333.39662.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think the idea of signed rpms is good and useful. 

> RPMs can be signed or unsigned.  If an RPM is signed by a trusted
> organization then there should be some differences in an SE Linux
> install than if it is not signed or if we don't trust the signer.

Whom should we trust? The people of the personal web of trust?

> One idea is to have signed packages be installed by rpm running
> as rpm_t and unsigned packages be installed by rpm running as
> rpm_unsigned_t [1].  So for example we could allow rpm_unsigned_t
> to install files in /sbin as sbin_unsigned_t and in /bin as
> bin_unsigned_t [2].  Then a program installed from an untrusted
> package can't be run from sysadm_t, and if it's run from other
> trusted domains (EG part of the mail server) then it could
> trigger an automatic domain transition to an appropriate domain.

I'm not sure, about this idea. Because it is necessary to patch rpm 
and the most rpms I've seen creates the file context during the 
post install squence using chcon. On the other side we have more 
secure packages with a (little bit) more complex policy. 

What's about debian packages? Would you sign this too and adapt the 
package tools to handle the file context? 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
