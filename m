Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AM1oL9015053
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 17:01:51 -0500 (EST)
Message-ID: <420BD99C.8050508@redhat.com>
Date: Thu, 10 Feb 2005 17:01:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SE Linux <selinux@tycho.nsa.gov>, Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Rewrite of genhomedircon
References: <420BC588.4@redhat.com> <1108071785.22172.270.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1108071785.22172.270.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-02-10 at 15:35, Daniel J Walsh wrote:
>  
>
>>genhomedircon will generate only one HOME_ROOT based off the location in 
>>the /etc/default/useradd.
>>    
>>
>
>Is this limitation (to a single HOME_ROOT) going to be a problem in
>practice?
>
>  
>
It is causing problems in other unexpected ways.  We are seeing 
potential conflicts
where a user account gets created say on /var/ and now we end up with 
/var being labeled
home_root_t.  The reason for having home_root_t is so that directories 
that get created under
it will automatically get created with the correct context.  We have 
also seen conflicts where
users create some directories in /home and /home/devel where they could 
conflict. 

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
