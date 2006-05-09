Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49FWGFp018846
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 11:32:16 -0400
Received: from smtp-mclean.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49FW9a2003211
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 15:32:09 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.12.11.20060308/8.12.11) with SMTP id k49FW9V0032475
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 11:32:09 -0400
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (Postfix) with ESMTP id 6E0D01BDA2
	for <selinux@tycho.nsa.gov>; Tue,  9 May 2006 11:32:09 -0400 (EDT)
From: Brian Sniffen <bsniffen@mitre.org>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Network access controls (resolving xfrm, secmark, and NetLabel)
References: <445B7CEC.1020106@hp.com> <m24pzz6zb1.fsf@raven-king.mitre.org>
	<4460B0CD.30500@hp.com>
Date: Tue, 09 May 2006 11:30:55 -0400
In-Reply-To: <4460B0CD.30500@hp.com> (Paul Moore's message of "Tue, 09 May
	2006 11:10:05 -0400")
Message-ID: <m2zmhr5i6o.fsf@raven-king.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore <paul.moore@hp.com> writes:

> If we could do everything in netfilter then I agree with you
> completely. 

Agree with me?  I didn't think I was making a point yet.  I'm just
curious how many degrees of freedom NetLabel has, and what costs will
be borne elsewhere in the system.  From this sort of answer, should I
assume that the costs will be high---but necessary for CIPSO and
similar complexities?

-Brian

-- 
Brian T. Sniffen                                      bsniffen@mitre.org
The MITRE Corporation                                       781-271-2904

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
