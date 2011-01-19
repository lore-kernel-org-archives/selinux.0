Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0JLldhf017849
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 16:47:39 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0JLlcJu010609
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 21:47:38 GMT
Message-ID: <4D375BF8.2060100@redhat.com>
Date: Wed, 19 Jan 2011 16:47:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Qwyjibo Jones <qwyjibojones@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux role separation
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>	<4D37458B.4050705@redhat.com> <AANLkTimcB_2Dt6fetoDZ_Da0CaWKFDHv-UA=pA3P-Oc7@mail.gmail.com>
In-Reply-To: <AANLkTimcB_2Dt6fetoDZ_Da0CaWKFDHv-UA=pA3P-Oc7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/19/2011 04:44 PM, Qwyjibo Jones wrote:
> I don't seem to have the "allow_sysadm_manage_security" boolean. Do I
> need to create it somehow and put it under /selinux/booleans ?
> 
> # getsebool -a | grep allow_sysadm_manage_security
> # getsebool -a | grep allow_sysadm
> # getsebool -a | grep sysadm
> allow_httpd_sysadm_script_anon_write --> off
> ssh_sysadm_login --> off
> staff_read_sysadm_file --> off
> xdm_sysadm_login --> off
> 
> 
> 
> Thanks,
> 
> On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh <dwalsh@redhat.com
> <mailto:dwalsh@redhat.com>> wrote:
> 
> On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:
> 
>> I am currently working with an Itanium2 system which has RHEL 5.3 MLS
>> installed.
>> I am trying to understand how separation of roles works in SELinux/MLS
>> policy version 21. We have been told that we need to separate
> roles that
>> the sys admin is no longer allowed to do.
> 
>> After reading through these threads, in the archives I am still
>> wondering about a couple things:
> 
> 
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> 
>> And this one:
> 
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> 
>> 1) Is the RHEL 5.x MLS policy version 21 capable of the following
>> separation of sysadm_r and secadm_r roles:
> 
>>    a) Can the secadm_r role be the only role that can assign roles via
>> semanage?
> 
>>    c) Can the secadm_r role be the only role that can control
> files used
>> in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...
> 
> auditadm_r:auditadm_t is only allowed to modify these files.
> 
>> 2) Is this better accomplished with a combination of SUDO and SELinux?
> Since sysadm_t can hack his way around the SELinux controls via tools
> like rpm and fdisk, you are better off using sudo to further restrict
> his actions, if possible.
>> 3) How can I determine what secadm_r can do in the current
>> configuration? can any of the CLI tools show me that? ( no gui tools
>> available )
> 
> You probably want to look at secadm_t
> 
> sesearch -A -t secadm_t
> 
>> If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
>> Itanium systems, but we may have new hardware soon)
> 
>> Any tips. hints, pointers etc... would be very helpfull.
> 
>> Thanks for your time,
> 

You are running on an MLS machine?
seinfo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk03W/gACgkQrlYvE4MpobOhXACgjt4a2pHLgbfTRfUJTmhR2ALH
5VAAoIMbs+gV+YD8QlQFMv4oP9qiN5IX
=nMTA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
