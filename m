Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5901bgA006943
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 20:01:37 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j58NsEMX013112
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 23:54:16 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.4/8.13.4/Debian-3) with ESMTP id j58NlCRH031514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 18:47:12 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: Labeling confusion with apt-get/dpkg
References: <20050603143639.59205.qmail@web33209.mail.mud.yahoo.com>
Date: Wed, 08 Jun 2005 18:47:12 -0500
In-Reply-To: <20050603143639.59205.qmail@web33209.mail.mud.yahoo.com> (Roger
	Brunell's message of "Fri, 3 Jun 2005 07:36:39 -0700 (PDT)")
Message-ID: <877jh4s96n.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Jun 2005 07:36:39 -0700 (PDT), Roger Brunell <rog_brunell@yahoo.com> said: 

> and I do not have a libpam that is selinux aware. Manoj's site lists
> libpam as a target that needs to be worked, but as yet has no
> updated modules. I think I saw something on freenode:#selinux where
> he said there were 8000 lines of changes that needed to be reviewed
> and encorporated.

> This may be a show-stopper....


        I'm working on it. Sam Hartman want all this work to be based
 off his svn repository, so he can merge changes back, and he wants
 ever one of Debian's patches checked and applied, if feasible.  In
 the meanwhile I think Russell Coker's repository has the pam and
 sysvinit packages that you shall need.

        I'll try and get pam into shape this week, or at least have
 interim packages for people to use while I get things into shape that
 the Debian maintainer wants.

        manoj

-- 
When a man's bad deeds are covered over by good ones, he illuminates
the world, like the moon breaking away from a cloud. 173
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
