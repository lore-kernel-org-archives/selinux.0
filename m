Message-ID: <46D5822F.3010804@manicmethod.com>
Date: Wed, 29 Aug 2007 10:26:55 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Joe Nall <joe@nall.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <46D4EBEA.509@manicmethod.com> <46D4F1E2.4050503@manicmethod.com> <200708290821.46404.paul.moore@hp.com>
In-Reply-To: <200708290821.46404.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Wednesday, August 29 2007 12:11:14 am Joshua Brindle wrote:
>   
>> Ok, I think my brain is still catching up on this thread.
>>     
>
> My brain gave up quite a while ago ... it's just nerves banging away at the 
> keyboard now :)
>
>   
>> Because of 
>> what I said above I think we should 1) not do node based fallbacks and
>> 2) not do nic alias-level fallbacks. This is the safe option (as already
>> pointed out) and minimizes trust in untrustworthy things (eg., addresses
>> coming from the network).
>>
>> OTOH it may make some peoples lives easier to allow this. It is a false
>> sense of security though so I vote for doing nic level fallbacks only
>> and if someone *really* wants to do this they can just plug several nics
>> into the same network (hopefully they'd recognize the horrible things
>> they are doing if it is explicit like that).
>>
>> It sounds like the decision is still up in the air though, does anyone
>> inherently disagree with me here?
>>     
>
> I guess every decision is technically up in the air until the changes/patches 
> are included in a released kernel, however, I'm pretty confident that host 
> level granularity of both fallback labels and flow control peer label 
> filtering is "the right thing".
>
> I understand your point about not extending trust beyond the level of the 
> physical wire, that is very easy to rationalize/understand.  However, from a 
> practical real-world scenario (see my home network behind a NAT box example, 
> as well as others) I think there is real value in extending the labeling 
> beyond the wire to the host/network level.  SELinux has always made some 
> allowances to facilitate adoption and ease of use, i.e. unconfined_t, but has 
> been careful to make sure that these concessions were always at the 
> discretion of the system administrator.  Fallback labeling and peer flow 
> controls are configuration options which are only available to the system 
> administrator and providing host level granularity can be a significant 
> benefit to a lot of people.
>   

concessions are fine when the ramifications are understood, unconfined_t 
is pretty obvious. But when there are security people that believe host 
based labeling buys anything then it may be an inappropriate concession. 
I mean, if I can get on your network and in a matter of seconds take 
over both your IP and MAC address it isn't good. Worse, I could use 
something like ettercap and MiM you without you even knowing (and even 
inject data into the stream).

The last email from Joe shows that even security centric people are fine 
with this situation in a 'medium assurance' environment, if medium 
assurance means trivially bypassable please count me out. A single 
shared network is in no way medium assurance IMO, there is no inherent 
security when you are on a single network (save for fancy switches that 
do mac filtering and ip locking per port, how many people actually use 
those features though).

One interesting thing that just occurred to me is vlans. I'm not sure 
how vlans are implemented on Linux (do they get their own interface 
names?) but they are much better than the alternative which lets anyone 
do anything on a single network.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
