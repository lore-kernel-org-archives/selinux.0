Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3UBGeVE025056
	for <selinux@tycho.nsa.gov>; Thu, 30 Apr 2009 07:16:40 -0400
Received: from mail-fx0-f212.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3UBGdPk014551
	for <selinux@tycho.nsa.gov>; Thu, 30 Apr 2009 11:16:40 GMT
Received: by fxm8 with SMTP id 8so1921760fxm.18
        for <selinux@tycho.nsa.gov>; Thu, 30 Apr 2009 04:16:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241063131.1951.8.camel@unix>
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
	 <C61510C5.A6A7F%csellers@tresys.com>
	 <9f066ee90904222001xb31b39ajf6953ca0767f3494@mail.gmail.com>
	 <1240609446.13724.20.camel@faith.austin.ibm.com>
	 <9f066ee90904292005i282d1339ld060cd90fa9e9dae@mail.gmail.com>
	 <1241063131.1951.8.camel@unix>
Date: Thu, 30 Apr 2009 07:16:38 -0400
Message-ID: <9f066ee90904300416w7fdf925fs832fd700f26fbe1e@mail.gmail.com>
Subject: Re: labeled network aware kernel
From: Mark Webb <elihusmails@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That was my guess.  I am using ipsec-tools (racoon) with a completely
stock configuration.  I do not have alot of experience with
ipsec-tools, so I wonder if I am missing something in the
configuration.

Based on responses to this thread, the kernel that I am running with a
fully patched Fedora 10 should be OK.

Thanks again..

On Wed, Apr 29, 2009 at 11:45 PM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> On Wed, 2009-04-29 at 23:05 -0400, Mark Webb wrote:
>> I am working to get the labelled IPSec working, following Josh
>> Brindle's blog post
>> (http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux).
>>  I just want to get the client and server running on loopback, using a
>> fully patched Fedora 10 machine.
>>
>> I have the following keyfile that I pass into setkey:
>> ----------
>> spdflush;
>>
>> flush;
>>
>> spdadd 127.0.0.1 127.0.0.1 any
>> -ctx 1 1 "system_u:object_r:default_t:s0"
>> -P in ipsec esp/transport//require;
>>
>> spdadd 127.0.0.1 127.0.0.1 any
>> -ctx 1 1 "system_u:object_r:default_t:s0"
>> -P out ipsec esp/transport//require;
>> ----------
>>
>> I enter the following commands:
>>
>> --- Terminal 1 ---
>> setenforce 0
>> setkey -f <keyfile>
>> ./server
>>
>> --- Terminal 2 ---
>> # ./client 127.0.0.1
>> getpeercon: Protocol not available
>> Received: Hello, (null) from (null)
>>
>> --- Terminal 1 ---
>> getsockopt: Protocol not available
>> server: got connection from 127.0.0.1, (null)
>>
>> Not sure what I am missing.  I have installed ipsec-tools and started
>> /etc/init.d/racoon.
>>
>> Any help would be appreciated.
>>
>> --Mark
>>
>>
>> On Fri, Apr 24, 2009 at 5:44 PM, Joy Latten <latten@austin.ibm.com> wrote:
>> > Hi Mark,
>> >
>> > If interested, there are ietf drafts for labeled ipsec,
>> > http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev1-security-context-00.txt
>> > and
>> > http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev2-security-context-00.txt.
>> >
>> > Also, I'd be happy to help by answering any questions.
>> >
>> > regards,
>> > Joy Latten
>> >
>> > On Wed, 2009-04-22 at 23:01 -0400, Mark Webb wrote:
>> >> I am looking at the IPSec-based labeled networking.
>> >>
>> >> BTW.  I will be at the Tresys Advanced Policy course next week.  Is
>> >> any of this covered there?
>> >>
>> >> Thanks,
>> >>
>> >> On Wed, Apr 22, 2009 at 6:21 PM, Chad Sellers <csellers@tresys.com> wrote:
>> >> > Josh's article talks about IPSec labeled networking (as well as using
>> >> > SECMARK which provides firewall-level networking controls), as opposed to
>> >> > Netlabel labeled networking. I played with the IPSec-based stuff in Fedora 9
>> >> > and everything was there, so I'd imagine it's still there in F10. Just make
>> >> > sure you install ipsec-tools.
>> >> >
>> >> > Chad Sellers
>> >> >
>> >> >
>> >> > On 4/22/09 7:26 AM, "Mark Webb" <elihusmails@gmail.com> wrote:
>> >> >
>> >> >> I am interested in experimenting with the labeled networking that SE
>> >> >> Linux offers.  I am reading through Josh Brindle's blog
>> >> >>
>> >> >> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
>> >> >>
>> >> >> My question is, how do I know if my kernel is capable of supporting
>> >> >> this?  I am currently running Fedora 10 with all the latest updates
>> >> >> but not sure how to check.
>> >> >>
>> >> >> Also if I compile a kernel from source, is there anything that needs
>> >> >> to be done in the configuring of the kernel build to enable the
>> >> >> labeled networking?
>> >> >>
>> >> >> Thanks,
>> >> >> Mark
>> >> >>
>> >> >> --
>> >> >> This message was distributed to subscribers of the selinux mailing list.
>> >> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> >> >> the words "unsubscribe selinux" without quotes as the message.
>> >> >
>> >> >
>> >>
>> >>
>> >> --
>> >> This message was distributed to subscribers of the selinux mailing list.
>> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> >> the words "unsubscribe selinux" without quotes as the message.
>> >
>> >
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
>
> ipsec is tricky(especially with the keys in
> ipsec.conf)
> For me I usually
> would create(as a test) a machine
> as the server running a shoutcast stream
> then the client connecting, using etherape
> as the eyes to see whats happening.
> In you're case I'm not sure about using
> one machine as a loop(better than trying to
> run AH through NAT)
>
> Justin P. Mattock
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
