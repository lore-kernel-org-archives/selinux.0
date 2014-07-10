Message-ID: <53BE889C.9050909@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 08:35:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>,
 Steve Lawrence <slawrence@tresys.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain>
In-Reply-To: <1404975079.31209.11.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 02:51 AM, Dominick Grift wrote:
> On Wed, 2014-07-09 at 15:21 -0400, Steve Lawrence wrote:
>> In January, we sent an RFC [1] to update userspace to integrate CIL
>> [2] and source policy. And in April, we sent an updated RFC [3] which
>> added support for high level languages and a tool to convert policy
>> package (pp) files to CIL. After getting some good feedback, we have
>> made some more changes, mostly to maintain ABI compatibility. The
>> major changes made since the last patchset are:
> 
> <snip>
> 
> I just spent a few hours playing with this and i am impressed.
> 
> Everything i tested just works.
> 
> What did i test?
> 
> 1. disabling/enabling existing modules
> 2. toggling booleans with semanage
> 3. adding and removing port and file contexts with semanage
> 4. adding/removing a policy module with semodule, checkmodule,
> semodule_package
> 5. adding/removing a (cil) policy module with semodule
> 6. associating a (new) user with staff_t identity
> 
> Comments?
> 
> if i do restorecon -R -v -F /home it resets contexts *every* time (from
> s0 to s0-s0). No noticable side effects because of this
> 
> After associating user john with staff_u, johns home directory is
> properly labeled (staff_u associated with /home/john). However, what is
> strange here is that i cannot see staff_u home dir context specs
> in /var/lib/selinux/targeted/active/modules/file_contexts.homedirs
> 
> Am i looking in the wrong place? How does SELinux know that staff_u
> needs to be associated with /home/john
> 
> When you remove a custom module (semodule -r mycustmodule) semodule is a
> little verbose. (one line gets printed)
> 
> Other than that it looks flawless. Ofcourse i only tested it for a few
> hours but on the surface everything looks ok
> 
> I recorded the whole testing session for reference and submitted the
> video to youtube under the name of cil testday

Thanks for testing it.  How did it look from a performance POV, wrt
memory use and runtime?
