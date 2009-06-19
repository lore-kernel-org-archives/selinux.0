Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5JK9ruk019243
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 16:09:53 -0400
Received: from QMTA06.emeryville.ca.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5JKALkM022198
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 20:10:22 GMT
Subject: Re: This patch add seusers support to SELinux
From: Chris PeBenito <pebenito@gentoo.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4A3BEC4B.5080504@redhat.com>
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com>
	 <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com>
	 <4A3AA03E.4010208@manicmethod.com> <4A3B6110.8010308@redhat.com>
	 <4A3BA9DC.2060406@manicmethod.com> <4A3BACE9.6000403@redhat.com>
	 <4A3BD53A.5050908@manicmethod.com>  <4A3BD905.3030401@redhat.com>
	 <1245439846.3574.12.camel@defiant.pebenito.net>
	 <4A3BEC4B.5080504@redhat.com>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 16:09:30 -0400
Message-Id: <1245442170.3574.23.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-06-19 at 15:51 -0400, Daniel J Walsh wrote:
> On 06/19/2009 03:30 PM, Chris PeBenito wrote:
> > On Fri, 2009-06-19 at 14:29 -0400, Daniel J Walsh wrote:
> >> Basically this is the exact same file as the seusers file except it one
> >> per Linux User where is the seusers file is one record per Linux User.
> >>
> >> If I have a distributed environment, I need to say stuff like
> >>
> >> engineers logging into people.redhat.com get guest_t:s0
> >> Admins logging in get unconfined_t:SystemLow-SystemHigh
> >>
> >> In addition on some machines dwalsh is an admin and on others he is a
> >> peon.  So using IPA we generate a mapping from MACHINE to User
> >>
> >> dwalsh on dwalsh_laptop gets unconfined_t
> >> dwalsh on desktop gets user_t
> >> dwalsh on people gets guest_t
> >>
> >> There is a potential use for service but it will probably default to *
> >> for now.
> >
> > I don't have a problem with this idea, but I do have a problem with this
> > not replacing the current seuser behavior.  Having two ways to map linux
> > users to selinux users is an administration nightmare.  People will be
> > confused about which one to use and you'll need to know precedence.
> > What you describe above with the contents of each file just having a *
> > service would be the same as the current seuser behavior.
> >
> Well I don't see administrators editing the new format, we have not even 
> used it yet, since IPA has not shipped this functionality yet.

I don't see how IPA's usage matters.  If we go this way, in the future
there will be two ways for the seusers mapping, which is confusing.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
