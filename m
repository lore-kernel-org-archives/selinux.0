Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CInVIi017968
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:49:31 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CInXgF000206
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:49:34 GMT
Subject: Re: [patch] types.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050104151703.GA8223@yggdrasil.localdomain>
References: <20050104025950.GA5321@yggdrasil.localdomain>
	 <200501050032.29370.russell@coker.com.au>
	 <20050104151703.GA8223@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1105555871.11834.33.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 13:51:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changed the next three /etc/selinux lines as well.

/etc/selinux/([^/]*/)?src(/.*)?	system_u:object_r:policy_src_t
/etc/selinux/([^/]*/)?contexts(/.*)?	system_u:object_r:default_context_t
/etc/selinux/([^/]*/)?contexts/files(/.*)? system_u:object_r:file_context_t

On Tue, 2005-01-04 at 10:17, Greg Norris wrote:
> On Wed, Jan 05, 2005 at 12:32:26AM +1100, Russell Coker wrote:
> > You also need the same for the three lines that follow.  I posted a patch at 
> > about the same time as your message which made the appropriate change.
> 
> OK, I'll keep an eye open... it doesn't seem to have gotten here yet.
> 
> > But I have been considering just moving to the locations that are used in 
> > Fedora.
> 
> This seems like a good idea to me.  If nothing else, it would make it 
> easier to support multiple policies in the future... should we decide to 
> do something similar to Fedora's strict/targeted scheme.  Personally, I 
> rather like their approach.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
