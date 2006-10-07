Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k97BSM3U026819
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 07:28:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k97BRjrs004359
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 11:27:45 GMT
Message-ID: <45278F48.2040501@redhat.com>
Date: Sat, 07 Oct 2006 07:28:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: MMCS patch against subversion policy
References: <200610062109.51031.russell@coker.com.au> <200610071118.18718.russell@coker.com.au> <452780C3.3090809@redhat.com> <200610072113.18735.russell@coker.com.au>
In-Reply-To: <200610072113.18735.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 07 October 2006 20:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>> Russell Coker wrote:
>>     
>>> On Saturday 07 October 2006 05:19, Daniel J Walsh <dwalsh@redhat.com> 
>>>       
> wrote:
>   
>>>> This is fine.  The only problem we have seen with MMCS is when an
>>>> administrator logs in at SystemLow and su to root they have to be able
>>>> to see and kill processes running at different levels.
>>>> They should also be able to run the debugger against them.    If I am
>>>> not using MCS I should not be hindered by it.
>>>>         
>>> So you give the administrator the range SystemLow-SystemHigh and that's
>>> covered.  I can't imagine why you would want to give the administrator
>>> any different range.
>>>       
>> We do not define administrators in targeted policy.
>>     
>
> The root identity seems like an administrator to me, it has 
> SystemLow-SystemHigh as it's range and all roles are permitted.  Given that 
> in all but the strangest situations root has UID==0 the root identity will be 
> an administrator identity.
>
> The issue is that someone can login as a non-administrator identity and su 
> will not give them the administrator credentials.  This happens with MCS in 
> it's current form and is not changed by the patches I posted.
>
> If you login as non-root to a recent rawhide machine or FC5 with all updates 
> and then run "su -" you will find yourself unable to kill or ptrace udevd and 
> cups.
>
>   
No with the latest updates you are able to do this on Fedora Core 6.
> Your message wasn't clear, were you claiming this to be a problem with my MMCS 
> patch or noting it as an issue with the current MCS?
>   
No I don't think that is the case with MMCS, but I want to make it clear 
that the admin has to
have this ability.
>   
>> There is only 
>> unconfined users.  All users in by default login with s0, not
>> SystemLow-SystemHigh.  We could make that change but then it would get
>> harder to turn on MCS as you would need to start thinking in terms of
>> administators.
>>     
>
> Maybe we need to modify useradd to manage the SE Linux identity.  We could do 
> something like have membership of group wheel mean that by default a login 
> entry will be created with SE Linux identity "root".
>
>   
>>>>> The controversial patch is relabelling certain files under /selinux to
>>>>> SystemHigh (it also needs restorecon run from /etc/rc.sysinit).  I know
>>>>> that Steve won't like this and anticipate that others might not either.
>>>>> That's OK, the other two patches are useful without it.
>>>>>           
>>>> Not sure why you want to do this?
>>>>         
>>> So that you can't trivially escape from the MCS part of the policy as
>>> root.
>>>       
>> MCS Was designed as a descretionary mechanism,  so I don't have a
>> problem with this.  If I become admin I can easily change my roles using
>> semanage anyways, so this is not a security issue.
>>     
>
> I think that the policy files should all be at SystemHigh in MCS.
>
>   
>> Maybe in the future 
>> we can experiment with this, but for RHEL5, when a normal administrator
>> logs onto a system, he is unconfined_t and when he becomes root he needs
>> to be able to control the processes on the system.  targeted policy is
>> not about controlling the logged in user, yet.
>>     
>
> Wasn't restricting unconfined_t the entire point of MCS?
>
>   
Not fully.  I see it in a descretionary sence versus a Mandatory.  My 
thoughts are
to prevent accidental leaks of information using MCS versus Malicious 
leaks of information.   So
I see it as a tool to allow people to handle labeled documents. 
> We already have daemon policy for the confined daemons that does a reasonable 
> job of keeping them away from user data.  MCS allows protecting your 
> important data from daemons that run in unconfined_t which doesn't do much 
> good as non-root daemons can be stopped by Unix permissions and root daemons 
> will just take advantage of the fact that /etc/shadow is SystemLow.
>
> MCS also allows easily creating compartments for users.  For example you could 
> have a category for each course in a university, have the low and high levels 
> of the processes for each user have only the category for their course and 
> then give staff a high level with the category for every student they 
> supervise and a low level of SystemLow.  Then most of the university computer 
> fun and foolishness would be prevented.  This seems to me to be the main 
> benefit of MCS and one which relies on controlling the logged in user.
>
> As MCS does not restrict directory access, IPC, or networking it doesn't make 
> the system much more difficult to use and avoids the problems we had with 
> strict policy.
>
>
> Also note that I would be happy to see some of my patches go into the 
> refpolicy tree with ifdef(`RHEL5', `', ` before them.  Not that I think that 
> my MMCS patches will make things any more difficult for what you are trying 
> to do with RHEL5.  It seems to me that you have identified some of the 
> features of the policy which were introduced soon after the release of FC5 as 
> being potential problems for RHEL5.
>
>   

I am not stating a problem with your patches.  I am putting out a 
cautionary note, that we
do not want an unexpected change in the OS, especially at this late 
time.  The admininstator, running su and not being able to see,stop, 
debug a process was an unexpected side effect of MCS.  This
problem has been fixed in current targeted policy.  And I don't think 
your patches will effect this.

BTW.  I am hoping to begin confining user space in targeted policy 
starting in FC7.  Figuring out how to allow administrators in other 
domains then unconfined_t.  (webadm_t, bindadm_t).  Allowing booleans to 
turn on confinement of firefox and evolution/thunderbird.  So at this time
we might want to look at making MCS more "Mandatory".



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
