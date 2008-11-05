Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA5HqS4G005737
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 12:52:28 -0500
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA5HqSeQ027218
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 17:52:28 GMT
Received: from 78-3-234-122.adsl.net.t-com.hr ([78.3.234.122] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1KxmYF-0007tz-BH
	for selinux@tycho.nsa.gov; Wed, 05 Nov 2008 09:52:21 -0800
Message-ID: <4911DD4F.9050304@rubix.com>
Date: Wed, 05 Nov 2008 18:52:15 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: using roles with mls policy
References: <4911BCB9.1060407@rubix.com> <dd18b0c30811050818j42da8ae3q8c1f95450ed6c926@mail.gmail.com>
In-Reply-To: <dd18b0c30811050818j42da8ae3q8c1f95450ed6c926@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------070109050904000603010703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070109050904000603010703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Justin Mattock wrote:
> On Wed, Nov 5, 2008 at 7:33 AM, Andy Warner <warner@rubix.com> wrote:
>   
>> I am using Fedora 9 with the MLS policy. I have been using it in permissive
>> mode for a while (integrating SELinux with a DBMS and its objects) and now
>> must do some work/testing in enforcing mode. As soon as I switch to
>> enforcing mode I seem unable to perform any action which requires privilege.
>>
>> What is the anticipated method to shutdown/reboot the system and to toggle
>> the enforcing mode while in MLS/Enforcing? What I assumed was to transition
>> to an appropriate role (sysadm_r and secadm_r respectively) and then issue
>> the corresponding command (shutdown and setenforce). This fails and I
>> believe my difficulty is that in both cases I need to also be the linux root
>> user. There does not seem to be an obvious way to execute a command as the
>> lunux root user as neither su nor sudo seem available while in the sysadm_r
>> and secadm_r roles. Executing something like seaudit while in the auditadm_r
>> role fails to allow me to authenticate as root. Despite being the correct
>> password it continuously loops asking for the password.
>>
>> As a related but less important question, in general, is it intended that a
>> user initially have the staff_r role upon login and then transition to a
>> more trusted role (i.e., secadm_r) using the newrole command? (as opposed to
>> having the secadm_r upon login.
>>
>> Thanks for any help,
>>
>> Andy
>>
>>
>>
>>     
>
> Not sure how red hat works,
> but for me using ubuntu having to change roles
> I first needed to collect all of the allow rules, i.g.
> allow newrole_t staff_t:process  etc...
> then after after a reboot into enforce mode
> using newrole -r works fine.(just haven't defined secadm_r yet).
> As for toggling from enforce to permissive
> using setenforce 0 or 1
> or echo 0/1 > /selinux/enforce.
>
>
>   
I have no problem changing to a role while in enforcing mode, the 
problem is in performing the command. Here is what is happening (the 
following was executed while in enforcing mode):

[staff@oak ~]$ id -Z
staff_u:staff_r:staff_t:SystemLow:SystemLow-SystemHigh
[staff@oak ~]$ newrole -r secadm_r
Password:
[staff@oak ~]$ id -Z
staff_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh
[staff@oak ~]$ ls -l /selinux/enforce
-rw-r--r-- 1 root root 0 2008-11-05 17:08 /selinux/enforce
[staff@oak ~]$ /usr/sbin/setenforce 1
/usr/sbin/setenforce:  setenforce() failed
[staff@oak ~]$ sudo /usr/sbin/setenforce 1
sudo: setresuid(ROOT_UID, 1, ROOT_UID): Operation not permitted
[staff@oak ~]$ id
uid=503(staff) gid=500(user) groups=500(user)
context=staff_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh
[staff@oak ~]$

As can be seen I can transition to the secadm_r without an issue. And, 
from the DAC modes of /selinux/enforce I would guess it requires linux 
root to be written. Also, I thought I read elsewhere that the secadm_r 
was configured so that it could not perform an su/sudo. Likewise, if I 
try to execute system-config-selinux as the secadm_r role, I am not 
permitted to authenticate as linux root user so I am not able to do 
anything. If selinux is in permissive mode everything works, as long as 
I su/sudo to root first. I have similar issues with the auditadm_r role.

As for my previously mentioned issue with using sysadm_r to issue a 
shutdown command while in enforcing mode, I was mistaken and this is 
possible using sudo (not sure what I was thinking). It seems no MLS 
roles can use su, only staff_r and sysadm_r may use sudo. auditadm_r and 
secadm_r cannot use either and seem powerless without it. I am also 
unable to directly log in as root when in enforcing mode.

Note that I am using the roles as they are configured in the MLS policy. 
If it is required to change or configure the roles to make them able do 
what it seems like they should be able to do, thats ok, but first I need 
to make sure I'm not just being boneheaded and using them in the wrong 
way or have bad expectations of what they should be able to do.

--------------070109050904000603010703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Justin Mattock wrote:
<blockquote
 cite="mid:dd18b0c30811050818j42da8ae3q8c1f95450ed6c926@mail.gmail.com"
 type="cite">
  <pre wrap="">On Wed, Nov 5, 2008 at 7:33 AM, Andy Warner <a class="moz-txt-link-rfc2396E" href="mailto:warner@rubix.com">&lt;warner@rubix.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am using Fedora 9 with the MLS policy. I have been using it in permissive
mode for a while (integrating SELinux with a DBMS and its objects) and now
must do some work/testing in enforcing mode. As soon as I switch to
enforcing mode I seem unable to perform any action which requires privilege.

What is the anticipated method to shutdown/reboot the system and to toggle
the enforcing mode while in MLS/Enforcing? What I assumed was to transition
to an appropriate role (sysadm_r and secadm_r respectively) and then issue
the corresponding command (shutdown and setenforce). This fails and I
believe my difficulty is that in both cases I need to also be the linux root
user. There does not seem to be an obvious way to execute a command as the
lunux root user as neither su nor sudo seem available while in the sysadm_r
and secadm_r roles. Executing something like seaudit while in the auditadm_r
role fails to allow me to authenticate as root. Despite being the correct
password it continuously loops asking for the password.

As a related but less important question, in general, is it intended that a
user initially have the staff_r role upon login and then transition to a
more trusted role (i.e., secadm_r) using the newrole command? (as opposed to
having the secadm_r upon login.

Thanks for any help,

Andy



    </pre>
  </blockquote>
  <pre wrap=""><!---->
Not sure how red hat works,
but for me using ubuntu having to change roles
I first needed to collect all of the allow rules, i.g.
allow newrole_t staff_t:process  etc...
then after after a reboot into enforce mode
using newrole -r works fine.(just haven't defined secadm_r yet).
As for toggling from enforce to permissive
using setenforce 0 or 1
or echo 0/1 &gt; /selinux/enforce.


  </pre>
</blockquote>
I have no problem changing to a role while in enforcing mode, the
problem is in performing the command. Here is what is happening (the
following was executed while in enforcing mode):<br>
<br>
[staff@oak ~]$ id -Z<br>
staff_u:staff_r:staff_t:SystemLow:SystemLow-SystemHigh<br>
[staff@oak ~]$ newrole -r secadm_r<br>
Password:<br>
[staff@oak ~]$ id -Z<br>
staff_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh<br>
[staff@oak ~]$ ls -l /selinux/enforce<br>
-rw-r--r-- 1 root root 0 2008-11-05 17:08 /selinux/enforce<br>
[staff@oak ~]$ /usr/sbin/setenforce 1<br>
/usr/sbin/setenforce:&nbsp; setenforce() failed<br>
[staff@oak ~]$ sudo /usr/sbin/setenforce 1<br>
sudo: setresuid(ROOT_UID, 1, ROOT_UID): Operation not permitted<br>
[staff@oak ~]$ id<br>
uid=503(staff) gid=500(user) groups=500(user)<br>
context=staff_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh<br>
[staff@oak ~]$<br>
<br>
As can be seen I can transition to the secadm_r without an issue. And,
from the DAC modes of /selinux/enforce I would guess it requires linux
root to be written. Also, I thought I read elsewhere that the secadm_r
was configured so that it could not perform an su/sudo. Likewise, if I
try to execute system-config-selinux as the secadm_r role, I am not
permitted to authenticate as linux root user so I am not able to do
anything. If selinux is in permissive mode everything works, as long as
I su/sudo to root first. I have similar issues with the auditadm_r role.<br>
<br>
As for my previously mentioned issue with using sysadm_r to issue a
shutdown command while in enforcing mode, I was mistaken and this is
possible using sudo (not sure what I was thinking). It seems no MLS
roles can use su, only staff_r and sysadm_r may use sudo. auditadm_r
and secadm_r cannot use either and seem powerless without it. I am also
unable to directly log in as root when in enforcing mode. <br>
<br>
Note that I am using the roles as they are configured in the MLS
policy. If it is required to change or configure the roles to make them
able do what it seems like they should be able to do, thats ok, but
first I need to make sure I'm not just being boneheaded and using them
in the wrong way or have bad expectations of what they should be able
to do. <br>
</body>
</html>

--------------070109050904000603010703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
