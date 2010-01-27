Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0REDRwF031030
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 09:13:27 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0REDPnN008019
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 14:13:26 GMT
Message-ID: <4B604A21.4060000@redhat.com>
Date: Wed, 27 Jan 2010 09:13:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: selinux@tycho.nsa.gov
Subject: Re: odd behavior of newrole setting level
References: <4B5FAF0A.8070402@rubix.com>
In-Reply-To: <4B5FAF0A.8070402@rubix.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/26/2010 10:12 PM, Andy Warner wrote:
> Can someone explain why the first newrole (newrole -l s0) from the
> commands below fails while the second newrole (newrole -l SystemLow)
> succeeds. I am using Fedora 12 fully updated, the mls policy and the
> mcstrans label translation service. s0 is mapped to SystemLow.
> 
> Thanks,
> 
> Andy
> 
> $ id -Z
> staff_u:staff_r:staff_t:SystemLow-SystemHigh
> $ newrole -l s0
> staff_u:staff_r:staff_t:s0-SystemHigh is not a valid context
> $ newrole -l SystemLow
> Password:
> $ id -Z
> staff_u:staff_r:staff_t:SystemLow-SystemHigh
> $ newrole -l s0-s0
> Password:
> $ id -Z
> staff_u:staff_r:staff_t:SystemLow
> 
> 
> 
> 
> 
Looks like a bug in mcstrans.

Translated s0 into s0-SystemHigh I would guess.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
