Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5GH7JrT004384
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 13:07:19 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5GH5iov000639
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 17:07:16 GMT
Message-ID: <40D07C52.3070805@redhat.com>
Date: Wed, 16 Jun 2004 12:58:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "John D. Ramsdell" <ramsdell@mitre.org>, selinux@tycho.nsa.gov,
   selinux-dev@tresys.com
Subject: Re: Fedora Core 2 setools RPM
References: <ogtvfhss8rr.fsf@mitre.org> <1087393067.16125.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1087393067.16125.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2004-06-15 at 19:26, John D. Ramsdell wrote:
>  
>
>>I notice the RPM for setools fails to install libapol.a into /usr/lib,
>>and fails to install the header files needed to use the library into
>>/usr/include/libapol.  Is there is a setools-devel RPM I don't know
>>about?
>>    
>>
>
>Not AFAIK, but I agree it would be a good idea.  In fact, it would be
>nice for there to be a libapol RPM with a shared apol library and a
>libapol-devel RPM with a static library and headers for use by third
>party tools separate from setools.
> 
>  
>
I attempted to do this a while ago but, it really needs to be separated 
out by tresys.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
