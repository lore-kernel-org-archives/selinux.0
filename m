Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0D5vVRb017462
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 00:57:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0D5uNxr016119
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 05:56:23 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id i0D5uFYc016116
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 05:56:20 GMT
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: Re: Samba and NFSv4 user-space server
References: <200401131419.23834.russell@coker.com.au>
Date: Tue, 13 Jan 2004 16:57:02 +1100
In-Reply-To: <200401131419.23834.russell@coker.com.au> (Russell Coker's
 message of "Tue, 13 Jan 2004 14:19:23 +1100")
Message-ID: <84zncs2xxt.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    Russell> For Samba it's possible for a single TCP connection to be
    Russell> used for multiple identities.  This is standard practise
    Russell> for "Windws Terminal Server", and would be used when you
    Russell> specify different user-id's for different "net use"
    Russell> commands if the Windows SMB client code wasn't so buggy.

[...]

    Russell> We don't want to allow wide and arbitary changing of
    Russell> context as setuid() allows.  But allowing transitions
    Russell> between samba_user_t and samba_staff_t should be OK.

Could you have the incoming TCP request go to a "wrapper" service that
does nothing but redirect it to the "real" process that is already
running with the correct UID/SE-Linux domain?

Not sure how feasible this is, or what sort of performance penalty
it might have though.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
