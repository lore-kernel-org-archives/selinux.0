Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7RGAGeV026494
 for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2014 12:10:16 -0400
Message-ID: <53FE02E5.6080506@tresys.com>
Date: Wed, 27 Aug 2014 12:10:13 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux List
 <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc1
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
In-Reply-To: <20140827150608.GA6701@siphos.be>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/27/2014 11:06 AM, Sven Vermeulen wrote:
> On Tue, Aug 26, 2014 at 11:31:17AM -0400, Steve Lawrence wrote:
>> A release candidate for the next release of SELinux userspace is
>> available on GitHub's releases page [1]. This release contains a handful
>> of bug fixes and the new source policy/CIL work. Please let us know if
>> you find any problems.
>>
>> - Steve
>>
>> [1] https://github.com/SELinuxProject/selinux/releases/tag/20140826-rc1
> 
> Hi Steve
> 
> Are you planning on creating tarballs for this release candidate?
> 
> Also, is this a release that requires any actions to be taken as part of an
> upgrade (the move of /etc/selinux -> /var/lib/selinux)?
> 
> Wkr,
> 	Sven Vermeulen

We just pushed a second release candidate, 20140826-rc2, which just has
some minor fixes to the ChangeLogs and uses the scripts/release method
to make an actual release consistent with how they've been done in the
past. The tarballs for the individual components of userspace for rc2
are now available on the GitHub "Releases" wiki page [1].

The only action that should be required post upgrade is migration from
/etc/selinux to /var/lib/selinux. There is detailed information about
this process on the GitHub "Policy Store Migration" wiki page [2], but
the jist of it is after upgrading, execute the the
semanage_migrate_store script installed by default to
/usr/libexec/selinux. The script has additional options that can be used
to do things like remove the old store or prevent rebuilding the policy.
Run the script with --help for a description of the options.

Please let us know if there are any questions/issues.

Thanks,
- Steve

[1] https://github.com/SELinuxProject/selinux/wiki/Releases
[2] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
