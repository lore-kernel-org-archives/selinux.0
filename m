Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k51EQQKg001725
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 10:26:26 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k51EQOhm014265
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 14:26:25 GMT
Date: Thu, 1 Jun 2006 10:26:22 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux
In-Reply-To: <10131.1149154368@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0606011025310.16136@d.namei>
References: <Pine.LNX.4.64.0605311635470.7334@d.namei>
 <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
 <10131.1149154368@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Jun 2006, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > What's the difference between reading and viewing a key?
> 
> "Viewing" is looking at the key's attributes.

Why not be consistent with the rest of Linux and use something like 
"getattr" ?




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
