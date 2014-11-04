Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA4Ectw7024316
 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2014 09:38:55 -0500
Received: by mail-wi0-f182.google.com with SMTP id d1so9454968wiv.9
 for <selinux@tycho.nsa.gov>; Tue, 04 Nov 2014 06:38:53 -0800 (PST)
Message-ID: <1415111931.22097.11.camel@joe.localdomain>
Subject: Re: user_r/sysadm_r/staff_r/unconfined_r
From: Dominick Grift <dac.override@gmail.com>
To: Russell Coker <russell@coker.com.au>
Date: Tue, 04 Nov 2014 15:38:51 +0100
In-Reply-To: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
References: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-11-04 at 22:37 +1100, Russell Coker wrote:
> The role separation seems to give no benefit apart from sysadm_r/unconfined_r given that we have seuser based constraints and MCS labels to separate users and that they all use the same types.
> 
> The current policy doesn't support even logging in with a user other than unconfined_r on Debian/Unstable without significant changes.
> 
> Is there any reason for not ripping out all but 2 roles, one for root (and other sysadmin accounts but not GNOME/KDE sessions) and the other for regukar users?
> 
> Doing that will make the policy smaller and simpler (for us and users) while not losing any functionality for most users. Where most users probably means everyone who doesn't develop their own policy. The people who do develop their own policy which depends on multiple roles probably have to do plenty of work on systems with the current policy anyway.
> 
> I think that sysadm_r/unconfined_r should not transition for programs like gpg.
> 
> NB staff_r is my invention. Before that we only had sysadm_r and user_r. I invented staff_r before MCS and the seuser constraints were developed. 

Wrong list.

Should refpolicy have user domains at all? Should it have more than a
single domain? As soon as one starts defining a domain one starts
assuming.

In my view plain refpolicy should be nothing more that what is currently
in the kernel layer plus unconfined module and maybe the libraries
module. Maybe constraints.

For sure not an init, authlogin modules etc.

the sole domain kernel_t should in my view ship unconfined, and if for
some reason one really want a user domain then add a unconfined user

Ref policies job would be to maintain core objects like devices, top
level file partitioning, network objects. That is it.

It would be very small and it would be base for all, because there are
almost no decisions made for who ever builds on it

Then on the side there could be a repository with individual add-on
scenario's

It kind of like base and contrib now, but taken further
