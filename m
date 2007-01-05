Message-ID: <459E8323.8070808@mentalrootkit.com>
Date: Fri, 05 Jan 2007 11:56:03 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Ronan Waide <waider@amazon.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: creating a new role/user to administer a service
References: <1167908139.19878.12.camel@waider.desktop.amazon.com>	 <1168010769.18961.147.camel@moss-spartans.epoch.ncsc.mil>	 <459E74FE.9020508@mentalrootkit.com> <1168015689.9285.45.camel@sgc.columbia.tresys.com>
In-Reply-To: <1168015689.9285.45.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-01-05 at 10:55 -0500, Karl MacMillan wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2007-01-04 at 10:55 +0000, Ronan Waide wrote:
>>>> Hi,
>>>>
>>>> I've been digging through SELinux by example, the list archives, Dan
>>>> Walsh's livejournal, and the Fedora strict policy source, but I'm still
>>>> a bit stumped on how to get this working:
>>>>
>>>> I'd like to create an administrative role/user for BIND. specifically, I
>>>> do not, if possible, want to use something like sysadm_r; I would rather
>>>> that otherwise unprivileged users are either designated as bindadm_u
>>>> from login, or newrole into bindadm_r in order to manage the daemon. The
>>>> former is preferable, as I was hoping to make use of ssh keys to enable
>>>> remote management without multiple password entry.
>>>>
>>>> After several false starts I thought I had something with the following
>>>> (requires trimmed):
>>>>
>>>> ------
>>>> type bindadm_t;
>>>> role bindadm_r types { bindadm_t };
>>>> gen_user( bindadm_u, staff, bindadm_r, s0, s0 - s15:c0.c1023, c0.c1024
>>>> );
>>>>
>>>> semanage login -a -s bindadm_u -r bindadm_r waider
>>>> ------
>>>>
>>>> I began tracking the AVC violations that logging in with this account
>>>> caused, and got as far as being able to get a shell prompt with the
>>>> context bindadm_u:bindadm_r:user_t. At this point I tried getting
>>>> newrole -t bindadm_t to work, but couldn't get past the password check
>>>> requirement (allow bindadm_r chkpasswd_exec_t) since nothing I did
>>>> seemed to resolve the violation.
>>>>
>>>> At this point I am, as I said, stumped. I feel like I'm missing
>>>> something obvious, but after several weeks of reading I'm still no
>>>> closer to the answer. Perhaps someone could shed some light on this, or
>>>> perhaps point me at a suitable role/user-addition document?
>>> At present, I think you need to obtain and modify full policy sources
>>> (from the selinux-policy .src.rpm or the upstream refpolicy tar ball) to
>>> introduce completely new user roles - it is too pervasive of a change to
>>> easily do in a loadable module. Look at
>>> policy/modules/system/userdomain.te and policy/rolemap to see how
>>> current roles are defined.
>>>
>>> Chris (cc'd) has been working on a role infrastructure branch that will
>>> improve the situation, but that isn't mainstream yet afaik. 
>>>
>> And some tools to automate this process with is on my todo list for Madison.
>>
>> I'd like to see this in the FC7 time frame (or F7 I guess since Core is 
>> no more), but we are going to run out of time quickly. Chris - when are 
>> you planning to move the role infrastructure work to mainline? Will it 
>> allow the creation of modules that create new roles without full 
>> sources? That is, in my opinion, a requirement for useful deployment.
> 
> The backend has been merged for a while.  You should be able to do
> something like:
> 
> policy_module(binadm,1.0.0)
> 
> userdom_unpriv_user_template(myuser)
> gen_user(myuser_u,myuser,myuser_r,s0,s0 - mls_systemhigh,mcs_systemhigh)
> 

Great! Couple of questions / suggestions:

1) Can I do this with targeted? I'd like to start giving people a means 
of confining users on targeted.

2) What kind of customizations are available at this point. For example, 
I'd like to customize what applications a user can run (i.e., they can 
only log into an ssh terminal and use basic command line tools).

3) How would tool customizations work - I saw the info about the tags, 
but can you give me a broad overview of how you think this should work?

4) I'd really like to see a minimally confined user role for targeted. 
This would be a role / domain with very broad privileges that the user 
would run all applications in. It would _not_ have access to the trusted 
base (e.g., no access to the kernel image, kernel modules, the policy, 
etc.) so that it could not bypass the policy or effect the basic 
integrity of the system. Ideally, access could be moved into separate 
domains from that broad starting point as desired (e.g., removing 
networking access and run firefox in a confined domain).

Thanks - Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
