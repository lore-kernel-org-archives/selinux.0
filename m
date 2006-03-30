Message-ID: <442B5714.9080100@kaigai.gr.jp>
Date: Thu, 30 Mar 2006 12:57:08 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: sds@tycho.nsa.gov, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Russell Coker <russell@coker.com.au>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: MCS and unconfined_t
References: <442933AD.3040208@kaigai.gr.jp>	 <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>	 <1143649773.13732.30.camel@sgc.columbia.tresys.com>	 <1143650740.24555.5.camel@moss-spartans.epoch.ncsc.mil> <1143655164.13732.36.camel@sgc.columbia.tresys.com>
In-Reply-To: <1143655164.13732.36.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-03-29 at 11:45 -0500, Stephen Smalley wrote:
>> On Wed, 2006-03-29 at 11:29 -0500, Christopher J. PeBenito wrote:
>>> My issue with that patch was that it had types hardcoded into the
>>> constraints, violating encapsulation.  In the interim other parts of the
>>> patch were fixed and resubmitted, but this piece got lost along the way.
>>> I've committed it, using an attribute and an interface.
>> Ok, but it seems like something still isn't quite conceptually here in
>> MCS - pam_selinux was removed from su, so su isn't supposed to switch
>> levels, yet running su on FC5 does change to a fully ranged context,
>> presumably via range_transition.  Which makes no sense to me at all
>> given the intent of MCS.
> 
> Agreed.  My guess is that it is left over from when su did have
> pam_selinux.  It probably should be removed.

Does 'that patch' mean what Russell posted on 03/Feb, doesn't it?
I think there is another issue other than violating encapsulation.

+mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
+		( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t ) or
+		( t1 == kernel_t ));

It says an process can transit to more restricted categories only
by (h1 dom h2). I felt it's over restriction.
For example, a user login with 's0' cannot transit to any wider range
categories, even if he would be allowed to belong 's0-s0:c0.c2' at most.

I modified my desktop environment (FC5). At a moment, the following
configuration seems to me working fine.
Do you think it's a reasonable solution ?

1. remove range_transition for su/sudo
 'range_transition unconfined_t su_exec_t s0 - s0:c0.c255;'
 is not necessary for su, I also think.

2. add a constraint for changing user
 'constrain process { transition } (u1 == system_u) or (u1 == u2);'
 is necessary to restrict unbounded transition between categories.
 system_u is an exception because logind/sshd need to change user name.
 (It should be replaced by macros from the refpolicy sight.)

3. associate root with system_u
 Because transition from root to system_u is denied by constrain (2),
 starting or restarting any services by hand is impossible.
 Threfore, I associate root with same user for any daemons.

Thanks,

-------------------------------------------
[root@saba ~]# semanage login -l
Login Name        SELinux User       MLS/MCS Range
__default__       user_u             s0
root              system_u           God
tak               officer            Executive
ymj               officer            President

[root@saba ~]# semanage user -l
                MLS/       MLS/
SELinux User    MCS Level  MCS Range          SELinux Roles
officer         s0         President          system_r
root            s0         God                sysadm_r user_r system_r
system_u        s0         God                system_r
user_u          s0         God                sysadm_r user_r system_r

[root@saba ~]# semanage translation -l
Level                     Translation
s0
s0-s0:c0                  Manager
s0-s0:c0,c1               Executive
s0-s0:c0.c2               President
s0-s0:c0.c255             God
s0:c0                     Confidential
s0:c0.c1                  Secret
s0:c0.c2                  TopSecret


[tak@saba ~]$ id -Z
officer:system_r:unconfined_t:Executive
[tak@saba ~]$ runcon -u user_u /bin/bash
execvp: Permission denied
[tak@saba ~]$ runcon -l President /bin/bash
[tak@saba ~]$ id -Z
officer:system_r:unconfined_t:President
[tak@saba ~]$ runcon -l God /bin/bash
officer:system_r:unconfined_t:God is not a valid context

--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
