Message-ID: <55687AC5.7080105@tresys.com>
Date: Fri, 29 May 2015 10:42:13 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
 Steve Lawrence <slawrence@tresys.com>, Joshua Brindle
 <brindle@quarksecurity.com>, Eric Paris <eparis@redhat.com>, Daniel J Walsh
 <dwalsh@redhat.com>
Subject: Re: ANN: SETools 4.0.0-alpha2
References: <54DB79D3.8@tresys.com> <55685F78.9080306@tycho.nsa.gov>
In-Reply-To: <55685F78.9080306@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/29/2015 8:45 AM, Stephen Smalley wrote:
> On 02/11/2015 10:48 AM, Christopher J. PeBenito wrote:
>> Tresys has released SETools 4.0.0-alpha2:
>>
>> https://github.com/TresysTechnology/setools/releases/tag/4.0.0-alpha2
>>
>> In this release, SETools has been updated to support Python 3 (tested
>> with 3.3 and 3.4) and includes travis-ci testing[1].  Many features are
>> complete or nearly complete (full list at the end of the email) and
>> available for use via the CLI tools.  The GUI tools have not yet been
>> started.
>>
>> Warning: If you replace the SETools 3.x on your system, it will break
>> the couple of tools from sepolgen/policycoreutils that depend on SETools
>> (e.g. sepolicy) since libqpol/libapol C libraries and their
>> corresponding SWIG wrappers are no longer provided.
> 
> Should we then import libqpol and libapol into the upstream selinux?

You could, but I think it would be an overkill (particularly libapol),
based on what I can understand of sepolicy's needs, which is iterating
over policy objects plus a little basic avtab searching.  It's also
CIL-ignorant (not that SETools 4 is CIL-aware).  You'll also need to
iron out the autotools usage.

A library that replaced only the needed functions might be pretty easily
doable by leveraging existing dispol code.  A longer term, more
comprehensive solution would be having a CIL-aware query library
upstream (something that provides iteration over the policy contents,
symbol lookups, etc.), which would be broadly useful for sepolicy,
SETools, admin tools, etc. since libsepol isn't really designed with
policy query in mind (which is why we created libqpol).


> We never should have added dependencies on setools to the core selinux
> userspace in the first place, as it creates a cyclic dependency.

Hopefully it would easy to port sepolicy to SETools 4 since both are
Python, which would be a solution until the dependency cycle can be
broken.  I haven't fully looked to see what that would take, since I
haven't dissected sepolicy's C Python extension.


> Doesn't look like libapol and libqpol have other dependencies themselves
> beyond what we already require for selinux userspace unless I am missing
> something.

I don't think it has any additional dependencies on top of what SELinux
userspace already has (unless you don't rip out autotools).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
