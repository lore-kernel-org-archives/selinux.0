Message-ID: <53D65F44.3040705@tycho.nsa.gov>
Date: Mon, 28 Jul 2014 10:33:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, Andy Warner <warner@rubix.com>
Subject: Re: do user space object managers really provide mandatory access
 control
References: <1406536400.32528.7.camel@x220.localdomain>
 <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
 <1406544263.850.11.camel@x220.localdomain>
In-Reply-To: <1406544263.850.11.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: 'selinux' <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/28/2014 06:44 AM, Dominick Grift wrote:
> On Mon, 2014-07-28 at 11:13 +0200, Andy Warner wrote:
>> MAC is usually defined as not being discretionary (it is mandatory). That
>> is, the enforcement of the policy is not at the discretion of a user or
>> owner. In my experience it is not defined as "being enforced by the kernel."
>> Generally MAC also implies (and sometimes demands) implementation principles
>> like encapsulation and non-bypassibility, which a kernel based
>> implementation might satisfy, but it is not a requirement of MAC to be
>> implemented in the kernel.
>>
> 
> Thank you. I should rephrase "if one defines" to "when one defines"
> 
> I wonder whether the SELinux object manager related code implements any
> meaningful implementation principles like encapsulation,
> non-bypassibility, or others.

It certainly provides encapsulation of security policy by virtue of
using the same general interface exposed by the kernel security server
and deferring security attribute and policy logic interpretation to the
security server.

It also provides a way to define and enforce a consistent security goal
across all forms of data sharing, whether by file or database record or
D-BUS message or whatever.

It also provides a way to support dynamic policy and atomic policy
updates spanning all forms of data sharing.

And since it is built on SELinux, you have a kernel mechanism in place
that can be used to reliably identify subjects/processes (e.g.
getpeercon, SCM_SECURITY) and to ensure non-bypassability of the
userspace object manager, although it does not mandate that you do so.

None of those benefits are provided by your typical application layer
access control mechanism, nor are they even often considered.

>> I work in MAC based DBMS's which from your perspective could just be
>> considered an application layer, but it is implementing real MAC.  One
>> reason it cannot be totally implemented in the kernel is that the MAC is
>> arbitrating access to non-OS objects, such as database rows, tables, etc.
>> The DBMS can cooperate with the kernel and use the kernel for MAC based
>> decisions (if the MAC policy objectives are the same) but it cannot be
>> totally implemented in the kernel. At least, not without lots of tricky
>> theoretical work, which was my research topic years ago in grad school.
>> Enforcement of the policy is a key difficult issue. 
> 
> Depending on the answer to my question above that might beg the question
> then: why not implement a security server, and cache in the user space
> object manager itself. Although i think i know the answer to that
> question in advance: to facilitate centralized government of the policy
> rather than having that scattered all over.
> 
> All-in-all it sound like a lot of compromise.

No, it isn't a compromise at all.  The access control policy enforcement
logic properly belongs in the object manager that manages the object and
implements the operations on it that are being controlled; anything else
leads to insecurity.  In contrast, reimplementing the access control
policy decision making logic in two (or more) places not only provides
no benefit, it causes harm:
- You have to validate each such implementation (evaluation/testing cost),
- You have to maintain each such implementation (maintenance cost),
- Coordination of policy changes that span more than one object manager
is more complex,
- Defining and enforcing a uniform security goal that spans more than
one object manager is more complex,
- Policy analysis is more complex.

> What, other than providing a central place of governance, would be the
> benefits of SELinux user space object managers, over any other "MAC"
> solutions implemented solely in the user space c.q. application layer?

If I implement an XACML engine in userspace and use SELinux at the
kernel level, then how do I reason about the composition of the two?
How do I know that A can never leak data to B via any form of data
sharing, kernel or userspace?  How do I coordinate a policy change that
spans both engines?  It is of course possible to tie the two together,
but that requires additional infrastructure, introduces additional
complexity, etc beyond what is required for either one separately.

If I only use an XACML engine in userspace and don't use SELinux at all,
then how do I ensure that the XACML engine can't be bypassed?  How do I
reliably identify subjects/clients/processes for access control purposes?
