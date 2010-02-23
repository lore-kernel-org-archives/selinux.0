Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1NHH3Tu010704
	for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2010 12:17:03 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1NHGl8G028959
	for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2010 17:16:47 GMT
Message-ID: <4B840D88.6050105@redhat.com>
Date: Tue, 23 Feb 2010 12:16:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Denis BUCHER <dbucherml@hsolutions.ch>
CC: selinux@tycho.nsa.gov
Subject: Re: No such file or directory: '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
References: <4B83FED0.208@hsolutions.ch>
In-Reply-To: <4B83FED0.208@hsolutions.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/23/2010 11:14 AM, Denis BUCHER wrote:
> Dear all,
>
> I got the following error while I just wanted to change the homedir of 
> a user. I hope it's the right place to ask ? (Nothing found on the web)
>
> # usermod -d <path> <user>
>
> /usr/sbin/genhomedircon: [Errno 2] No such file or directory: 
> '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
> usermod: warning: unable to relabel the homedir (...)
>
> But homedir was changed anyway...
>
> Just to let you know... (?)
>
> Denis
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
Do you have SELinux enabled?  Does the entire path exists?
/etc/selinux/targeted/contexts/files


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
