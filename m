Message-ID: <557F004B.8090703@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 12:41:47 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tim Shearer <tim.shearer@overturenetworks.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
Subject: Re: Kernel error: SELinux:  Invalid class 0
References: <33526A3108217C45B7DAFFA5277E4B67118AF1B3@mbx024-e1-nj-2.exch024.domain.local>
In-Reply-To: <33526A3108217C45B7DAFFA5277E4B67118AF1B3@mbx024-e1-nj-2.exch024.domain.local>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/12/2015 01:48 PM, Tim Shearer wrote:
> Hi all,
> 
>  
> 
> Environment: CentOS 7, with either stock 3.10 kernel, or custom 3.19 kernel.
> 
>  
> 
> I’m getting a AVC denial message in the audit logs that corresponds to
> the opening of a TIPC socket (AF_TIPC). The denial is seems valid, and
> is triggered by a custom C++ application that hasn’t yet been assigned
> an appropriate security context. The problem I’m having is that the AVC
> message is garbled (non-ASCII data in the denied and tclass fields),
> which makes it difficult to assemble a new policy:
> 
>  
> 
> ----
> 
> type=AVC msg=audit(1434126658.487:34500): avc:  denied  {
> *garbage_characters* } for  pid=292 comm="kworker/u16:5"
> scontext=system_u:system_r:kernel_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=*garbage_characters*
> permissive=0
> 
> ----
> 
>  
> 
> This corresponds to a kernel error that shows up in the debuglog:
> 
> SELinux:  Invalid class 0

This suggests that the tipc kernel module is creating a socket in some
manner without initializing its security state.

Can you provide a reproducer program that triggers the error?
