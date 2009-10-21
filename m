Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LGZIix026629
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 12:35:18 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LGYNih008607
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 16:34:23 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9LGTL3d012137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:29:24 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n9LGMTaS022971
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:22:29 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: 'make policy' issues
References: <4ADF2358.4050606@laganowski.net>
	<1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
	<4ADF2663.2030105@laganowski.net>
	<1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 21 Oct 2009 11:22:29 -0500
In-Reply-To: <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 21 Oct 2009 11:29:10 -0400")
Message-ID: <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 21 2009, Stephen Smalley wrote:

> On Wed, 2009-10-21 at 11:18 -0400, Eric Laganowski wrote:
>> Stephen Smalley wrote:

>> Re bison/yacc: I tried both, byacc and 'bison -y'
>> Re flex: What is the requirement for flex from selinux perspective? Is 
>> it known what build of flex is "known good"?
>
> My impression is that one of the patches carried by the distributions
> for flex is needed for checkpolicy to work, but no one has ever fully
> investigated the precise dependency - people just grab the Fedora srpm
> and apply those patches to flex, and then rebuild checkpolicy and it
> works.  I haven't seen any complaints from Debian or Gentoo so I presume
> that they also carry the same patches for flex.
>
> flex -V here also shows 2.5.35.  But there are three patches in the
> Fedora package.  Attached.

        Debian currently carries 13 (though 3 of them need to be
 squashed together) patches against 2.5.35. I can make them available if
 there is interest.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
