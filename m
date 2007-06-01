Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l51FvToq018656
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2007 11:57:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l51FvScC027104
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2007 15:57:28 GMT
Message-ID: <466041E3.6080705@redhat.com>
Date: Fri, 01 Jun 2007 11:57:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: With the release of Fedora Core 7 I have bumped the policy	version
 in Rawhide
References: <465F19D1.7040706@redhat.com> <1180710064.28862.5.camel@sgc.columbia.tresys.com>
In-Reply-To: <1180710064.28862.5.camel@sgc.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------000809030705070508050100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000809030705070508050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Thu, 2007-05-31 at 14:54 -0400, Daniel J Walsh wrote:
>   
>> Tomorrows rawhide will have selinux-policy-3.0.1. 
>>
>> This policy is the first release of the merged (strict/targeted) 
>> policy.  As such there is no longer a selinux-policy-strict.  This is 
>> real experimental and I expect some problems.  I have been running it 
>> here for a couple of days. 
>>
>> With this policy you can install the strict type users staff_u, user_u, 
>> sysadm_u.  As well as the unonfined_u/system_u.  You should be able to 
>> mix and match the users.  So if you want to setup a Guest X-Windows 
>> login you would set it up with a user of user_u:user_r:user_t.  And you 
>> might have your regular login as system_u:unconfined_r:unconfined_t.
>>     
>
> As a side note is that an unconfined_u seuser is going to be added,
> which will be the appropriate seuser to use for unconfined users.  So
> eventually you'll end up with unconfined_u:unconfined_r:unconfined_t.
>
>   

>> The idea is if you remove the unconfined policy package, you will be 
>> basically running in strict policy mode.  (This has not been tested.) 
>>     
>
> Actually you also have to take out anaconda and firstboot since they
> unconditionally depend on unconfined.  Otherwise it should work.
>
>   
Well in the process of making unconfined.te a module, I found lots of 
other gotcha's but
I will send you later.

I am holding off on updating until I get some more testing.  I want this 
change to go smoothly, and not force a relabel.  Since eventually we 
will be updating from F-7 to F-8 and RHEL5-RHEL6.


Looking into doing something like this in the post.

Currently __default__ logs in as user_u, which has much less privs then 
unconfined_t.  And I still the default to be unconfined_t.  So changing 
the user to system_u achieves this.

I can't put unconfined_u into the users build, since this blows up with 
unconfined as a loadable module.

%triggerpost targeted -- selinux-policy-targeted <= 3.0.1
semanage login -m -s system_u __default__
semanage login -m -s system_u root
semanage user -m -P sysadm -R "staff_r sysadm_r system_r" root
semanage user -m -P user -R user_r user_u
semanage user -a -P staff -R "staff_r sysadm_r" staff_u

Also adding (attachments)
/etc/selinux/targeted/contexts/users/user_u
/etc/selinux/targeted/contexts/users/staff_u

These probably need to be reviewed.

So that we can get the default_contexts stuff right.



--------------000809030705070508050100
Content-Type: text/plain;
 name="staff_u"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="staff_u"

system_r:local_login_t:s0	staff_r:staff_t:s0 sysadm_r:sysadm_t:s0
system_r:remote_login_t:s0	staff_r:staff_t:s0
system_r:sshd_t:s0		staff_r:staff_t:s0 sysadm_r:sysadm_t:s0
system_r:crond_t:s0		staff_r:staff_crond_t:s0 sysadm_r:sysadm_crond_t:s0 system_r:system_crond_t:s0 mailman_r:user_crond_t:s0
system_r:xdm_t:s0		staff_r:staff_t:s0
staff_r:staff_su_t:s0		staff_r:staff_t:s0
staff_r:staff_sudo_t:s0		staff_r:staff_t:s0
sysadm_r:sysadm_su_t:s0		sysadm_r:sysadm_t:s0 
sysadm_r:sysadm_sudo_t:s0	sysadm_r:sysadm_t:s0

--------------000809030705070508050100
Content-Type: text/plain;
 name="user_u"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="user_u"

system_r:local_login_t:s0	user_r:user_t:s0
system_r:remote_login_t:s0	user_r:user_t:s0
system_r:sshd_t:s0		user_r:user_t:s0
system_r:crond_t:s0		user_r:user_crond_t:s0
system_r:xdm_t:s0		user_r:user_t:s0
user_r:user_su_t:s0		user_r:user_t:s0
user_r:user_sudo_t:s0		user_r:user_t:s0

--------------000809030705070508050100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
