Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7NHjnlE016500
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 13:45:49 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7NHjEtd007040
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 17:45:15 GMT
Message-ID: <4A91803C.8030909@redhat.com>
Date: Sun, 23 Aug 2009 13:45:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, 503252-forwarded@bugs.debian.org,
        Russell Coker <russell@coker.com.au>
Subject: Re: policycoreutils: audit2allow -l doesn't work with dmesg pipe
References: <87d46mvb33.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87d46mvb33.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/2009 10:50 AM, Manoj Srivastava wrote:
> Hi,
> 
>         This has been reported against the Debian BTS.
> 
>         If you don't have auditd running and you run the following
>  command you should expect no output:
> load_policy ; dmesg|audit2allow -l
> 
>         But it doesn't happen, it seems that the -l option doesn't work
>  when taking input from dmesg.
> 
>         manoj
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=503252
audit2allow -l is looking for the load_policy message which does not go to the dmesg, /var/log/messages.  Therefore the tool has no idea when policy was last loaded.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
