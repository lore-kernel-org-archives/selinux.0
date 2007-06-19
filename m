Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JFKTAG013830
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 11:20:29 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JFKRif022961
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:20:28 GMT
Date: Tue, 19 Jun 2007 11:19:41 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Daniel J Walsh <dwalsh@redhat.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Per Domain Permissive Mode
In-Reply-To: <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0706191118420.15755@localhost.localdomain>
References: <4677EE5B.9030405@redhat.com> <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Jun 2007, James Morris wrote:

> On Tue, 19 Jun 2007, Daniel J Walsh wrote:
> 
> > Thoughts...
> 
> We can do this in policy: define a domain which runs with all accessess 
> allowed, and also optionally logged for profiling purposes.

Actually, this is not entirely useful for development -- perhaps some kind 
of abstraction can be used to hide all of the allow rules, so it just 
appears to the policy developer that the domain is in permissive mode.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
