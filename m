Subject: Re: INTERP ELF header and SELinux
To: Nick Kralevich <nnk@google.com>, SELinux <Selinux@tycho.nsa.gov>
References: <CAFJ0LnF5CXaNDMKMLtmVung4RXUujeL3jBZFopzeOwy6+iiWRg@mail.gmail.com>
 <d19e0642-04b4-094c-e759-7922979dae66@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8aaae08c-8fde-45e6-82d6-e75183aa74d2@tycho.nsa.gov>
Date: Mon, 5 Dec 2016 10:30:47 -0500
MIME-Version: 1.0
In-Reply-To: <d19e0642-04b4-094c-e759-7922979dae66@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/05/2016 08:43 AM, Stephen Smalley wrote:
> On 12/04/2016 01:29 PM, Nick Kralevich wrote:
>> Scenerio:
>>
>> 1) Process P is running in the "P" SELinux domain.
>> 2) A type transition is defined such that when P executes Q_exec, P
>> transitions into SELinux domain Q.
>> 3) Q_exec is an ELF executable with an INTERP (dynamic linker) header
>> pointing to a file labeled R_interp_lib
>> 4) Domain P has file execute permission on R_interp_lib and Q_exec. P
>> does NOT have execute_no_trans on Q_exec nor on R_interp_lib.
>> 5) Domain Q has file execute permissions on Q_exec, but does NOT have
>> file execute permissions on R_interp_lib.
>> 6) P executes Q_exec
>>
>> What is the intended behavior? Is it:
>>
>> 1) P can successfully execute Q_exec. The process in domain Q has
>> R_interp_lib mapped into the process as executable memory even though it
>> wasn't explicitly allowed by policy. This was allowed because P has
>> execute on R_interp_lib.
>>
>> 2) P gets "permission denied" attempting to run Q_exec, because the
>> resulting domain Q does not have execute permission on R_interp_lib, and
>> Q needs R_interp_lib to successfully run.
>>
>> Other?
>>
>> From my (admittedly weak) understanding of the current kernel code
>> today, it appears the answer is #1. The permission checks performed by
>> the kernel when loading the dynamic linker occur in the initiating
>> SELinux domain, not the resulting SELinux domain. So as long as the
>> executing process has execute on the dynamic linker, the target process
>> will have the dynamic linker mapped into it's memory.
>>
>> Intuitively, I would have expected #2. In the same way that a process
>> shouldn't be able to be executed it doesn't have file execute on it's
>> own executable, it shouldn't be able to be executed if it doesn't have
>> execute on it's dynamic linker.
>>
>> Thoughts?
> 
> I agree that #2 is preferable, and I believe that is in fact the
> behavior after commit 9f834ec18defc369d73ccf9e87a2790bfa05bf46 circa
> Linux 4.8.  Easiest way to check is to add auditallow statements to see
> what execute checks are being applied on a given domain transition.  The
> SELinux support for domain transitions was implemented by hooking the
> existing functions for setuid/setgid program execution, so there are
> some suboptimal aspects of the current checking, not only this
> particular issue but also the label in which the descriptor for the
> interpreter is opened, which requires the new domain to be able to use
> descriptors with its parent's label even if not passing any descriptors
> opened by the parent.  Also execute_no_trans is rather imprecise; it
> only gets checked upon execve(), so a userspace program loader can avoid
> it entirely and only requires execute permission.

Before the commit above, the permissions required were:
P must be allowed execute to R_interp_lib and to Q_exec.
Q must be allowed entrypoint to Q_exec.

After the commit above, the permissions required are:
P must be allowed execute to R_interp_lib and to Q_exec (unchanged).
Q must be allowed entrypoint and execute to Q_exec (+execute).
Q must be allowed execute to R_interp_lib (new).
