Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8RLDOw6032442
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2007 17:13:24 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8RLDNks010393
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2007 21:13:23 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8RLCNeb025143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2007 17:12:23 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8RLCNi6021428
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2007 17:12:23 -0400
Subject: Re: [RFC] /var versus /srv
From: Karl MacMillan <kmacmill@redhat.com>
To: Development discussions related to Fedora <fedora-devel-list@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070927161808.672f61f4@redhat.com>
References: <46F33D05.4020701@ncsu.edu>
	 <1190839164.16820.53.camel@vincent52.localdomain>
	 <1190843974.17132.10.camel@localhost6.localdomain6>
	 <200709262117.40104.sgrubb@redhat.com>
	 <1190861566.21836.0.camel@localhost6.localdomain6>
	 <20070927074100.6a37fc03@redhat.com> <46FBF63E.5060909@mindspring.com>
	 <1190922818.3197.19.camel@localhost.localdomain>
	 <20070927161808.672f61f4@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 17:11:25 -0400
Message-Id: <1190927485.3197.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-27 at 16:18 -0400, Jesse Keating wrote:
> On Thu, 27 Sep 2007 15:53:38 -0400
> Karl MacMillan <kmacmill@redhat.com> wrote:
> 
> > 3) Have rpm set contexts that aren't yet valid. This option was
> > explored and there was even a kernel patch that would allow this. The
> > fear is that it would allow a malicious package to create files with
> > _any_ context that is not yet valid. It makes it difficult or
> > impossible to constrain rpm. You could go back after the policy is
> > installed and check for contexts that are still invalid and fix
> > those. No decision was reached about how to handle the hole and
> > nothing happened. The SELinux upstream developers (well, at least me)
> > are willing to reconsider this proposal.
> 
> Wouldn't it be reasonable to lay them down as 'undefined_t' and let the
> post-rpm transactions relabel them?
> 

That is possible - though obviously you have to handle things cleanly
for upgrades to that you don't end up with, say, libc labeled as
undefined_t. So you would have to:

1) check every context as you put a file down
2) if it is valid set it
3) otherwise, set to undefined_t (and ideally add file to list)
4) install policy in post
5) relabel (ideally with list kept from before)

Part of the problem, though, is figuring out what the context for a file
should be. I believe that you can record contexts from when the rpm was
built, but how do you handle if the admin has a local labeling rule that
should take effect?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
