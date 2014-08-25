Message-ID: <53FB5A59.5020805@tresys.com>
Date: Mon, 25 Aug 2014 11:46:33 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: "Stepan G. Fedorov" <stfedorov@gmail.com>, Stephen Smalley
 <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Subject: Re: semanage interface has no effect
References: <53FB19C7.1040500@gmail.com> <53FB35D2.3030307@tycho.nsa.gov>
 <53FB4192.8090203@gmail.com>
 <CAHC9VhSwgERb2NoY8vK3nT=wxBh7fyaD7ECGoxcRij5P6u1XKQ@mail.gmail.com>
 <53FB49D4.8050802@tycho.nsa.gov> <53FB4EC9.4090605@gmail.com>
In-Reply-To: <53FB4EC9.4090605@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/25/2014 10:57 AM, Stepan G. Fedorov wrote:
> 
>> ...but the new network permission checks will not be applied
>> until/unless you configure secmark or labeled networking.  Or set the
>> always_check_network policy capability to 1 for secmark, if your kernel
>> supports that.
> 
> Seems I have no such capability. My /sys/fs/selinux/policy_capabilities/
> contains only two files:
> network_peer_controls
> open_perms

That directory only lists the capabilities that are enabled in the
loaded policy.  You need at least a 3.13 kernel and the capability
declared in the policy (in the base module, base.pp).  Distributions
will likely never ship with that capability enabled, as it requires
packet (SECMARK) and peer rules throughout the policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
