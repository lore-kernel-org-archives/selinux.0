Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o967Tgi6001773
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2010 03:29:43 -0400
Received: from yukon.worldweb2000.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o967TfCp026550
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2010 07:29:41 GMT
Message-ID: <15078.193.5.216.100.1286350177.squirrel@mail.puzzle.ch>
In-Reply-To: <4CAC1FEF.4070308@gmail.com>
References: <30011.193.5.216.100.1286179426.squirrel@mail.puzzle.ch>
    <4CAA0B2F.7020204@gmail.com>
    <18215.193.5.216.100.1286260221.squirrel@mail.puzzle.ch>
    <4CAB282F.6070908@gmail.com>
    <50990.193.5.216.100.1286285921.squirrel@mail.puzzle.ch>
    <4CAB3651.7060507@gmail.com>
    <44505.193.5.216.100.1286347409.squirrel@mail.puzzle.ch>
    <4CAC1FEF.4070308@gmail.com>
Date: Wed, 6 Oct 2010 09:29:37 +0200 (CEST)
Subject: Re: Context settings after ssh login
From: imsand@puzzle.ch
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: imsand@puzzle.ch, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On 10/05/2010 11:43 PM, imsand@puzzle.ch wrote:
>>> On 10/05/2010 06:38 AM, imsand@puzzle.ch wrote:
>>>>> On 10/04/2010 11:30 PM, imsand@puzzle.ch wrote:
>>>>>>> On 10/04/2010 01:03 AM, imsand@puzzle.ch wrote:
>>>>>>>> Hello
>>>>>>>>
>>>>>>>> I'm working on SUSE SLES11SP1 and encounter the following problem.
>>>>>>>> Setting the context of the User after ssh login doesn't work if
>>>>>>>> the
>>>>>>>> SELinux Username and the Linux Username aren't identical.
>>>>>>>>
>>>>>>>> --------------
>>>>>>>> Here is an example (SElinux User=mat_u, Linux User=mat_u):
>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]: Accepted
>>>>>>>> keyboard-interactive/pam for mat_u from 131.102.233.125 port 54714
>>>>>>>> ssh2
>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> Open Session
>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> Open Session
>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> Username= mat_u SELinux User = user_u Level= (null)
>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> set mat_u security context to user_u:user_r:user_t
>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> set mat_u key creation context to user_u:user_r:user_t
>>>>>>>> ---
>>>>>>>> mat_u@testsrv.example:~>     id
>>>>>>>> uid=6575(mat_u) gid=100(users)
>>>>>>>> groups=16(dialout),33(video),100(users)
>>>>>>>> context=mat_u:staff_r:staff_t
>>>>>>>> mat_u@testsrv.example:~>     newrole -r sysadm_r
>>>>>>>> mat_u@testsrv.example:~>     id
>>>>>>>> uid=6575(mat_u) gid=100(users)
>>>>>>>> groups=16(dialout),33(video),100(users)
>>>>>>>> context=mat_u:sysadm_r:sysadm_t
>>>>>>>> --------------------
>>>>>>>>
>>>>>>>> So, this is okey. The user's context after login is
>>>>>>>> "mat_u:staff_r:staff_t"
>>>>>>>>
>>>>>>>> But, if the Linux User is different from the SELinux User, the
>>>>>>>> default
>>>>>>>> user's will be chosen instead.
>>>>>>>>
>>>>>>>> Here is the example (SELinux User=mat_u, Linux User=mat):
>>>>>>>> ---------------------
>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]: Accepted
>>>>>>>> keyboard-interactive/pam for mat from 131.102.233.125 port 54726
>>>>>>>> ssh2
>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> Open Session
>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> Open Session
>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> Username= mat SELinux User = mat_u Level= (null)
>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> set mat security context to mat_u:staff_r:staff_t
>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>> pam_selinux(sshd:session):
>>>>>>>> set mat key creation context to mat_u:staff_r:staff_t
>>>>>>>> ---
>>>>>>>> mat_u@testsrv.example:~>     id
>>>>>>>> uid=6575(mat) gid=100(users)
>>>>>>>> groups=16(dialout),33(video),100(users)
>>>>>>>> context=user_u:user_r:user_t
>>>>>>>>
>>>>>>>> mat_u@testsrv.example:~>     newrole -r sysadm_r
>>>>>>>> user_u:sysadm_r:sysadm_t is not a valid context
>>>>>>>> ---------------------
>>>>>>>>
>>>>>>>> As you can see, the pam_selinux module recognizes that the new
>>>>>>>> context
>>>>>>>> should be "mat_u:staff_r:staff_t", but for some reason the real
>>>>>>>> context
>>>>>>>> is
>>>>>>>> user_u:user_r:user_t. Changing the context with newrole doesn't
>>>>>>>> work
>>>>>>>> either...
>>>>>>>>
>>>>>>>> The user mappings should be okey:
>>>>>>>> ------
>>>>>>>> semanage user -l | grep mat
>>>>>>>> mat_u           staff_r sysadm_r
>>>>>>>> testsrv.example:~ # semanage login -l | grep mat
>>>>>>>> mat
>>>>>>>> -------
>>>>>>>>
>>>>>>>> Any idea out there? Do I miss something?
>>>>>>>> kind regards
>>>>>>>> Matthias
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>>>> list.
>>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>>> majordomo@tycho.nsa.gov
>>>>>>>> with
>>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>>
>>>>>>>
>>>>>>> you can specify the context in
>>>>>>> /etc/selinux/policy/contexts/users/whatroleyouused
>>>>>>> (under sshd) I normally set user_r:user_t:s0
>>>>>>>
>>>>>>>
>>>>>>> Justin P. Mattock
>>>>>>>
>>>>>>> --
>>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>>> list.
>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>> majordomo@tycho.nsa.gov
>>>>>>> with
>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>
>>>>>>
>>>>>> The file looks like:
>>>>>> cat /etc/selinux/refpolicy/contexts/users/mat_u
>>>>>> system_r:local_login_t		staff_r:staff_t sysadm_r:sysadm_t
>>>>>> system_r:remote_login_t		staff_r:staff_t
>>>>>> system_r:sshd_t			staff_r:staff_t sysadm_r:sysadm_t
>>>>>> system_r:crond_t		staff_r:cronjob_t
>>>>>> system_r:xdm_t			staff_r:staff_t
>>>>>> staff_r:staff_su_t		staff_r:staff_t
>>>>>> staff_r:staff_sudo_t		staff_r:staff_t
>>>>>> sysadm_r:sysadm_su_t		sysadm_r:sysadm_t
>>>>>> sysadm_r:sysadm_sudo_t		sysadm_r:sysadm_t
>>>>>>
>>>>>> So, theoretical this should be okey, isn't it?
>>>>>> And as you can see in the log from above (set mat key creation
>>>>>> context
>>>>>> to
>>>>>> mat_u:staff_r:staff_t) it "tries" to switch to staff but for some
>>>>>> reason
>>>>>> it doesn't work..
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> if your sshd'ing and the context is staff_r:staff_t then it's
>>>>> correct,
>>>>> I
>>>>> usually change this to user_r:user_t just cause I'm paranoid.
>>>>> Also there is some options that you can set in /etc/pam.d to do other
>>>>> checks etc..
>>>>>
>>>>> Justin P. Mattock
>>>>>
>>>> no it's not and that't the problem:)
>>>> If I sshd'ing with mat_u it's always "user_r:user_t" even
>>>> "staff_r:staff_t" is specified (see above). But it's correct if the
>>>> selinux and linux users are named equaly (mat in the example).
>>>> It seems that something with the context settings and usermapping
>>>> isn't
>>>> correct. Do you see the problem?
>>>>
>>>>
>>>
>>>
>>> Somewhere in the policy it is set to default to user_r for sshd, I dont
>>> think there is a boolean(but could be wrong)for that feature. maybe
>>> it's
>>> reading the default_contexts file which is set to use user_r:user_t
>>> instead of reading mat_u for sshd(staff_r:staff_t)
>>>
>>> Justin P. Mattock
>>>
>>>
>> Unfortunately I can't see a rule doing this. The curious thing is, that
>> it
>> works if the selinux user and the linux user are equivalent (both
>> mat_u).
>> But it does NOT work if it is mat (linux user) and mapped to mat_u
>> (selinux user).
>>
>>
>
>
> hmm.. something seems configured wrong, what OS are you using? do you
> have semanage login/user -l set up correctly?
>
> over here I build the policy from git, normally edit policy/users (add)
> gen_user(name,system_u, sysadm_r staff_r user_r, s0, s0 -
> mls_systemhigh, mcs_allcats)
>
> then after the policy is built and installed/loaded I do
> semanage login -a -s name name (create name in contexts/users)
> (or skip the above and just use semanage -a -s user_u name)
>
> seems sshd works with the given context I specify(user_r) then if I want
> to add more options I adjust /etc/pam.d/*
>
> Justin P. Mattock
>
Thanks for your reply.
I'm using SLES 11 SP1. It wouldn't be the first bug regarding SELinux on
this distro... ;)
Here is what I've done so far.
- Downloaded the latest reference policy from tresys
- Compiled and installed it on my sles 11.1
- Add selinux user mat_u: "semanage user -R "staff_r system_r" -P user -a
mat_u"
- Add linux user mat: "useradd mat"
- Set password for mat: "passwd mat"
- User mapping: "semanage login -s mat_u -a mat"
- add security context for mat_u by copying staff_u's context
"cp /etc/selinux/refpolicy/contexts/user/staff_u
/etc/selinux/refpolicy/contexts/user/mat_u"
- set boolean for sysadm ssh login to true: "setsebool -P ssh_sysadm_login
on"

Do you know good debug options for tracing where it stucks?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
