Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0KEM08U004697
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 09:22:00 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0KELxW2006705
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 14:22:00 GMT
Message-ID: <4D384504.6010603@redhat.com>
Date: Thu, 20 Jan 2011 09:21:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Qwyjibo Jones <qwyjibojones@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux role separation
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>	<4D37458B.4050705@redhat.com>	<AANLkTimcB_2Dt6fetoDZ_Da0CaWKFDHv-UA=pA3P-Oc7@mail.gmail.com>	<4D375CE6.7030107@redhat.com> <AANLkTi=7qtTjmVPDrVyDX0OiX1QbG3CzYXAtsT8L-von@mail.gmail.com>
In-Reply-To: <AANLkTi=7qtTjmVPDrVyDX0OiX1QbG3CzYXAtsT8L-von@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/20/2011 08:45 AM, Qwyjibo Jones wrote:
> Sorry, one more question...
> 
> Does the MLS policy shipped with RHEL 6 have the separation?
> 
> Thanks,
> 
> On Wed, Jan 19, 2011 at 4:51 PM, Daniel J Walsh <dwalsh@redhat.com
> <mailto:dwalsh@redhat.com>> wrote:
> 
> On 01/19/2011 04:44 PM, Qwyjibo Jones wrote:
>> I don't seem to have the "allow_sysadm_manage_security" boolean. Do I
>> need to create it somehow and put it under /selinux/booleans ?
> 
>> # getsebool -a | grep allow_sysadm_manage_security
>> # getsebool -a | grep allow_sysadm
>> # getsebool -a | grep sysadm
>> allow_httpd_sysadm_script_anon_write --> off
>> ssh_sysadm_login --> off
>> staff_read_sysadm_file --> off
>> xdm_sysadm_login --> off
> 
> 
> 
>> Thanks,
> 
>> On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh <dwalsh@redhat.com
> <mailto:dwalsh@redhat.com>
>> <mailto:dwalsh@redhat.com <mailto:dwalsh@redhat.com>>> wrote:
> 
>> On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:
> 
>>> I am currently working with an Itanium2 system which has RHEL 5.3 MLS
>>> installed.
>>> I am trying to understand how separation of roles works in
> SELinux/MLS
>>> policy version 21. We have been told that we need to separate
>> roles that
>>> the sys admin is no longer allowed to do.
> 
>>> After reading through these threads, in the archives I am still
>>> wondering about a couple things:
> 
> 
> 
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> 
>>> And this one:
> 
> 
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> 
>>> 1) Is the RHEL 5.x MLS policy version 21 capable of the following
>>> separation of sysadm_r and secadm_r roles:
> 
>>>    a) Can the secadm_r role be the only role that can assign
> roles via
>>> semanage?
> 
>>>    c) Can the secadm_r role be the only role that can control
>> files used
>>> in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...
> 
>> auditadm_r:auditadm_t is only allowed to modify these files.
> 
>>> 2) Is this better accomplished with a combination of SUDO and
> SELinux?
>> Since sysadm_t can hack his way around the SELinux controls via tools
>> like rpm and fdisk, you are better off using sudo to further restrict
>> his actions, if possible.
>>> 3) How can I determine what secadm_r can do in the current
>>> configuration? can any of the CLI tools show me that? ( no gui tools
>>> available )
> 
>> You probably want to look at secadm_t
> 
>> sesearch -A -t secadm_t
> 
>>> If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
>>> Itanium systems, but we may have new hardware soon)
> 
>>> Any tips. hints, pointers etc... would be very helpfull.
> 
>>> Thanks for your time,
> 
> Oops I misread the policy,  I guess we abandoned the separation.
> 
> 
>                ifdef(`enable_mls',`
>                      
>  userdom_security_administrator(secadm_t,secadm_r,{
> secadm_tty_device_t sysadm_devpts_t })
> #                       tunable_policy(`allow_sysadm_manage_security',`
>                              
>  userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
> #                       ')
> 
> 
> Missed the "#" at the beginning of the lines.  So I don't think we
> prevent sysadm_t from managing the security, of course he has to be able
> to run at SystemHigh.
> 

RHEL6 MLS Policy for separation is pretty much the same.  We are just
working on certification now, hopefully for 6.1.  There is a lot more
policy that works with MLS in RHEL6 including some desktop features,
although we will be certifying server only, I believe.  Others might
build a MLS desktop based on RHEL6.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk04RQAACgkQrlYvE4MpobMSsgCg2tGDK2RvLrb7nv8gvCzX+mMq
F/YAoIu4Cp3JtIYrZL5IeEJRuF1mZWrj
=BL/v
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
