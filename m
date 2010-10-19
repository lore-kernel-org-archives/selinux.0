Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9JGcHLU003056
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2010 12:38:20 -0400
Received: from mail-pw0-f41.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9JGcI2L029643
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2010 16:38:18 GMT
Received: by pwi10 with SMTP id 10so540047pwi.0
        for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2010 09:38:17 -0700 (PDT)
Message-ID: <4CBDC997.6030800@gmail.com>
Date: Tue, 19 Oct 2010 09:38:47 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
References: <C8D3542D.BAC90%csellers@tresys.com>    <4CADF149.3040301@redhat.com> <4CAE025C.6010005@gmail.com>    <44256.193.5.216.100.1287499358.squirrel@mail.puzzle.ch>    <4CBDB14E.2030207@gmail.com> <12764.193.5.216.100.1287503226.squirrel@mail.puzzle.ch>
In-Reply-To: <12764.193.5.216.100.1287503226.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2010 08:47 AM, imsand@puzzle.ch wrote:
>> On 10/19/2010 07:42 AM, imsand@puzzle.ch wrote:
>>>> On 10/07/2010 09:11 AM, Daniel J Walsh wrote:
>>>>
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> On 10/07/2010 10:40 AM, Chad Sellers wrote:
>>>>>
>>>>>> On 10/6/10 3:29 AM, "imsand@puzzle.ch"<imsand@puzzle.ch>    wrote:
>>>>>>
>>>>>>
>>>>>>>> On 10/05/2010 11:43 PM, imsand@puzzle.ch wrote:
>>>>>>>>
>>>>>>>>>> On 10/05/2010 06:38 AM, imsand@puzzle.ch wrote:
>>>>>>>>>>
>>>>>>>>>>>> On 10/04/2010 11:30 PM, imsand@puzzle.ch wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>>> On 10/04/2010 01:03 AM, imsand@puzzle.ch wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hello
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm working on SUSE SLES11SP1 and encounter the following
>>>>>>>>>>>>>>> problem.
>>>>>>>>>>>>>>> Setting the context of the User after ssh login doesn't work
>>>>>>>>>>>>>>> if
>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>> SELinux Username and the Linux Username aren't identical.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --------------
>>>>>>>>>>>>>>> Here is an example (SElinux User=mat_u, Linux User=mat_u):
>>>>>>>>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]: Accepted
>>>>>>>>>>>>>>> keyboard-interactive/pam for mat_u from 131.102.233.125 port
>>>>>>>>>>>>>>> 54714
>>>>>>>>>>>>>>> ssh2
>>>>>>>>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> Open Session
>>>>>>>>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> Open Session
>>>>>>>>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> Username= mat_u SELinux User = user_u Level= (null)
>>>>>>>>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> set mat_u security context to user_u:user_r:user_t
>>>>>>>>>>>>>>> Oct  4 09:41:54 testsrv.example sshd[15829]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> set mat_u key creation context to user_u:user_r:user_t
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>> mat_u@testsrv.example:~>        id
>>>>>>>>>>>>>>> uid=6575(mat_u) gid=100(users)
>>>>>>>>>>>>>>> groups=16(dialout),33(video),100(users)
>>>>>>>>>>>>>>> context=mat_u:staff_r:staff_t
>>>>>>>>>>>>>>> mat_u@testsrv.example:~>        newrole -r sysadm_r
>>>>>>>>>>>>>>> mat_u@testsrv.example:~>        id
>>>>>>>>>>>>>>> uid=6575(mat_u) gid=100(users)
>>>>>>>>>>>>>>> groups=16(dialout),33(video),100(users)
>>>>>>>>>>>>>>> context=mat_u:sysadm_r:sysadm_t
>>>>>>>>>>>>>>> --------------------
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> So, this is okey. The user's context after login is
>>>>>>>>>>>>>>> "mat_u:staff_r:staff_t"
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> But, if the Linux User is different from the SELinux User,
>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>> default
>>>>>>>>>>>>>>> user's will be chosen instead.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Here is the example (SELinux User=mat_u, Linux User=mat):
>>>>>>>>>>>>>>> ---------------------
>>>>>>>>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]: Accepted
>>>>>>>>>>>>>>> keyboard-interactive/pam for mat from 131.102.233.125 port
>>>>>>>>>>>>>>> 54726
>>>>>>>>>>>>>>> ssh2
>>>>>>>>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> Open Session
>>>>>>>>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> Open Session
>>>>>>>>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> Username= mat SELinux User = mat_u Level= (null)
>>>>>>>>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> set mat security context to mat_u:staff_r:staff_t
>>>>>>>>>>>>>>> Oct  4 09:46:22 testsrv.example sshd[16185]:
>>>>>>>>>>>>>>> pam_selinux(sshd:session):
>>>>>>>>>>>>>>> set mat key creation context to mat_u:staff_r:staff_t
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>> mat_u@testsrv.example:~>        id
>>>>>>>>>>>>>>> uid=6575(mat) gid=100(users)
>>>>>>>>>>>>>>> groups=16(dialout),33(video),100(users)
>>>>>>>>>>>>>>> context=user_u:user_r:user_t
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> mat_u@testsrv.example:~>        newrole -r sysadm_r
>>>>>>>>>>>>>>> user_u:sysadm_r:sysadm_t is not a valid context
>>>>>>>>>>>>>>> ---------------------
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> As you can see, the pam_selinux module recognizes that the
>>>>>>>>>>>>>>> new
>>>>>>>>>>>>>>> context
>>>>>>>>>>>>>>> should be "mat_u:staff_r:staff_t", but for some reason the
>>>>>>>>>>>>>>> real
>>>>>>>>>>>>>>> context
>>>>>>>>>>>>>>> is
>>>>>>>>>>>>>>> user_u:user_r:user_t. Changing the context with newrole
>>>>>>>>>>>>>>> doesn't
>>>>>>>>>>>>>>> work
>>>>>>>>>>>>>>> either...
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The user mappings should be okey:
>>>>>>>>>>>>>>> ------
>>>>>>>>>>>>>>> semanage user -l | grep mat
>>>>>>>>>>>>>>> mat_u           staff_r sysadm_r
>>>>>>>>>>>>>>> testsrv.example:~ # semanage login -l | grep mat
>>>>>>>>>>>>>>> mat
>>>>>>>>>>>>>>> -------
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Any idea out there? Do I miss something?
>>>>>>>>>>>>>>> kind regards
>>>>>>>>>>>>>>> Matthias
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> This message was distributed to subscribers of the selinux
>>>>>>>>>>>>>>> mailing
>>>>>>>>>>>>>>> list.
>>>>>>>>>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>>>>>>>>>> majordomo@tycho.nsa.gov
>>>>>>>>>>>>>>> with
>>>>>>>>>>>>>>> the words "unsubscribe selinux" without quotes as the
>>>>>>>>>>>>>>> message.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> you can specify the context in
>>>>>>>>>>>>>> /etc/selinux/policy/contexts/users/whatroleyouused
>>>>>>>>>>>>>> (under sshd) I normally set user_r:user_t:s0
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Justin P. Mattock
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> This message was distributed to subscribers of the selinux
>>>>>>>>>>>>>> mailing
>>>>>>>>>>>>>> list.
>>>>>>>>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>>>>>>>>> majordomo@tycho.nsa.gov
>>>>>>>>>>>>>> with
>>>>>>>>>>>>>> the words "unsubscribe selinux" without quotes as the
>>>>>>>>>>>>>> message.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>> The file looks like:
>>>>>>>>>>>>> cat /etc/selinux/refpolicy/contexts/users/mat_u
>>>>>>>>>>>>> system_r:local_login_t  staff_r:staff_t sysadm_r:sysadm_t
>>>>>>>>>>>>> system_r:remote_login_t  staff_r:staff_t
>>>>>>>>>>>>> system_r:sshd_t   staff_r:staff_t sysadm_r:sysadm_t
>>>>>>>>>>>>> system_r:crond_t  staff_r:cronjob_t
>>>>>>>>>>>>> system_r:xdm_t   staff_r:staff_t
>>>>>>>>>>>>> staff_r:staff_su_t  staff_r:staff_t
>>>>>>>>>>>>> staff_r:staff_sudo_t  staff_r:staff_t
>>>>>>>>>>>>> sysadm_r:sysadm_su_t  sysadm_r:sysadm_t
>>>>>>>>>>>>> sysadm_r:sysadm_sudo_t  sysadm_r:sysadm_t
>>>>>>>>>>>>>
>>>>>>>>>>>>> So, theoretical this should be okey, isn't it?
>>>>>>>>>>>>> And as you can see in the log from above (set mat key creation
>>>>>>>>>>>>> context
>>>>>>>>>>>>> to
>>>>>>>>>>>>> mat_u:staff_r:staff_t) it "tries" to switch to staff but for
>>>>>>>>>>>>> some
>>>>>>>>>>>>> reason
>>>>>>>>>>>>> it doesn't work..
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>> if your sshd'ing and the context is staff_r:staff_t then it's
>>>>>>>>>>>> correct,
>>>>>>>>>>>> I
>>>>>>>>>>>> usually change this to user_r:user_t just cause I'm paranoid.
>>>>>>>>>>>> Also there is some options that you can set in /etc/pam.d to do
>>>>>>>>>>>> other
>>>>>>>>>>>> checks etc..
>>>>>>>>>>>>
>>>>>>>>>>>> Justin P. Mattock
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>> no it's not and that't the problem:)
>>>>>>>>>>> If I sshd'ing with mat_u it's always "user_r:user_t" even
>>>>>>>>>>> "staff_r:staff_t" is specified (see above). But it's correct if
>>>>>>>>>>> the
>>>>>>>>>>> selinux and linux users are named equaly (mat in the example).
>>>>>>>>>>> It seems that something with the context settings and
>>>>>>>>>>> usermapping
>>>>>>>>>>> isn't
>>>>>>>>>>> correct. Do you see the problem?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Somewhere in the policy it is set to default to user_r for sshd,
>>>>>>>>>> I
>>>>>>>>>> dont
>>>>>>>>>> think there is a boolean(but could be wrong)for that feature.
>>>>>>>>>> maybe
>>>>>>>>>> it's
>>>>>>>>>> reading the default_contexts file which is set to use
>>>>>>>>>> user_r:user_t
>>>>>>>>>> instead of reading mat_u for sshd(staff_r:staff_t)
>>>>>>>>>>
>>>>>>>>>> Justin P. Mattock
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>> Unfortunately I can't see a rule doing this. The curious thing is,
>>>>>>>>> that
>>>>>>>>> it
>>>>>>>>> works if the selinux user and the linux user are equivalent (both
>>>>>>>>> mat_u).
>>>>>>>>> But it does NOT work if it is mat (linux user) and mapped to mat_u
>>>>>>>>> (selinux user).
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> hmm.. something seems configured wrong, what OS are you using? do
>>>>>>>> you
>>>>>>>> have semanage login/user -l set up correctly?
>>>>>>>>
>>>>>>>> over here I build the policy from git, normally edit policy/users
>>>>>>>> (add)
>>>>>>>> gen_user(name,system_u, sysadm_r staff_r user_r, s0, s0 -
>>>>>>>> mls_systemhigh, mcs_allcats)
>>>>>>>>
>>>>>>>> then after the policy is built and installed/loaded I do
>>>>>>>> semanage login -a -s name name (create name in contexts/users)
>>>>>>>> (or skip the above and just use semanage -a -s user_u name)
>>>>>>>>
>>>>>>>> seems sshd works with the given context I specify(user_r) then if I
>>>>>>>> want
>>>>>>>> to add more options I adjust /etc/pam.d/*
>>>>>>>>
>>>>>>>> Justin P. Mattock
>>>>>>>>
>>>>>>>>
>>>>>>> Thanks for your reply.
>>>>>>> I'm using SLES 11 SP1. It wouldn't be the first bug regarding
>>>>>>> SELinux
>>>>>>> on
>>>>>>> this distro... ;)
>>>>>>> Here is what I've done so far.
>>>>>>> - Downloaded the latest reference policy from tresys
>>>>>>> - Compiled and installed it on my sles 11.1
>>>>>>> - Add selinux user mat_u: "semanage user -R "staff_r system_r" -P
>>>>>>> user
>>>>>>> -a
>>>>>>> mat_u"
>>>>>>> - Add linux user mat: "useradd mat"
>>>>>>> - Set password for mat: "passwd mat"
>>>>>>> - User mapping: "semanage login -s mat_u -a mat"
>>>>>>> - add security context for mat_u by copying staff_u's context
>>>>>>> "cp /etc/selinux/refpolicy/contexts/user/staff_u
>>>>>>> /etc/selinux/refpolicy/contexts/user/mat_u"
>>>>>>> - set boolean for sysadm ssh login to true: "setsebool -P
>>>>>>> ssh_sysadm_login
>>>>>>> on"
>>>>>>>
>>>>>>> Do you know good debug options for tracing where it stucks?
>>>>>>>
>>>>>>>
>>>>>> When debugging login-type programs figuring out the context to
>>>>>> transition
>>>>>> to, there are a couple of simple useful utilities in
>>>>>> libselinux/utils.
>>>>>> These
>>>>>> are getconlist and getdefaultcon. Most distros won't install these
>>>>>> (as
>>>>>> they're just debugging tools), but you can build them yourself out of
>>>>>> the
>>>>>> tree.
>>>>>>
>>>>>> getconlist will print out the contexts returned by
>>>>>> get_ordered_context_list(), which are all the reachable contexts.
>>>>>> This
>>>>>> could
>>>>>> tell you if the problem is that the context you're trying to
>>>>>> transition
>>>>>> to
>>>>>> is for some reason unreachable.
>>>>>>
>>>>>> getdefaultcon can tell you (in verbose mode) the default seuser and
>>>>>> level
>>>>>> returned by getseuserbyname() and the default context returned by
>>>>>> get_default_context_with_rolelevel()/get_default_context_with_level().
>>>>>> If
>>>>>> the seuser is wrong, then you know something's going wrong in
>>>>>> getseuserbyname().
>>>>>>
>>>>>> I hope that helps.
>>>>>>
>>>>>> Thanks,
>>>>>> Chad Sellers
>>>>>>
>>>>>>
>>>>>> --
>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>> list.
>>>>>> If you no longer wish to subscribe, send mail to
>>>>>> majordomo@tycho.nsa.gov with
>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>
>>>>>>
>>>>>>
>>>>> We ship them in fedora as selinuxconlist and selinuxdefcon
>>>>> -----BEGIN PGP SIGNATURE-----
>>>>> Version: GnuPG v1.4.10 (GNU/Linux)
>>>>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>>>>
>>>>> iEYEARECAAYFAkyt8UkACgkQrlYvE4MpobPw+wCfa8sf3A8+xhnMmdz2z3/vuJOM
>>>>> TYsAn1s18NmE9caf5MpCt312RO2Wh/BI
>>>>> =N+E/
>>>>> -----END PGP SIGNATURE-----
>>>>>
>>>>>
>>>>
>>>> o.k. I just loaded up OpenSUSE11.4, and loaded the policy(this is from
>>>> git keep in mind, not what suse offers).
>>>> after getting everything setup I was able to ssh into the machine with
>>>> my iphone, and issue id -Z.. the context I set is user_r:user_t which
>>>> the iphone showed(name:user_r:staff_t:s0) so everything is good with
>>>> this version.(not sure with 11.1, but I know 11.2 works fine, as well
>>>> as
>>>> 11.4).
>>>>
>>>> Justin P. Mattock
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing
>>>> list.
>>>> If you no longer wish to subscribe, send mail to
>>>> majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>
>>>>
>>> Thank you for your answers.
>>> I've reinstalled the sles11.1 with the newest opensuse selinux libraries
>>> (http://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/x86_64/),
>>> but it still struggles with the ssh login. Local login is working now!
>>> There must be a problem with pam_selinux. Here's the output of the debug
>>> log:
>>> Oct 19 16:40:50 testmachine.local sshd[7550]: pam_selinux(sshd:session):
>>> Open Session
>>> Oct 19 16:40:50 testmachine.local sshd[7550]: pam_selinux(sshd:session):
>>> Username= mat SELinux User = mat_u Level= (null)
>>> Oct 19 16:40:50 testmachine.local sshd[7550]: pam_selinux(sshd:session):
>>> set mat security context to mat_u:staff_r:insmod_t
>>> Oct 19 16:40:50 testmachine.local sshd[7550]: pam_selinux(sshd:session):
>>> set mat key creation context to mat_u:staff_r:insmod_t
>>> Oct 19 16:40:50 testmachine.local sshd[7557]: pam_unix2(sshd:setcred):
>>> pam_sm_setcred() called
>>> Oct 19 16:40:50 testmachine.local sshd[7557]: pam_unix2(sshd:setcred):
>>> username=[mat]
>>> Oct 19 16:40:50 testmachine.local sshd[7557]: pam_unix2(sshd:setcred):
>>> pam_sm_setcred: PAM_SUCCESS
>>> Oct 19 16:40:50 testmachine.local sshd[7557]: fatal:
>>> ssh_selinux_getctxbyname: Failed to get default SELinux security context
>>> for mat (in enforcing mode)
>>> Oct 19 16:40:50 testmachine.local sshd[7550]: pam_selinux(sshd:session):
>>> Close Session
>>>
>>> @justin: which policy did you installed from git? url? I tried refpolicy
>>> from tresys.
>>>
>>>
>>>
>>>
>>
>>
>> from what I remember insmod_t is a context I always received, due to
>> unlabeled filesystem
>> i.e. I also use LFS, and will tar ball the whole system, and copy it
>> over to the new machine,
>> then receive the insmod_t until I relabel, then all is good, but in your
>> case it shouldn't be going to that.
>>
>>
>> as for the policy(sounds like the same one)..:
>>
>> git clone http://oss.tresys.com/git/refpolicy.git
>>
>> in regards to sles11 im wondering if it's close to opensuse 11.1, if so
>> I can
>> load that one up on my machine to see whats happening(right now I'm kind
>> of floating
>> from one distro to the next(I have the "try that out distro itch"..))
>>
>> Justin P. Mattock
>>
>>
>
> I don't think that opensuse 11.1 and sles 11.1 are close enough!?
> I found out that if the selinux user and the linux user are equal (both
> mat_u), the ssh login works as well.
>
> indeed insmod was gone after "make relabel", but now I can't start the
> system in enforcing mode anymore, because a couple of denies =>
> most of them are related to dbus and rpc-statd:
> ----
> avc:  denied  { search } for  pid=2320 comm="dbus-daemon" nam
> e="dbus" dev=dm-7 ino=40172 scontext=system_u:system_r:sysadm_dbusd_t
> tcontext=system_u:object_r:system_dbusd_var_run_t tclass=dir
> ----
> ----
> avc:  denied  { read } for  pid=3127 comm="rpc.statd" path="p
> ipe:[9740]" dev=pipefs ino=9740 scontext=system_u:system_r:mount_t
> tcontext=system_u:system_r:mount_t tclass=fifo_file
> ----
> are you familiar with that? are there some booleans to set or do I have to
> adjust the policy?
>
>
>
>

from what I remember opensuse 11.2 had issues starting due too 
/etc/selinux/config having the wrong permissions(should be -rw-r--r--.)

has issues with /etc/initscript causing SELinux to not transition(thread 
here)..:
http://oss.tresys.com/pipermail/refpolicy/2010-February/002012.html

for some reason sysvinit craps out with:
if (access(INITSCRIPT, R_OK) == 0 && runlevel != 'S') {

I played around with sysvinit, but my code skills only took me so far:
http://www.spinics.net/lists/selinux/msg08983.html

two solutions to this is too mv /etc/initscript{,-bak} or
setsebool -P init_upstart on
this way you transistion properly and you wont receive a dbus error(if 
this is whats happening with sles11.1)

thirdly login context gets the wrong role.. simple fix is on this
report:
https://bugzilla.novell.com/show_bug.cgi?id=582366

here are the bug reports that got fixed so opensuse 11.2 is able to get 
up and running in full enforcement mode.

https://bugzilla.novell.com/show_bug.cgi?id=581505
https://bugzilla.novell.com/show_bug.cgi?id=582399
https://bugzilla.novell.com/show_bug.cgi?id=582404

hopefully these are similar to what you're hitting...this way you can 
get up and running properly...

Justin P. Mattock



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
