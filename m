Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9DDZ2Ns024003
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 09:35:03 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9DDX2gQ007510
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 13:33:02 GMT
Message-ID: <434E6217.2080003@redhat.com>
Date: Thu, 13 Oct 2005 09:33:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS policy
References: <200510131632.25597.russell@coker.com.au>
In-Reply-To: <200510131632.25597.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> Currently a default root login gets a default level of s2.  This means that 
> daemons initially run with the range s0-s9 but run with the range s2-s9 after 
> being restarted.  Should we have range-transition rules in the daemon_domain 
> family of macros to deal with this?
>
> What is the benefit of assigning root the default level of s2 anyway?
>
> range_transition kernel_t init_exec_t s0 - s9:c0.c255;
>
>   
Oversite
> Currently we have the above in the MLS policy.  Is it desired that we only use 
> up to s9 (highest level is s15)?  Or was it an oversight that the above line 
> was not changed when the extra levels were added?
>
>   


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
