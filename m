Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJJD3Rb020077
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:13:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJJD2qY019655
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:13:02 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAJJD10o019652 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:13:01 GMT
Subject: Re: igmp_packet_t in system_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311192156.00832.russell@coker.com.au>
References: <200311192156.00832.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1069269177.25899.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 Nov 2003 14:12:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-19 at 05:56, Russell Coker wrote:
> Why are types such as igmp_packet_t in system_r?  I thought that such types 
> used for labelling packets would not need to be in any role...

Process -> socket -> packet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
