Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9F1LFHv018327
 for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2015 21:21:15 -0400
Message-ID: <561EFF84.8020002@windriver.com>
Date: Thu, 15 Oct 2015 09:21:08 +0800
From: wenzong fan <wenzong.fan@windriver.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: ANN: SELinux Userspace Release: 20150202
References: <54CF9F03.8040604@tresys.com>
In-Reply-To: <54CF9F03.8040604@tresys.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Steve,

Can we know the release plan for SELinux? Such as when is the rough time 
for next release ...

Thanks
Wenzong

On 02/03/2015 12:00 AM, Steve Lawrence wrote:
> We are pleased to announce SELinux Userspace release 20150202. Tarballs
> are available on the Releases wiki page [1]. For git users, it has been
> tagged as 20150202. This release includes numerous bug fixes,
> performance updates, and new features, including CIL [2] and High Level
> Language [3] support. Please see the change logs for a detailed list of
> updates.
>
> One change worth pointing out is a change of location of the SELinux
> module store, which now defaults to /var/lib/selinux/. Updating to this
> release requires migrating the old policy store to this new location
> before policy can be managed with tools like semanage and semodule.
> Detailed information about the migration process is available on the
> Policy Store Migration wiki page [4].
>
> Thanks to all those that have submitted patches,
>
> - Steve
>
> [1] https://github.com/SELinuxProject/selinux/wiki/Releases
> [2] https://github.com/SELinuxProject/cil/wiki
> [3]
> https://github.com/SELinuxProject/selinux/wiki/High-Level-Language-Infrastructure
> [4] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
