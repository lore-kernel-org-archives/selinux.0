Message-ID: <459E74FE.9020508@mentalrootkit.com>
Date: Fri, 05 Jan 2007 10:55:42 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ronan Waide <waider@amazon.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: creating a new role/user to administer a service
References: <1167908139.19878.12.camel@waider.desktop.amazon.com> <1168010769.18961.147.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168010769.18961.147.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-01-04 at 10:55 +0000, Ronan Waide wrote:
>> Hi,
>>
>> I've been digging through SELinux by example, the list archives, Dan
>> Walsh's livejournal, and the Fedora strict policy source, but I'm still
>> a bit stumped on how to get this working:
>>
>> I'd like to create an administrative role/user for BIND. specifically, I
>> do not, if possible, want to use something like sysadm_r; I would rather
>> that otherwise unprivileged users are either designated as bindadm_u
>> from login, or newrole into bindadm_r in order to manage the daemon. The
>> former is preferable, as I was hoping to make use of ssh keys to enable
>> remote management without multiple password entry.
>>
>> After several false starts I thought I had something with the following
>> (requires trimmed):
>>
>> ------
>> type bindadm_t;
>> role bindadm_r types { bindadm_t };
>> gen_user( bindadm_u, staff, bindadm_r, s0, s0 - s15:c0.c1023, c0.c1024
>> );
>>
>> semanage login -a -s bindadm_u -r bindadm_r waider
>> ------
>>
>> I began tracking the AVC violations that logging in with this account
>> caused, and got as far as being able to get a shell prompt with the
>> context bindadm_u:bindadm_r:user_t. At this point I tried getting
>> newrole -t bindadm_t to work, but couldn't get past the password check
>> requirement (allow bindadm_r chkpasswd_exec_t) since nothing I did
>> seemed to resolve the violation.
>>
>> At this point I am, as I said, stumped. I feel like I'm missing
>> something obvious, but after several weeks of reading I'm still no
>> closer to the answer. Perhaps someone could shed some light on this, or
>> perhaps point me at a suitable role/user-addition document?
> 
> At present, I think you need to obtain and modify full policy sources
> (from the selinux-policy .src.rpm or the upstream refpolicy tar ball) to
> introduce completely new user roles - it is too pervasive of a change to
> easily do in a loadable module. Look at
> policy/modules/system/userdomain.te and policy/rolemap to see how
> current roles are defined.
> 
> Chris (cc'd) has been working on a role infrastructure branch that will
> improve the situation, but that isn't mainstream yet afaik. 
> 

And some tools to automate this process with is on my todo list for Madison.

I'd like to see this in the FC7 time frame (or F7 I guess since Core is 
no more), but we are going to run out of time quickly. Chris - when are 
you planning to move the role infrastructure work to mainline? Will it 
allow the creation of modules that create new roles without full 
sources? That is, in my opinion, a requirement for useful deployment.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
