Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88FjNjK023169
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 11:45:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k88FibA0001250
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:44:37 GMT
Message-ID: <45019051.304@gentoo.org>
Date: Fri, 08 Sep 2006 11:46:25 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Rodrigo Vivi <vivijim@br.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils semanage for nodes
References: <200609051527.41081.vivijim@br.ibm.com>	 <4501762F.9020803@gentoo.org> <1157728323.21235.24.camel@localhost.localdomain>
In-Reply-To: <1157728323.21235.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Fri, 2006-09-08 at 09:54 -0400, Joshua Brindle wrote:
>   
>> Rodrigo Vivi wrote:
>>     
>>> Hi all,
>>>
>>> Since libsemanage support node context management and semanage command for 
>>> policycoreutils does not, I thought that was a good idea to implement this.
>>>
>>> This patch provide all that semanage command needs to manage nodes context.
>>> (including a man page updated)
>>>
>>> However I know that SECMARK mechanism largely obsoletes the use of
>>> netif and node contexts going forward, but I did this patch because I was 
>>> missing the node management at semanage command.
>>>
>>> Thanks,
>>> Rodrigo Vivi.
>>> (vivijim at #selinux)
>>>   
>>>   
>>>       
>> In addition to the comments below, I tried this patch out and while it 
>> indeed added the nodecon it didn't seem to have a net effect on the 
>> system. This is probably because of ordering issues which IIRC is why we 
>> never had this support to begin with.
>>
>>     
>
> How is this different from the port sorting problem? For a simple
> example pre-pending the local modifications should have the desired
> effect, so this sounds like a general semanage bug to me.
>
>   
Which wasn't fixed in this patch and so shouldn't be merged

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
