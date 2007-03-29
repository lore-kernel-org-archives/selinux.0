Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2TCcCtL027245
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 08:38:12 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2TCcBAB022173
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 12:38:11 GMT
Message-ID: <460BB32F.8070801@manicmethod.com>
Date: Thu, 29 Mar 2007 08:38:08 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] map booleans during expansion
References: <1175098597.2062.11.camel@localhost.localdomain> <1175114632.10390.1.camel@localhost.localdomain>
In-Reply-To: <1175114632.10390.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> [below is a response to an accidentally off-list discussion]
>
> On Wed, 2007-03-28 at 12:29 -0400, Stephen Smalley wrote:
>   
>> On Wed, 2007-03-28 at 12:16 -0400, Karl MacMillan wrote:
>>     
>>> Currently, the expander does not map booleans during expansion.
>>>       
> However,
>   
>>> it is possible that booleans can be declared in an optional block
>>> resulting in the need to map the booleans. This patch adds boolean
>>> mappings to the expander. The same thing likely needs to be done for
>>> roles and users - Josh, can you confirm
>>>       
This is correct, only types are being remapped by the expander. I guess 
someone didn't think all the extra code to remap all of them was worth 
it since they are very small namespaces anyway.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
