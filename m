Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06EnvIi009036
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 09:49:57 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06Eo0oP011952
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 14:50:01 GMT
Message-ID: <41DD5001.3010302@redhat.com>
Date: Thu, 06 Jan 2005 09:49:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [patch] screen_macros.te
References: <20050104230149.GA10317@yggdrasil.localdomain> <20050104233401.GA11885@yggdrasil.localdomain> <41DBE9F1.50303@redhat.com> <200501062246.42763.russell@coker.com.au>
In-Reply-To: <200501062246.42763.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Thursday 06 January 2005 00:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>I would like to add a new file type cert_t for ssl cert files, since
>>these are defaulted to usr_t right now.
>>Shouldn't these be protected at a higher level?
>>    
>>
>
>Are you talking about protecting the integrity or the secrecy of data in such 
>files?
>
>If integrity then anything which can write to usr_t can break the system 
>anyway.  If secrecy then nothing in an rpm is secret anyway.
>
>If there are certificates that have any secret data then they should be 
>somewhere other than under /usr.
>
>  
>
They are not in an RPM, and there has been discussions that they should 
be moved under /var/ or /etc/.
I think readability is the problem here.  Wherever they end up we need a 
general case protecting the
certificates so ever application that can read /usr or /etc/ or /var can 
not read these files.   We are also going
have to start looking at how we can protect Kerberos Key Files.  But 
that is another conversation.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
