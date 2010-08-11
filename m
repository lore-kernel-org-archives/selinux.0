Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7BHulBh008721
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 13:56:47 -0400
Received: from mail-qy0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o7BHv0O1013979
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 17:57:01 GMT
Received: by qyk7 with SMTP id 7so5376584qyk.12
        for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 10:56:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
References: <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
Date: Wed, 11 Aug 2010 13:56:42 -0400
Message-ID: <AANLkTi=XgsojHnCar_h56xyf3eF46A=fn_2-v6s=8nKL@mail.gmail.com>
Subject: Re: User defined roles on Linux
From: Stephen Smalley <stephen.smalley@gmail.com>
To: "S, Senthilprabu (NSN - IN/Bangalore)" <senthilprabu.s@nsn.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 11, 2010 at 10:59 AM, S, Senthilprabu (NSN - IN/Bangalore)
<senthilprabu.s@nsn.com> wrote:
> Hello All,
>    I am a newbie to Linux and SELinux as well. So apologize me if my question is stupid. All these days, I have been playing with Solaris. Have implemented user profiles and associated them with roles using RBAC on Solaris to facilitate set of users to run my application. Users assuming my role can only start, stop and troubleshoot application whereas not possible to execute any other commands. Now after RHEL 5.5 migration, I am trying to implement similar roles here too. After running through various RHEL manuals I assume that SELinux can be used to define RBAC roles to some extend, even though its main feature is to implement Mandatory Access Control (MAC). I see few pre-defined roles like  sysadm_r and staff_u. Now my question is it possible to create user defined roles on RHEL 5.5 using SELinux and assign it to shared os accounts?. If possible but not through SELinux, please let me how it can be done?.

In RHEL5, you would need to first switch to strict policy before
trying to configure and use SELinux roles, as the default targeted
policy doesn't provide the underlying support.  In modern Fedora and
RHEL6, you can configure user roles while still using targeted policy.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
