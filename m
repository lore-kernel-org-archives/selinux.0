Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6GP7KZ003214
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 11:25:07 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kA6GNVPI012734
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 16:23:32 GMT
Message-ID: <454F61E0.7090705@gentoo.org>
Date: Mon, 06 Nov 2006 11:25:04 -0500
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rpmlint
References: <200611030816.22148.sgrubb@redhat.com>	 <454E6663.8070609@gentoo.org> <1162829020.26148.44.camel@localhost.localdomain>
In-Reply-To: <1162829020.26148.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Sun, 2006-11-05 at 17:32 -0500, Joshua Brindle wrote:
>> Steve Grubb wrote:
>>> Hi,
>>>
>>> Below is a patch that I am thinking about submitting to rpmlint. The main idea
>>> of this patch is to catch places where people might be coding policy knowledge
>>> into scripts. Chcon would require knowing some types in order to work. If the
>>> types ever got changed, the script would break. Can anyone think of other
>>> things we do not want to see in rpm scriplets?
>>>
>>> -Steve
>>>
>>>   
>> calling semanage thusly:
>>
>> semanage fcontext -a [any arguments here] /some/file
>>
>> actually any semanage command except *possibly* login and user, and I'm 
>> not sure they should be there either but someone may have an acceptable 
>> scenerio.
> 
> If we disallow this then what is the recommended way to allow an
> application to ship a labeling only policy? We need to allow
> applications to, for example, label a library as textrel_shlib_t without
> forcing them to ship a policy module.
> 

good question, we don't support policy packages without modules now, 
using types directly breaks any kind of encapsulation the policy may 
have had so its non-ideal anyway.

I think this is a more general problem, how does any given app know that 
it needs "some label" that gives it the ability to have textrels in its 
libraries.

> What if we added the ability to specify the store by name (i.e.,
> semanage -s targeted fcontext -a . . . .). I think it should be
> acceptable to make assumptions about what a well know policy contains.
> Getting them to use semanage in this way would fix other problems - like
> relabeling - without introducing unnecessary policy modules.
> 

Store is an arbitrary string that means nothing. Sure this is practical 
but there are version issues (if a type exists in some version X but not 
before that, etc).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
