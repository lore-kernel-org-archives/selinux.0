Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3G1nJY9005906
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 21:49:19 -0400
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3G1nIjV004521
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2008 01:49:18 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	by ladon.golden-gryphon.com (8.13.8/8.13.8/Debian-3) with ESMTP id m3G1ianW012488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 20:44:38 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.2/8.14.2/Debian-4) with ESMTP id m3G1fuYR025299
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 20:41:59 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: open_init_pty: eats much of the CPU time
References: <20080415135909.GA10016@bobek.pm.i.cz>
	<48050B61.2010402@manicmethod.com>
Date: Tue, 15 Apr 2008 20:41:56 -0500
In-Reply-To: <48050B61.2010402@manicmethod.com> (Joshua Brindle's message of
	"Tue, 15 Apr 2008 16:09:05 -0400")
Message-ID: <87od8ashi3.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Apr 2008 16:09:05 -0400, Joshua Brindle <method@manicmethod.com> said: 

> Václav Ovsík wrote:
>> Hi, FYI: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956>
>> Maybe Manoj is busy and someone wants to review the code and include
>> it upstream...  Regards
>> 

> Can someone (it doesn't have to be Manoj) send a patch to the list
> against trunk?

        I'm not that busy. If people can wait until the weekend, I'll
 update my policy branch, rebase against trunk, and send in the
 patches (currently subversion is broken on Debian unstable)

        manoj
-- 
People are always available for work in the past tense.
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
