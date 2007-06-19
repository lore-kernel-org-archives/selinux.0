Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JFiZLg015898
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 11:44:35 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JFiXif028620
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:44:33 GMT
Subject: Re: Per Domain Permissive Mode
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Morris <jmorris@namei.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Line.LNX.4.64.0706191118420.15755@localhost.localdomain>
References: <4677EE5B.9030405@redhat.com>
	 <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>
	 <Line.LNX.4.64.0706191118420.15755@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 11:44:09 -0400
Message-Id: <1182267849.21615.103.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-19 at 11:19 -0400, James Morris wrote:
> On Tue, 19 Jun 2007, James Morris wrote:
> 
> > On Tue, 19 Jun 2007, Daniel J Walsh wrote:
> > 
> > > Thoughts...
> > 
> > We can do this in policy: define a domain which runs with all accessess 
> > allowed, and also optionally logged for profiling purposes.
> 
> Actually, this is not entirely useful for development -- perhaps some kind 
> of abstraction can be used to hide all of the allow rules, so it just 
> appears to the policy developer that the domain is in permissive mode.
> 

The complicated bit is actually the auditallow rules to get similar
auditing to permissive. We only want to add auditallow rules for the
extra access allowed to make the domain unconfined not for all access
allowed by the domain. That basically means parsing the module, figuring
out what was allowed, and adding auditallow for the difference between
that access and unconfined.

Sepolgen is almost at a point it can do this. Slide, as far as I know,
doesn't parse the access in sufficient detail to do this yet.

One downside to this approach is teaching policy generation tools to
generate access for granted messages in the log. It also makes explicit
auditallow somewhat useless.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
