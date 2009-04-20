Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3KK2qRH014542
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 16:02:52 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3KK2pOt019340
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 20:02:51 GMT
Message-ID: <49ECD200.8000104@redhat.com>
Date: Mon, 20 Apr 2009 15:50:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Bandan Das <bandan.das@stratus.com>
CC: selinux <selinux@tycho.nsa.gov>,
        "Johnson, Richard" <Richard.Johnson@stratus.com>
Subject: Re: genhomedircon errors with NIS
References: <1240253643.7743.78.camel@BSD.mno.stratus.com>	 <49ECC813.5050403@redhat.com> <1240256165.7743.92.camel@BSD.mno.stratus.com>
In-Reply-To: <1240256165.7743.92.camel@BSD.mno.stratus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/20/2009 03:36 PM, Bandan Das wrote:
> On Mon, 2009-04-20 at 15:08 -0400, Daniel J Walsh wrote:
>> On 04/20/2009 02:54 PM, Bandan Das wrote:
>>> Hello,
>>>
>>> This is a RHEL 5.3 system with SELinux configured in the targeted mode.
>>> Whenever genhomedircon is invoked, either as part of loading a new
>>> policy module or anything else, genhomedircon will report errors going
>>> through the NIS database :
>>>
>>> bdas homedir /h/bdas or its parent directory conflicts with a
>>> defined context in /etc/selinux/targeted/contexts/files/file_contexts,
>>> /usr/sbin/genhomedircon will not create a new context. This usually
>>> indicates an incorrectly defined system account.  If it is a system
>>> account please make sure its login shell is /sbin/nologin.
>>>
>>> /h is where the NIS home directory is automounted and the above message
>>> appears for all the NIS users.
>>>
>>> As expected, running genhomedircon manually with the "-n" switch will
>>> not spew these messages. If I look at file_contexts, I do not find any
>>> specified context for /h.
>>>
>>>
>>> Any ideas ?
>>>
>>>
>>>
>> genhomedircon is trying to label the directory above /h "/" to be
>> home_root_t.  It sees this directory and complains.  I think the problem
>> here is you actually have a user /h.
> I am sure I don't have a user "/h" on my local system. I also did a
> "ypcat passwd" and scanned all the users to see if there is anyone with
> name "h" or "\h".
>
>> What does the homedir of one of
>> the users look like?
> Do you mean on the NIS server ?
> Here is one of the entries from "ypcat passwd" :
>
> name:x:22832:263:First Last:/h/name:/bin/tcsh
>
>> We have the ability to disable genhomedircon in Fedora 10 and beyond.
>>
> Can I somehow prevent genhomedircon from touching /h at all ? Using the
> "-n" switch does make things different but I am not sure if it's going
> to create any other problems.
>
> Rich, I had found another similar bug :
> https://bugzilla.redhat.com/show_bug.cgi?id=186594 but it appears to be
> a different problem.
>
> Thanks!
> Bandan
>
genhomedircon on RHEL5 is a python script so you can edit it and have it 
exit on start or ignore /h

But if we update policycoreutils, you changes would get overwritten.

I believe this works but I never tried it.

Add the following to /etc/selinux/semanage.conf and it will use the 
alternate script instead of the standard


[genhomedircon]
path = /usr/local/sbin/genhomedircon_modified args = -t $@
[end]




[genhomedircon]
path = /usr/bin/true args = -t $@
[end]

would cause it to always succeed and do nothing.  ( I think.)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
