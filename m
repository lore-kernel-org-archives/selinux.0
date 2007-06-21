Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LGngJF010398
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 12:49:42 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5LGnajl011651
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 16:49:36 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 1/3] libsemanage: genhomedircon replacement
Date: Thu, 21 Jun 2007 12:49:35 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>
In-Reply-To: <1182443353.11527.50.camel@localhost.localdomain>
References: <20070521095414.832619201@tresys.com> <20070521095518.515998898@tresys.com> <1179868119.9092.38.camel@localhost.localdomain> <1180015458.3930.173.camel@tresys-winxppro> <1180017921.2940.24.camel@localhost.localdomain> <1180034401.3930.203.camel@tresys-winxppro> <1180108369.6331.18.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com> <1180137749.10334.18.camel@localhost.localdomain> <4677F1BC.2000201@tresys.com> <1182443353.11527.50.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Mark Goldman" <mgoldman@tresys.com>, "SE Linux" <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Tue, 2007-06-19 at 11:09 -0400, Joshua Brindle wrote:
>> Karl MacMillan wrote:
>>> On Fri, 2007-05-25 at 13:06 -0400, Joshua Brindle wrote:
>>>> Karl MacMillan wrote:
>>>>>> If you would like to move the list types out of policyrep and
>>>>>> into trunk, I'll be happy to use it.  Otherwise it is out of the
>>>>>> scope of this patch. 
>>>>>> 
>>>>> Please rebase against the policyrep branch - we can then consider
>>>>> merging the list types and this patch to trunk if desired. I will
>>>>> NACK this patch if it contains the additional list types.
>>>> There aren't additional list types because there aren't any in
>>>> trunk. This has nothing to do with policyrep and doesn't break ABI
>>>> compatibility and should be in trunk. I hate this idea of pushing
>>>> everything into policyrep because its going to make it that much
>>>> harder to get good testing done and the source of bugs will be
>>>> harder to track down. 
>>>> 
>>> 
>>> Ok.
>>> 
>>>> If you are so insistent on using the list types in policyrep why
>>>> not port them to trunk so we can use them?
>>> 
>>> That option is fine with me (and was one of my suggestions), though
>>> I don't have time to do the port right now. Can you or Mark send a
>>> patch pulling over the iterators and list?
>> 
>> I'm going to bring this back up because I think this patch is
>> important to get into upstream as a first step toward generic label
>> generation. 
>> 
> 
> Can you tell me a little more about what you are thinking with this?
> 
>> Since we aren't using the policyrep branch anymore and libpolicyrep
>> is going to be in c++ do you still have reservations against this
>> patch? 
>> 
> 
> I'm still convinced about the maintenance long term and
> potential for errors. Have all of the implementation issues
> that James brought up been resolved? Remind me why this is
> better in C than in an external Python helper.
> 

Its very hacky, we have to close the current transaction (from within
the library) so that genhomedircon can connect and get a read lock on
the newly created active store and then it modifies the files outside of
the module store, non-ideal in almost every way.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
