Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UD6J2L014057
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 09:06:19 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UD6HkK018816
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:06:18 GMT
Received: by wx-out-0506.google.com with SMTP id s17so491489wxc
        for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 06:06:15 -0700 (PDT)
Message-ID: <460D0B45.2060002@gmail.com>
Date: Fri, 30 Mar 2007 08:06:13 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: api for getting setrans information
References: <460C3195.1020505@gmail.com> <1175255207.5479.97.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1175255207.5479.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-03-29 at 16:37 -0500, Ted X Toth wrote:
>   
>> Are there apis to retrieve all of the categories and sensitivity levels 
>> and to convert them into a human readable form?
>>     
>
> Can you give more information on how you would use it, or what kind of
> api you have used in the past for the same functionality?  IOW, help
> propose an api that meets your requirements, and we can work through how
> to make it fit with SELinux.
>
>   
I was thinking about the newrole gui that we talked about at the SELinux 
Symposium. The gui might have a dropdown list of categories and a 
password entry field and it would exec a new window at level. I found 
seobject.py and the setransRecords class which will probably work for my 
purposes right now. I'm not sure if exposing all of the categories is an 
issue.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
