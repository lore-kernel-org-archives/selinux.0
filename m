Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75IckOb002571
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 14:38:46 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75IVa26015356
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 18:31:37 GMT
Message-ID: <42F3B09E.9090007@redhat.com>
Date: Fri, 05 Aug 2005 14:31:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: rich turner <rich@storix.com>
CC: selinux@tycho.nsa.gov
Subject: Re: chcon v. setfilecon
References: <1123191498.4481.76.camel@rich>
In-Reply-To: <1123191498.4481.76.camel@rich>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rich turner wrote:

>what is the difference between these commands? it seems they both do the
>same thing.
>
>is setfilecon deprecated and replaced with chcon?
>
>on my fedora core3 system i have the setfilecon command but not the
>chcon command. on fc4 i have the chcon command.
>  
>
setfilecon is a test application that we (Red Hat) no longer ships.  
chcon is the proper tool to use.  It exists on FC3,
chcon should be part of coreutils.

>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
