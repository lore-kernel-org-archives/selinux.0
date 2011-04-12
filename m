Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3CDW05E020475
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 09:32:00 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3CDW0Cq023484
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 13:32:00 GMT
Message-ID: <4DA454A8.7030005@tresys.com>
Date: Tue, 12 Apr 2011 09:33:28 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: This patch adds a new subs_dist file.
References: <4D9CD64B.7020207@redhat.com>
In-Reply-To: <4D9CD64B.7020207@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/06/2011 05:08 PM, Daniel J Walsh wrote:
> The idea is to allow distributions to ship a subs file as well as let
> the user modify subs.
> 
> In F16 we are looking at shipping a
> 
> file_contexts.subs_dist file like this
> 
> cat file_contexts.subs_dist
> /run /var/run
> /run/lock /var/lock
> /var/run/lock /var/lock
> /lib64 /lib
> /usr/lib64 /usr/lib
> 
> 
> The we will remove all (64)?  from policy.
> 
> This will allow us to make sure all /usr/lib/libBLAH is labeled the same
> as /usr/lib64/libBLAH
> 

Applied in libselinux-2.0.102

Thanks!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
