Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA26333
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 18:52:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA01889
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 23:51:39 GMT
Received: from sendmail (savages.net [208.170.193.18] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id XAA01885
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 23:51:38 GMT
Message-ID: <3C44BD78.4090205@pcez.com>
Date: Tue, 15 Jan 2002 15:38:32 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>, selinux@tycho.nsa.gov
Subject: Re: General Users
References: <72222DC86846D411ABD300A0C9EB08A10152428B@csoc-mail-box.csoconline.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Westerman, Mark wrote:

To sum it up you want dynamic user add or daily policy update.

here is a kluge idea:
create a new push/pull program to down load the policy daily, using what 
ever security you need.
create a policy to allow this program to load the new policy.  here 
again you define the security needed.
create a script to generate the "user" file and make the new policy 
ready to send

now the get_user_sids would work in getting the default context/sid

The problem here is this push/pull program would need to be protected. 
 by selinux policy and encryption.  

The better way would be to allow dynamic user add.  When a user logins 
in, the nis information sent back to the client has a selinux group. 
this selinux group allows a user different user rights but the policy 
lookup is dependent on the group and user.  group_sid + dymanic_user = sid

user_group:user_r:user_t  where user is the user name and group is the 
group name.

user = zot and group = student
zot_student:user_r:user_t
thr group 'student' is defined in the  policy.
 
This would require new syscalls,  sid= new_user(name, group, context), 
and del_user(sid)  

Shaun
 

>I am not worried about user Profile Management or any type 
>of group management.
>
>The issues is the actual SELinux policy management.
>When you create the policy from the policy
>rules the binary file is store in /ss_policy. To add a 
>user to the system now you must:
>	1. Add the user to the system
>	2. Add the user to the file SELinux/policy/users
>		user xxxx roles { user_r };
>	3. Rebuild the policy file.
>		make install
>	4. Load the new policy into the kernel or reboot.
>		load_policy /ss_policy
>	5. Add the user to the /etc/security/default_context
>	6. Add the user to the /etc/security/cron_context
>
>
>Some of the problems I will have with this type of implementation is
>	1. I do not believe that the load_policy will be allowed on the 
>         general workstation (security reasons) . That leaves only reboot. 
>	2. Rebuild the policy file for hundred workstation is not a feasible
>
>	   implementation. 
>	3. The policy files will the same for each workstations so a push of
>         the policy files is ok. (this will be performed via encryption)
>	4. As stated early password will be distributed via NIS (legacy
>reasons
>         not an option to change).
>
>Any more Ideas or suggestions would be greatly appreciated
>
>Mark Westerman
>
>--
>You have received this message because you are subscribed to the selinux list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
