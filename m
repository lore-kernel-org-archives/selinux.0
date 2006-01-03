Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03JRWXf023337
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:27:32 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03JRUah002833
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:27:31 GMT
Message-ID: <43BAB42A.9000507@cornell.edu>
Date: Tue, 03 Jan 2006 12:28:10 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage performance patch
References: <200601040557.32435.russell@coker.com.au>
In-Reply-To: <200601040557.32435.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> @@ -131,10 +128,6 @@ int parse_skip_space(
>  
>  			return STATUS_SUCCESS;
>  		}
> -
> -		next:
> -		free(buffer);
> -		buffer = NULL;
>   
This introduces a memory leak.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
