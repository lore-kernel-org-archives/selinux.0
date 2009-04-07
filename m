Cc: selinux@tycho.nsa.gov
Message-Id: <3D57D9DF-104E-4603-A49E-37EDA16139CC@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1239107665.29028.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: diff between name_bind,bind and node_bind
Date: Tue, 7 Apr 2009 16:39:15 +0200
References: <B2B8AAE9-85F2-4A92-AA25-88C1493A2EB2@gmail.com> <1239107665.29028.13.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello stephen,

tnx for your answer. it helped me a lot. i already  did a "quick"  
check of  hooks.c before but i was not sure about it. for me there are  
some other unknowns. i only saw, that selinux does make some  
differences between various port "types/classes".

is it possible to control  that process cannot bind to a port which is  
in local port area (~32000-61000)?

so far i think it isn't possible.

--
Sebastian Pfaff

Am 07.04.2009 um 14:34 schrieb Stephen Smalley:

> On Tue, 2009-04-07 at 09:46 +0200, Sebastian Pfaff wrote:
>> hello,
>>
>> i'm working on a tutorial for selinux. in this tutorial i use nc
>> (netcat) as simple server. but i wonder, why nc -l 5555** (nc runs in
>> a own domain) does not need the name_bind permission to bind a port.
>> i already asked here regarding to this, but nobody has answered.
>>
>> can someone tell me how name_bind,bind and node_bind work and where
>> the differences are?
>>
>> i tried this  with socat (http://www.dest-unreach.org/socat/) too.
>> same effect. both socat and nc  "never"* need name_bind.
>>
>> is it possible that this pb is relying on how nc and socat work?
>>
>> tnx in advance && if you need  further information, please let me
>> know ...
>
> Hopefully my other reply clears this up for you - name_bind is not
> applied to ports in the auto-bind range.  You can see this quite  
> clearly
> from the code; look at security/selinux/hooks.c:selinux_socket_bind().
>
>> * funny is, if i implement a boolean which allows nc or socat to use
>> any port or only a speficic port, then i can see a name_bind "entry"
>> when in permissive mode in my avc log.  but i can't reproduce it.
>> maybe this is another problem.
>
> Permissive mode only logs each unique denial once by design, as you  
> only
> need one instance of each denial in order to generate policy and
> otherwise permissive mode is prone to flooding of the system log /  
> audit
> log.
>
>> ** same with echo "hello world" | socat - TCP-LISTEN:
>> 33331,bind=127.0.0.1
>
> -- 
> Stephen Smalley
> National Security Agency
>

--
Sebastian Pfaff





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
