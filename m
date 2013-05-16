Message-ID: <51950B5D.6050500@tycho.nsa.gov>
Date: Thu, 16 May 2013 12:37:49 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Future of SETools and CIL
References: <5194E01F.2040505@tresys.com>
In-Reply-To: <5194E01F.2040505@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/16/2013 09:33 AM, Steve Lawrence wrote:
> It has become clear that SETools has fallen behind userspace in terms of
> features and general maintenance. We would like to get it to the point
> where this is not the case, and to find a way to make sure it does not
> happen again. We think the solution to the maintenance issue is to make
> it more visible by merging the more useful parts of SETools into the
> userspace repo, while deprecating/removing the remaining pieces.
>
> However, we are well aware of the complexity of SETools, primarily
> libapol, and that upstreaming it without any changes would not solve the
> problems. So, we have done a little work behind the scenes to find a way
> to reduce the complexity of libapol. As a first stab at it, we started
> with an older version of libapol that is quite a bit less complex and
> began porting it forward for use with modern userspace, and seeing if it
> would make sense to eventually merge. But before we get too deep into
> this port, we wanted to start a discussion with the SELinux community to
> make sure we are headed in the right direction. So to start, does this
> seem like a good idea (both merging with userspace and porting older
> libapol)? Or should we take a completely different direction (e.g. the
> use of graphing databases as a replacement of apol has been mentioned in
> the past)?

What is it that makes the modern version of libapol more complex, or 
what are you giving up by going back to the older version?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
