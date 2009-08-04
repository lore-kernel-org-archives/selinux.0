Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n74FFrSn017710
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 11:15:53 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n74FFQQn008357
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 15:15:27 GMT
Message-ID: <4A7850A3.3000407@redhat.com>
Date: Tue, 04 Aug 2009 11:15:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Just a quick thought.
References: <4A781970.7000106@redhat.com> <1249387556.2932.4.camel@gorn.columbia.tresys.com>
In-Reply-To: <1249387556.2932.4.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/04/2009 08:05 AM, Christopher J. PeBenito wrote:
> On Tue, 2009-08-04 at 07:20 -0400, Daniel J Walsh wrote:
>> Now that we have labelling equivalence should we just add a 
>>
>> /lib64 /lib
>> /usr/lib64 /usr/lib
>> /usr/local/lib64 /usr/local/lib
>>
>> Seems we could simplify policy and prevent many mistakes.  Might speed up regex matching a little bit.
>>
>>
>> grep 64 /etc/selinux/targeted/contexts/files/file_contexts | wc
>>     259     735   18694
>>
>>
>> If were were more agressive
>>
>> /usr/local /usr
>> /opt /usr
> 
> Makes sense to me.  But is there a way for the policy to specify an
> equivalence, or is it currently limited to the semanage cli?
> 
Currently it is CLI, but it should probably be merged into the sandbox, some how.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
