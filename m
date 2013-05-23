Message-ID: <519E5FB3.4070802@tresys.com>
Date: Thu, 23 May 2013 14:28:03 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Future of SETools and CIL
References: <5194E01F.2040505@tresys.com> <51950B5D.6050500@tycho.nsa.gov>
In-Reply-To: <51950B5D.6050500@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/16/2013 12:37 PM, Stephen Smalley wrote:
> On 05/16/2013 09:33 AM, Steve Lawrence wrote:
>> It has become clear that SETools has fallen behind userspace in terms of
>> features and general maintenance. We would like to get it to the point
>> where this is not the case, and to find a way to make sure it does not
>> happen again. We think the solution to the maintenance issue is to make
>> it more visible by merging the more useful parts of SETools into the
>> userspace repo, while deprecating/removing the remaining pieces.
>>
>> However, we are well aware of the complexity of SETools, primarily
>> libapol, and that upstreaming it without any changes would not solve the
>> problems. So, we have done a little work behind the scenes to find a way
>> to reduce the complexity of libapol. As a first stab at it, we started
>> with an older version of libapol that is quite a bit less complex and
>> began porting it forward for use with modern userspace, and seeing if it
>> would make sense to eventually merge. But before we get too deep into
>> this port, we wanted to start a discussion with the SELinux community to
>> make sure we are headed in the right direction. So to start, does this
>> seem like a good idea (both merging with userspace and porting older
>> libapol)? Or should we take a completely different direction (e.g. the
>> use of graphing databases as a replacement of apol has been mentioned in
>> the past)?
>
> What is it that makes the modern version of libapol more complex, or
> what are you giving up by going back to the older version?
>

Sorry it took so long to get back to you. The current version of libapol 
heavily relies on object oriented techniques, but is entirely written in 
C. For example, it uses iterators and a lot of function pointers to use 
something akin to inheritance. This makes it very awkward to program in 
and adds an unnecessary level of complexity.

Going back to an older version would lose features and support for 
policy versions later than 20. The idea was that we would go back to a 
simpler point and rebuild or pull in the necessary features and newer 
policy version support. A because of the much simpler code base of an 
older version, adding back the features would hopefully not be too 
difficult.

However, perhaps reducing the complexity isn't worth the effort. And 
maybe the dependence of tools in userspace would add more work. It 
sounds like maybe the best route might be to merge in libapol in it's 
current state. And as updates need to be made for Dan's and other tools 
that use libapol, we can gradually reduce the complexity without 
breaking everything?

- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
