Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BK63b7012932
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 16:06:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BK62T2016337
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 20:06:03 GMT
Message-ID: <461D3FA9.4060704@redhat.com>
Date: Wed, 11 Apr 2007 16:06:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New policy for consolekit.
References: <45E5A6C9.40107@redhat.com> <1174319870.29664.60.camel@sgc>
In-Reply-To: <1174319870.29664.60.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2007-02-28 at 10:59 -0500, Daniel J Walsh wrote:
>   
>> This is a new policy for the User Switching capability coming in gnome.
>>
>> consolekit is a daemon that communicates with xdm_t and hal through dbus 
>> to change the
>> ownership/access on certain devices when the login session changes from 
>> one user to another.
>>     
>
> I'm going to merge this with some organization fixes, but can you
> doublecheck to see if this works with term_dontaudit_use_console()
> instead of allowing the console access?  This goes back to if it will
> work with denying init_t:fd use.
>
>   
Also consolekit actually needs to use the terminals to determine if a 
users is logged in.  So these should not be dontaudited.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
