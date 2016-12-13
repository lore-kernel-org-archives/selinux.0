Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBDL6v5s032148
 for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2016 16:06:57 -0500
Subject: Re: Possible SELinux problem on Fedora 25 Install
To: "Parker, Michael D." <Michael.D.Parker@ga.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <339e9b1b-45f1-d587-ec8a-035b1b36323b@redhat.com>
Date: Tue, 13 Dec 2016 22:06:51 +0100
MIME-Version: 1.0
In-Reply-To: <fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/13/2016 08:55 PM, Parker, Michael D. wrote:
> I am getting the following messages during the last update concerning
> SELinux packages...I do a pretty much vanilla install here and have not
> modified any SELinux functionality...should I be concerned?
> 

This is most likely a problem in container-selinux package (former
docker-selinux). Usually it's already fixed in the latest update from
updates-testing. If update doesn't help, please report your issue to Red
Hat Bugzilla:

https://bugzilla.redhat.com/enter_bug.cgi?product=Fedora&component=docker


Petr



>   Upgrading   : selinux-policy-3.13.1-225.3.fc25.noarch
> 1/38
> 
> Re-declaration of boolean virt_sandbox_use_fusefs
> 
> Failed to create node
> 
> Bad boolean declaration at
> /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152
> 
> semodule:  Failed!
> 
>   Upgrading   : samba-common-2:4.5.2-0.fc25.noarch
> 2/38
> 
>   Upgrading   : libwbclient-2:4.5.2-0.fc25.x86_64
> 3/38
> 
>   Upgrading   : samba-client-libs-2:4.5.2-0.fc25.x86_64
> 4/38
> 
>   Installing  : kernel-core-4.8.13-300.fc25.x86_64
> 5/38
> 
>   Installing  : kernel-modules-4.8.13-300.fc25.x86_64
> 6/38
> 
>   Upgrading   : selinux-policy-targeted-3.13.1-225.3.fc25.noarch
> 7/38
> 
> Re-declaration of boolean virt_sandbox_use_fusefs
> 
> Failed to create node
> 
> Bad boolean declaration at
> /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152
> 
> /usr/sbin/semodule:  Failed!
> 
>   Upgrading   : pcsc-lite-libs-1.8.19-1.fc25.x86_64
> 8/38
> 
>   Upgrading   : pcsc-lite-1.8.19-1.fc25.x86_64
> 9/38
> 
>   Upgrading   : selinux-policy-sandbox-3.13.1-225.3.fc25.noarch
> 10/38
> 
> Re-declaration of boolean virt_sandbox_use_fusefs
> 
> Failed to create node
> 
> Bad boolean declaration at
> /var/lib/selinux/targeted/tmp/modules/100/virt/cil:152
> 
> semodule:  Failed!
> 
>   Installing  : kernel-4.8.13-300.fc25.x86_64
> 11/38
> 
>   Upgrading   : libsmbclient-2:4.5.2-0.fc25.x86_64
> 12/38
> 
>   Upgrading   : selinux-policy-mls-3.13.1-225.3.fc25.noarch
> 13/38
> 
>   Upgrading   : selinux-policy-minimum-3.13.1-225.3.fc25.noarch
> 14/38
> 
> Failed to resolve typeattributeset statement at
> /var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472
> 
> /usr/sbin/semodule:  Failed!
> 
>  
> 
> ***** ***** *****
> 
> Michael D. Parker
> 
> General Atomics - ElectroMagnetics Systems Division (EMS)
> 
>  <mailto:Michael.d.parker@ga.com> Michael.d.parker@ga.com  <<<<< NOTE:
> Remember to include my middle initial >>>>>
> 
> +1 858 964 6675 / Office 86-1319 / Cell +1 858 376 7474
> 
> 16969 Mesamint Street / San Diego / CA / 92127
> 
>  
> 
> 
