Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JFIxJ5013730
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 11:18:59 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JFIwD6026770
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:18:58 GMT
Date: Tue, 19 Jun 2007 11:17:56 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Daniel J Walsh <dwalsh@redhat.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Per Domain Permissive Mode
In-Reply-To: <4677EE5B.9030405@redhat.com>
Message-ID: <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>
References: <4677EE5B.9030405@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Jun 2007, Daniel J Walsh wrote:

> Thoughts...

We can do this in policy: define a domain which runs with all accessess 
allowed, and also optionally logged for profiling purposes.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
