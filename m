Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19838
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:33:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA07947
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:33:02 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA07943
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:33:01 GMT
Date: Fri, 24 May 2002 11:32:06 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: 2 checkpolicy bugs
In-Reply-To: <20020524121244.237B6655@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205241130020.23057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 24 May 2002, Russell Coker wrote:

> If I don't assign SIDs to any TCP or UDP ports then I get the following
> checkpolicy error:
>
> error in the statement ending on line 31779 (token 'system_u'): parse error
>
> Line 31779 is the following:
> lo system_u:object_r:netif_lo_t system_u:object_r:netmsg_lo_t
>
> I consider that there are two bugs in checkpolicy, firstly it doesn't accept
> a valid configuration with no special SIDs assigned to any TCP or UDP ports.
> Secondly it doesn't give me an error message that is any good to inform me of
> this matter.
>
> Currently to work around this matter I've assigned a type for port 1 (tcpmux)
> which is never used.

Yes, the current policy parser requires most "sections" to be present,
rather than allowing them to be optional.  Permitting most sections to be
optional may require other changes in order to avoid ambiguities, but is a
worthwhile goal.  It is already on my TODO list, but not as a high
priority.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
