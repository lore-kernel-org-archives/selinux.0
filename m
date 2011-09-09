Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89NFwvr010149
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 19:15:58 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89NFvvK026197
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 23:15:57 GMT
Message-ID: <4E6A9E26.9080806@redhat.com>
Date: Fri, 09 Sep 2011 19:15:50 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: Joshua Brindle <method@manicmethod.com>,
        Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
References: <1315587716.2170.16.camel@vortex>    <1315588656.2170.26.camel@vortex>    <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>    <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>   <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>  <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com> <1315609967.2482.39.camel@vortex>
In-Reply-To: <1315609967.2482.39.camel@vortex>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/09/2011 07:12 PM, Guido Trentalancia wrote:
> On Fri, 2011-09-09 at 19:07 -0400, Eric Paris wrote:
>> On 09/09/2011 06:35 PM, Guido Trentalancia wrote:
>>> The following patch is probably even better as it actually sorts out the
>>> problem rather than just printing out a warning (it can still be
>>> combined with the creation of a top-level README file):
>>>
>>> diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/checkpolicy/Makefile selinux-09092011-local-headers/checkpolicy/Makefile
>>> --- selinux-09092011-orig/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
>>> +++ selinux-09092011-local-headers/checkpolicy/Makefile	2011-09-10 00:21:16.242852130 +0200
>>> @@ -12,7 +12,7 @@ YACC = bison -y
>>>  
>>>  CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
>>>  
>>> -override CFLAGS += -I. -I${INCLUDEDIR}
>>> +override CFLAGS += -I. -I../libsepol/include -I${INCLUDEDIR}
>>
>> I haven't checked, but can the makefiles then work when there is no
>> ../libsepol/include?
> 
> If ../libsepol/include does not exist and libsepol headers are not
> installed under the standard location (${INCLUDEDIR}), then the above is
> going to fail.
> 
> But why should libsepol/include be missing from git in the first
> place ??

I agree that they must be in one or the other for it to build.  A number
of distros build these packages separately, rather than all at once.
Thus there would be no ../libsepol/include directory at all, but the
headers should be picked up by -I$(INCLUDEDIR).  As long as gcc doesn't
care that the directory doesn't exist, I actually like it.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
