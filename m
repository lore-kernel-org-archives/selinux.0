Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05165
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 10:27:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA03690
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 14:26:07 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id OAA03686
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 14:26:06 GMT
Date: Wed, 24 Apr 2002 16:28:23 +0200
From: Tom <tom@lemuria.org>
To: Stephen Smalley <sds@tislabs.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: split admins
Message-ID: <20020424162823.B14745@lemuria.org>
References: <20020424154523.B14453@lemuria.org> <Pine.GSO.4.33.0204240955190.17117-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204240955190.17117-100000@raven>; from sds@tislabs.com on Wed, Apr 24, 2002 at 09:59:37AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 24, 2002 at 09:59:37AM -0400, Stephen Smalley wrote:
> When the example policy was originally being developed, there was an
> initial attempt to provide such a distinction between a system
> administrator and a security administrator, but the separate role was
> discarded because it turns out to be very difficult to truly enforce a
> separation between these two roles without severely limiting the system
> administrator role, making it relatively useless.  The topic has also come
> up previously on the list, e.g. see
> http://marc.theaimsgroup.com/?l=selinux&m=100799744813965&w=2.

I'll check that discussion and give it a go. I'm happy with not doing
away root=god. I'm more interested in having, say, an application-level
admin (control over the daemons, network services, whatever). Just
thought a security admin would be a useful thing to start this with.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
