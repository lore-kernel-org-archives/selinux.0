Message-ID: <40792555.7020808@snu.edu>
Date: Sun, 11 Apr 2004 06:00:37 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: audio-entropyd policy
References: <4078835F.2030801@snu.edu> <200404112013.10012.russell@coker.com.au> <40791D2C.7010702@snu.edu>
In-Reply-To: <40791D2C.7010702@snu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

oops, i forgot to include the list in this

Joshua Brindle wrote:
> Russell Coker wrote:
> 
>> On Sun, 11 Apr 2004 09:29, Joshua Brindle <jbrindle@snu.edu> wrote:
>>  
>>
>>> audio-entropyd available at http://www.vanheusden.com/aed/ adds entropy
>>> from sound devices (after being cleansed and hashed). This is
>>> particularly useful on headless servers which don't get any
>>> mouse/keyboard related entropy. The policy was written by Chris 
>>> Pebenito.
>>>   
>>
>>
>> Why is ipc_lock needed?  The random driver is designed such that 
>> knowing all data which is written to it does not permit predicting the 
>> output, and also if an attacker can access swap space then they can 
>> probably do worse attacks than attempting to predict the next random 
>> number.
>>
>> It seems to me that ipc_lock gives no benefit and just permits 
>> marginally reducing the amount of pagable memory.
>>
>> It's really a pity that sys_admin is needed for writing to the random 
>> device, that capability grants so much extra...
>>
>> I've added the policy to my tree, although I expect that any active 
>> server will be getting hard disk and network interrupts to generate 
>> some entropy.
>>
>>  
>>
> I'm not sure about the ipc_lock, pebenito will have to answer that one, 
> but on the subject of entropy the reason I investigated and started 
> using this is because ssp (formerly known as propolice) gets 32 bytes of 
> entropy per exec during guard_setup to make canaries. This is obviously 
> a huge drain on entropy. Network inturrupts only contribute to entropy 
> on a few drivers, the majority of them don't (unless you patch in the 
> netrand patches), disk access would contribute but not all servers have 
> major disk access (web servers where the majority of the content is 
> cached and/or on a remote database server for example). I found that 
> many of my machines had no entropy available most of the time wheras 
> with this I can set the poolsize to 8192 and consistantly have over 
> 50000 bits of entropy available (with good audio input).
> 
> Joshua Brindle
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
