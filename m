Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NEH2Ob028367
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 10:17:02 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NE6ecX017581
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 14:06:50 GMT
Message-ID: <430B2D6A.5010105@tresys.com>
Date: Tue, 23 Aug 2005 10:06:34 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com>
In-Reply-To: <430A33E5.1030100@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

>	range=context_range_get(con);
>	if (range) {
>		if(strcmp(range,"s0") == 0 ) {
>			context_range_set(con,NULL);
>		}
>		else 
>		{
>			ptr=strrchr(range,':');
>  
>
Why is s0 hardcoded here? s0 should be part of the context to be 
translated, if you don't want the users to see it whatever tool to edit 
the mappings should hide it, not libselinux.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
