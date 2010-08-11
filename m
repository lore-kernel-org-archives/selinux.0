Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7BFx0D4031792
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 11:59:00 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7BFwsmd027281
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 15:58:54 GMT
Received: by pvg16 with SMTP id 16so106247pvg.12
        for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 08:58:58 -0700 (PDT)
Message-ID: <4C62C8DB.4000002@gmail.com>
Date: Wed, 11 Aug 2010 08:59:23 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "S, Senthilprabu (NSN - IN/Bangalore)" <senthilprabu.s@nsn.com>
CC: selinux@tycho.nsa.gov
Subject: Re: User defined roles on Linux
References: <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
In-Reply-To: <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/11/2010 07:59 AM, S, Senthilprabu (NSN - IN/Bangalore) wrote:
> Hello All,
>      I am a newbie to Linux and SELinux as well. So apologize me if my question is stupid. All these days, I have been playing with Solaris. Have implemented user profiles and associated them with roles using RBAC on Solaris to facilitate set of users to run my application. Users assuming my role can only start, stop and troubleshoot application whereas not possible to execute any other commands. Now after RHEL 5.5 migration, I am trying to implement similar roles here too. After running through various RHEL manuals I assume that SELinux can be used to define RBAC roles to some extend, even though its main feature is to implement Mandatory Access Control (MAC). I see few pre-defined roles like  sysadm_r and staff_u. Now my question is it possible to create user defined roles on RHEL 5.5 using SELinux and assign it to shared os accounts?. If possible but not through SELinux, please let me how it can be done?.
>
>
>
> Thanks in advance,
> Senthil Prabu.S
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

correct me if Im wrong but depending on the policy type i.e. 
monolithic/binary you would use semanage to create a user with the 
roles. as well as category level and sensitivity level and/or modify 
policy/users file to define the roles category/sensitivity of the user.
as for solaris haven't yet played around with FMAC yet but id imagine 
it's similar.

hope this helps.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
