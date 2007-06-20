Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KBn46n013498
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 07:49:04 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5KBmrAt017261
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 11:48:53 GMT
Date: Wed, 20 Jun 2007 07:48:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Per Domain Permissive Mode
In-Reply-To: <1182339790.15064.80.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0706200748250.22479@localhost.localdomain>
References: <4677EE5B.9030405@redhat.com>  <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>
  <Line.LNX.4.64.0706191118420.15755@localhost.localdomain>
 <1182267849.21615.103.camel@localhost.localdomain>
 <1182339790.15064.80.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Jun 2007, Stephen Smalley wrote:

> Similar question applies to how we provide "unconfined" domains; to
> date, we have done so by generating all of those allow rules, but that
> is costly in policy (somewhat mitigated by use of attributes, but
> limited especially as we add exception cases).

Do you know how much of the kernel memory we use for policy is used by 
this?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
