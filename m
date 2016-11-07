Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA7DqpVM006084
 for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2016 08:52:53 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so178625359wmt.0
 for <selinux@tycho.nsa.gov>; Mon, 07 Nov 2016 05:52:52 -0800 (PST)
Received: from [192.168.0.25] ([151.58.14.242])
 by smtp.googlemail.com with ESMTPSA id 71sm13683917wmo.7.2016.11.07.05.52.49
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Nov 2016 05:52:49 -0800 (PST)
Subject: Re: Security context of shared libraries
To: selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
From: mm <mm19827@gmail.com>
Message-ID: <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
Date: Mon, 7 Nov 2016 14:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 11/7/2016 2:35 PM, Stephen Smalley wrote:
> On 11/05/2016 02:55 PM, mm wrote:
>> Hi all,
>>
>> I have an executable started by /bin/foo which runs confined within the
>> context foo_t.
>> The process loads (actually does LD_PRELOAD) bar.so which needs to
>> access resources outside foo_t (actually unconfined_t).
>
> I understand what you are saying but it wouldn't be secure and it is not
> possible.  Instead, run bar.so in a separate program/process and have
> them communicate over an IPC mechanism.
>
Thanks for the reply, but it is not clear to me why it would not be secure.

Unfortunately I don't have control on bar.so.
Nonetheless, your reply may suggest the symmetric strategy:
bar.so is in fact an IPC proxy to an external process, say /bin/bar, 
which currently runs unconfined (and that also I have no control on).
What I might think of is to define a bar_t context for /bin/bar, and 
allow the required access from foo_t to bar_t (instead of allowing from 
foo_t to unconfined_t).
The idea is still to minimize access extension for foo_t, handling the 
target side instead of the source side.

Moreover, in order not to compromise the functionality of /bin/bar, I 
would need to allow bar_t the same access as unconfined_t (at least as a 
first approximation). The fact is that, although I can trust /bin/bar, 
it is not selinux-aware.

Would this be effective?
What would be the easiest way to define the bar_t context (i.e. define a 
context with the same access rights as another one)?

Thanks in advance,
M. Manfredini
