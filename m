Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0K9BrRb023569
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 04:11:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0K9BriV022982
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 09:11:53 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id i0K9Bp06022979 for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 09:11:51 GMT
To: selinux@tycho.nsa.gov
Subject: Re: Samba and NFSv4 user-space server
References: <200401131419.23834.russell@coker.com.au>
	<84zncs2xxt.fsf@snoopy.apana.org.au>
	<200401151619.58669.russell@coker.com.au>
From: Brian May <bam@snoopy.apana.org.au>
Date: Tue, 20 Jan 2004 20:11:30 +1100
In-Reply-To: <200401151619.58669.russell@coker.com.au> (Russell Coker's
 message of "Thu, 15 Jan 2004 16:19:58 +1100")
Message-ID: <84ptdft265.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    >>  Could you have the incoming TCP request go to a "wrapper"
    >> service that does nothing but redirect it to the "real" process
    >> that is already running with the correct UID/SE-Linux domain?
    >> 
    >> Not sure how feasible this is, or what sort of performance
    >> penalty it might have though.

    Russell> That won't work.  Samba supports having multiple
    Russell> identities on a single TCP connection, and NFSv4 supports
    Russell> similar things.

I may not have been very clear.

I am assuming that while the connection can have multiple identities,
each request can only have on identity. I think this is the case for
Samba, I could be mistaken.

My suggestion was to have one connection go to one process, which
redirects the individual requests to other processes depending on the
identity of that request.

I am suspicious this will fall into the "easier said then done"
category.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
