Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAS2SMc0007786
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 21:28:22 -0500
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAS2UXpo025987
	for <selinux@tycho.nsa.gov>; Sat, 28 Nov 2009 02:30:34 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAS2NL3G008510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 20:23:23 -0600
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id nAS2Irlj004596
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 20:18:54 -0600
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: A question about genhomedircon
References: <87vdh5kp0s.fsf@anzu.internal.golden-gryphon.com>
	<1258747888.27504.624.camel@gorn.columbia.tresys.com>
Date: Fri, 27 Nov 2009 20:18:53 -0600
In-Reply-To: <1258747888.27504.624.camel@gorn.columbia.tresys.com>
	(Christopher J. PeBenito's message of "Fri, 20 Nov 2009 15:11:28
	-0500")
Message-ID: <87iqcvwfw2.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 20 2009, Christopher J. PeBenito wrote:


> Theres no need to reload the policy, as the policy isn't changing.  It
> does, however, regenerate the file contexts, including the home dir
> contexts.

        So the behaviour has not changed? In which case, can we bring
 back the  man page for the command?

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
