Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA21372
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 06:14:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA05338
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 10:13:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA05334
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 10:13:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Ryan Bergauer <privateryan@mindspring.com>
Subject: Re: user mount permissions
Date: Tue, 23 Jul 2002 12:14:02 +0200
Cc: <selinux@tycho.nsa.gov>, Brian May <bam@debian.org>
References: <Pine.GSO.4.33.0207170742190.18645-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207170742190.18645-100000@raven>
MIME-Version: 1.0
Message-Id: <20020723101402.BBAE56D13@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Jul 2002 13:45, Stephen Smalley wrote:
> On Tue, 16 Jul 2002, Ryan Bergauer wrote:
> > I'm want to allow users to be able to mount an encrypted directory in
> > their home directory. Unfortunately, this requires allowing normal users
> > to transition into mount_t via a mount executable, which I think would
> > be wise to avoid. Is there a good way to allow users to mount only a
> > certain type, say user_home_t (or in my case, crypt_home_t)? Thanks!
>
> You could create a user_mount_t domain (copied from mount_t, defining a
> domain transition to it from user_t, and then reducing the permissions).
> You may be able to use the directory 'mounton' and the filesystem 'mount'
> permissions to limit the user to particular types, but I'm not sure about
> the specific permission requirements for what you describe.

Brian, how's your work on this going?  Got anything ready to post here?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
