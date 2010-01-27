Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0RGEtex008564
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 11:14:55 -0500
Received: from mho-02-ewr.mailhop.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0RGEtl5025677
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 16:14:55 GMT
Subject: Re: odd behavior of newrole setting level
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Joe Nall <joe@nall.com>
In-Reply-To: <4B604A21.4060000@redhat.com>
Date: Wed, 27 Jan 2010 10:14:48 -0600
Cc: Andy Warner <warner@rubix.com>, selinux@tycho.nsa.gov
Message-Id: <2059284C-AF69-4AEE-B1D9-94C6AA7C60E8@nall.com>
References: <4B5FAF0A.8070402@rubix.com> <4B604A21.4060000@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jan 27, 2010, at 8:13 AM, Daniel J Walsh wrote:

> On 01/26/2010 10:12 PM, Andy Warner wrote:
>> Can someone explain why the first newrole (newrole -l s0) from the
>> commands below fails while the second newrole (newrole -l SystemLow)
>> succeeds. I am using Fedora 12 fully updated, the mls policy and the
>> mcstrans label translation service. s0 is mapped to SystemLow.
>> 
>> Thanks,
>> 
>> Andy
>> 
>> $ id -Z
>> staff_u:staff_r:staff_t:SystemLow-SystemHigh
>> $ newrole -l s0
>> staff_u:staff_r:staff_t:s0-SystemHigh is not a valid context
>> $ newrole -l SystemLow
>> Password:
>> $ id -Z
>> staff_u:staff_r:staff_t:SystemLow-SystemHigh
>> $ newrole -l s0-s0
>> Password:
>> $ id -Z
>> staff_u:staff_r:staff_t:SystemLow
>> 
>> 
>> 
>> 
>> 
> Looks like a bug in mcstrans.

I'll take a look. I can duplicate the behavior.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
