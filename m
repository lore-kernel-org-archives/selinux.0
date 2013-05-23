Message-ID: <519E7153.5070403@tycho.nsa.gov>
Date: Thu, 23 May 2013 15:43:15 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Future of SETools and CIL
References: <5194E01F.2040505@tresys.com> <5194F142.2080600@tycho.nsa.gov> <519E636B.8010101@tresys.com>
In-Reply-To: <519E636B.8010101@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/23/2013 02:43 PM, Steve Lawrence wrote:
> On 05/16/2013 10:46 AM, James Carter wrote:
>> On 05/16/2013 09:33 AM, Steve Lawrence wrote:
>>> Another discussion we would like to have, which may affect the future of
>>> SETools/apol, is CIL. Is there still interest in CIL? And if so, have
>>> there been any thoughts on using and migrating to CIL? Is more work
>>> needed before this can happen? Has anyone put thought into higher level
>>> languages that could sit on top of CIL? If there is interest, this may
>>> affect the SETools changes, for example, syntactic policy analysis for
>>> CIL is likely very different than current policy.
>>
>> I am still interested in CIL. In fact, I just got CIL to work on a
>> translation of Refpolicy from early 2012. (And by work I mean produce a
>> binary policy equivalent, according to sediff, with the binary produced
>> by the Refpolicy build.) I just started this week on trying it against a
>> recent version of Refpolicy. There are some issues that I need to work
>> through; the biggest being how to handle the optional parameters to
>> filetrans_pattern() and filetrans_add_pattern(). I hope to make both the
>> CIL translation of Refpolicy and my many modifications to CIL available
>> shortly.
>>
>> I am also interested in resurrecting the earlier policy toolchain work
>> to convert to the use of source modules and allow the use of CIL for
>> policy builds.
>>
>
> That's great to hear! Did this require any patches to CIL at all? I'd be happy
> to review any changes.
>

A few changes were made. ;)

  b/Makefile              |   38
  b/include/cil/cil.h     |    1
  b/secilc.c              |   51 -
  b/src/cil.c             |  237 ++---
  b/src/cil_binary.c      | 1144 ++++++++++++++--------------
  b/src/cil_binary.h      |    4
  b/src/cil_build_ast.c   | 1717 +++++++++++++++++-------------------------
  b/src/cil_build_ast.h   |   26
  b/src/cil_copy_ast.c    | 1265 +++++++-----------------------
  b/src/cil_copy_ast.h    |   18
  b/src/cil_fqn.c         |    9
  b/src/cil_internal.h    |  136 +--
  b/src/cil_list.c        |  157 +--
  b/src/cil_list.h        |   25
  b/src/cil_mem.c         |   33
  b/src/cil_mem.h         |    4
  b/src/cil_parser.c      |    6
  b/src/cil_policy.c      |  610 ++++++++------
  b/src/cil_post.c        |  639 +++++++++++----
  b/src/cil_resolve_ast.c |  889 ++++++++-------------
  b/src/cil_resolve_ast.h |    6
  b/src/cil_symtab.c      |  140 +--
  b/src/cil_symtab.h      |    9
  b/src/cil_tree.c        | 1959 +++++++++++++++++++++++++-----------------------
  b/src/cil_verify.c      |  847 ++++++++------------
  b/src/cil_verify.h      |    5
  b/test/policy.cil       |    2
  src/Makefile            |   57 -
  28 files changed, 4591 insertions(+), 5443 deletions(-)

I will gladly send you patches if you want them, but I have 45 commits in my tree.

Many of these commits are small. And many of the ones that are large are just 
applying a similar change in many places. One of the big ones is just to improve 
debug messages. Another big one is just a refactoring of cil_list handling. 
Another very large one is the removal of cil_conditional.

A surprisingly large number of the commits went towards adding support for 
expression operations in classpermsets and classmappings. I haven't been able to 
test CIL with actual permission expressions yet, because I had been expanding 
them all in my parser when converting Refpolicy to CIL policy. I don't expect 
any major problems because permission expressions are handled with much of the 
same code that attributes and other expressions are.

I am currently updating my parser to work with the latest Refpolicy and testing 
should begin shortly. Hopefully, I will soon be able to report success.

> Regarding the policy toolchain, I just tried to rebase to previous policy
> toolchain work/CIL integration and, not surprisingly, it ran into conflict
> issues on the very first patch. So it's probably not trivial, but I imagine it's
> not too difficult either.

That is my thought as well.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
