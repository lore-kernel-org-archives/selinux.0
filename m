Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6SJ8lS6003152
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 15:08:47 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6SJ8ilq004067
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 19:08:44 GMT
Message-ID: <44CA60BC.1030503@hp.com>
Date: Fri, 28 Jul 2006 15:08:44 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 2/7] NetLabel: core network changes
References: <20060717155224.060020000@hp.com> <20060717155822.315389000@hp.com> <20060728112426.GE14627@postel.suug.ch> <44CA504C.6030207@hp.com> <20060728181225.GF14627@postel.suug.ch> <44CA59D8.4090702@hp.com> <20060728185825.GG14627@postel.suug.ch>
In-Reply-To: <20060728185825.GG14627@postel.suug.ch>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Graf wrote:
> * Paul Moore <paul.moore@hp.com> 2006-07-28 14:39
> 
>>It sounds like you main concern is that I'm not using the netlink
>>attribute interfaces, yes?  I looked at using those originally but
>>decided not to use them for the following reasons:
>>
>> 1. They are listed as "optional" in the documents I read
>> 2. They add at least an extra 32 bits to each attribute
>> 3. There seems to be plenty of users in net/ipv4 who do not make
>>    use of attributes (a *quick* look again reveals none)
>> 4. Since I'm reading messages from userspace I can't trust the
>>    message contents regardless of it's use of attributes
>> 5. Harder to work with in userspace without using a netlink
>>    library, which would create an extra dependency for tools which
>>    talk to the NetLabel subsystem
>>
>>Basically, I saw no requirement to use the netlink attributes and no
>>advantage so I didn't.  Is this reasonable, or do you feel the use of
>>attributes is a requirement?
> 
> Not a requirement but I would encourage it. Almost all netlink
> families are using attributes with a few exceptions. We just
> used to call them rtattr defined in rtnetlink.h before the new
> api was added. There is one huge advantage in using attributes
> which is that your protocol is extendable without breaking binary
> interfaces.
> 
> What I'm refering to primarly are the existing functions to write
> netlink and genetlink headers etc.

Okay.  Thanks for your feedback but unless I hear from others that this
is a requirement I think I'm going to leave the code as written for the
reasons I listed above.  I won't argue the fact that attributes may make
life easier when extending existing messages/interfaces but I think the
existing NetLabel message format as well as the generic netlinks
versioning of each message should allow plenty of room for growth in the
future (if needed).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
