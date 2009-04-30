Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3U35S9w019030
	for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2009 23:05:29 -0400
Received: from mail-bw0-f160.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3U35R82012889
	for <selinux@tycho.nsa.gov>; Thu, 30 Apr 2009 03:05:27 GMT
Received: by bwz4 with SMTP id 4so1701968bwz.18
        for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2009 20:05:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1240609446.13724.20.camel@faith.austin.ibm.com>
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
	 <C61510C5.A6A7F%csellers@tresys.com>
	 <9f066ee90904222001xb31b39ajf6953ca0767f3494@mail.gmail.com>
	 <1240609446.13724.20.camel@faith.austin.ibm.com>
Date: Wed, 29 Apr 2009 23:05:24 -0400
Message-ID: <9f066ee90904292005i282d1339ld060cd90fa9e9dae@mail.gmail.com>
Subject: Re: labeled network aware kernel
From: Mark Webb <elihusmails@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am working to get the labelled IPSec working, following Josh
Brindle's blog post
(http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux).
 I just want to get the client and server running on loopback, using a
fully patched Fedora 10 machine.

I have the following keyfile that I pass into setkey:
----------
spdflush;

flush;

spdadd 127.0.0.1 127.0.0.1 any
-ctx 1 1 "system_u:object_r:default_t:s0"
-P in ipsec esp/transport//require;

spdadd 127.0.0.1 127.0.0.1 any
-ctx 1 1 "system_u:object_r:default_t:s0"
-P out ipsec esp/transport//require;
----------

I enter the following commands:

--- Terminal 1 ---
setenforce 0
setkey -f <keyfile>
./server

--- Terminal 2 ---
# ./client 127.0.0.1
getpeercon: Protocol not available
Received: Hello, (null) from (null)

--- Terminal 1 ---
getsockopt: Protocol not available
server: got connection from 127.0.0.1, (null)

Not sure what I am missing.  I have installed ipsec-tools and started
/etc/init.d/racoon.

Any help would be appreciated.

--Mark


On Fri, Apr 24, 2009 at 5:44 PM, Joy Latten <latten@austin.ibm.com> wrote:
> Hi Mark,
>
> If interested, there are ietf drafts for labeled ipsec,
> http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev1-security-context-00.txt
> and
> http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev2-security-context-00.txt.
>
> Also, I'd be happy to help by answering any questions.
>
> regards,
> Joy Latten
>
> On Wed, 2009-04-22 at 23:01 -0400, Mark Webb wrote:
>> I am looking at the IPSec-based labeled networking.
>>
>> BTW.  I will be at the Tresys Advanced Policy course next week.  Is
>> any of this covered there?
>>
>> Thanks,
>>
>> On Wed, Apr 22, 2009 at 6:21 PM, Chad Sellers <csellers@tresys.com> wrote:
>> > Josh's article talks about IPSec labeled networking (as well as using
>> > SECMARK which provides firewall-level networking controls), as opposed to
>> > Netlabel labeled networking. I played with the IPSec-based stuff in Fedora 9
>> > and everything was there, so I'd imagine it's still there in F10. Just make
>> > sure you install ipsec-tools.
>> >
>> > Chad Sellers
>> >
>> >
>> > On 4/22/09 7:26 AM, "Mark Webb" <elihusmails@gmail.com> wrote:
>> >
>> >> I am interested in experimenting with the labeled networking that SE
>> >> Linux offers.  I am reading through Josh Brindle's blog
>> >>
>> >> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
>> >>
>> >> My question is, how do I know if my kernel is capable of supporting
>> >> this?  I am currently running Fedora 10 with all the latest updates
>> >> but not sure how to check.
>> >>
>> >> Also if I compile a kernel from source, is there anything that needs
>> >> to be done in the configuring of the kernel build to enable the
>> >> labeled networking?
>> >>
>> >> Thanks,
>> >> Mark
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
