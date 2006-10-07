Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k97AQOFF025738
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 06:26:24 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k97APlrs028301
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 10:25:47 GMT
Message-ID: <452780C3.3090809@redhat.com>
Date: Sat, 07 Oct 2006 06:26:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: MMCS patch against subversion policy
References: <200610062109.51031.russell@coker.com.au> <4526AC45.5090104@redhat.com> <200610071118.18718.russell@coker.com.au>
In-Reply-To: <200610071118.18718.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 07 October 2006 05:19, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>> Russell Coker wrote:
>> This is fine.  The only problem we have seen with MMCS is when an
>> administrator logs in at SystemLow and su to root they have to be able
>> to see and kill processes running at different levels.
>> They should also be able to run the debugger against them.    If I am
>> not using MCS I should not be hindered by it.
>>     
>
> So you give the administrator the range SystemLow-SystemHigh and that's 
> covered.  I can't imagine why you would want to give the administrator any 
> different range.
>   
We do not define administrators in targeted policy.  There is only 
unconfined users.  All users in by default login with s0, not 
SystemLow-SystemHigh.  We could make that change but then it would get 
harder to turn on MCS as you would need to start thinking in terms of 
administators.
>   
>>> The controversial patch is relabelling certain files under /selinux to
>>> SystemHigh (it also needs restorecon run from /etc/rc.sysinit).  I know
>>> that Steve won't like this and anticipate that others might not either. 
>>> That's OK, the other two patches are useful without it.
>>>       
>> Not sure why you want to do this?
>>     
>
> So that you can't trivially escape from the MCS part of the policy as root.
>
>   

MCS Was designed as a descretionary mechanism,  so I don't have a 
problem with this.  If I become admin I can easily change my roles using 
semanage anyways, so this is not a security issue.  Maybe in the future 
we can experiment with this, but for RHEL5, when a normal administrator 
logs onto a system, he is unconfined_t and when he becomes root he needs 
to be able to control the processes on the system.  targeted policy is 
not about controlling the logged in user, yet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
