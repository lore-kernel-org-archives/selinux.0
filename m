Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CDZxjs024483
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 09:35:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CDZw0x010379
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 13:35:59 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8CDRUVH021897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 09:27:30 -0400
Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eric Paris <eparis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1189547256.3407.57.camel@localhost.localdomain>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
	 <1189545987.4823.6.camel@localhost.localdomain>
	 <1189547256.3407.57.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 09:27:22 -0400
Message-Id: <1189603642.3555.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-11 at 17:47 -0400, Eric Paris wrote:
> On Tue, 2007-09-11 at 17:26 -0400, Karl MacMillan wrote:
> > On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
> > [...]
> > > One other feature/requirement would be to not override dontaudit rules.
> > > So if I have a domain in permissive mode and I have a dontaudit rule  on
> > > reading /etc/shadow.  The app should still be denied reading
> > > /etc/shadow.  (This is not a show stopper, but would allow us to force
> > > apps to take the code paths they will take in enforcing mode.)
> > 
> > This isn't specific to per-domain permissive, right? It would be useful
> > in general for permissive.
> 
> You know, I'm quite happy that setenforce=0 ALWAYS means 'not selinux
> fault'   not sure I'm comfortable with changing that, although I have no
> problem with dan's suggestion....
> 

Well, there are very rare circumstances where permissive can still cause
problems, but your general point is well taken.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
