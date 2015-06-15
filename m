Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5FCgKZm024466
 for <selinux@tycho.nsa.gov>; Mon, 15 Jun 2015 08:42:20 -0400
Message-ID: <557EC809.5050002@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 08:41:45 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
 <20150614053349.GA5191@localhost.localdomain>
In-Reply-To: <20150614053349.GA5191@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/14/2015 01:33 AM, Dominick Grift wrote:
> On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:
>> Remove unused permission definitions from SELinux.
>> Many of these were only ever used in pre-mainline
>> versions of SELinux, prior to Linux 2.6.0.  Some of them
>> were used in the legacy network or compat_net=1 checks
>> that were disabled by default in Linux 2.6.18 and
>> fully removed in Linux 2.6.30.
>>
>> Permissions never used in mainline Linux:
>> file swapon
> 
> I think that blk_file (fixed disk) swapon is actually used in my policy by fstools (i think swapon command)

It isn't checked anywhere in the SELinux kernel code, so it might be
defined in your policy but it has no meaning.  The LSM hook and SELinux
hook function implementation that applied the check was never merged
into mainline.
