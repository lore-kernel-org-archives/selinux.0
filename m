Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o21K2von015811
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 15:02:59 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o21K2TFG014044
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 20:02:29 GMT
Message-ID: <4B8C1D63.3000900@redhat.com>
Date: Mon, 01 Mar 2010 15:02:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <karlwmacmillan@gmail.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Audit2allow generating dontaudit rules.
References: <4B858A2A.8080302@redhat.com> <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
In-Reply-To: <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/01/2010 02:29 PM, Karl MacMillan wrote:
> I'd rather pass in the rule type to the AVRule init rather than a
> boolean about this being a dontaudit rule.
>
> Karl
>
> On Wed, Feb 24, 2010 at 3:20 PM, Daniel J Walsh<dwalsh@redhat.com>  wrote:
>    
>>
>>      
What function from audit2allow do you want the flag passed in?

             self.__avs = self.__parser.to_access(avcfilter, 
self.__options.dontaudit)
?

Or at a higher level.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
