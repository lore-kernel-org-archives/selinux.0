Message-ID: <1496148733.2164.0.camel@tycho.nsa.gov>
Subject: Re: Access Vector Cache initialization audit message
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Guy Briggs <rgb@redhat.com>, SElinux list <selinux@tycho.nsa.gov>
Date: Tue, 30 May 2017 08:52:13 -0400
In-Reply-To: <20170529185348.GW6203@madcap2.tricolour.ca>
References: <20170529185348.GW6203@madcap2.tricolour.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-29 at 14:53 -0400, Richard Guy Briggs wrote:
> Hi, 
>   
> On kernel Access Vector Cache (AVC) initialization, there is an audit
> KERNEL 
> type message logged to announce this fact.
> 
> The general format of audit messages are label=value pair
> fields.  Steve Grubb 
> has been asking to have these records normalized by having a
> predictable set of 
> field labels present.
> 
> There already exists an audit KERNEL message giving audit state which
> has been 
> normalized thus:
>         "state=initialized audit_enabled=%u res=1"
> 
> The AVC initialization audit message doesn't currently fit that
> format:
>         "AVC INITIALIZED"
> 
> I'd created an issue to normalize the AVC initialization along these
> lines or 
> to have it move to a new message type and Paul Moore is questioning
> whether
> this message is required at all:
>         https://github.com/linux-audit/audit-kernel/issues/48
> 
> Can this message simply be eliminated?

AFAICT, yes, you can just remove it.
