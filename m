Subject: Re: secilc: in segfault
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <20150903094844.GA18832@x250> <55E83A89.5010208@tycho.nsa.gov>
 <20150903132041.GD2118@x250> <55F093C9.2080508@tycho.nsa.gov>
 <20150910070853.GA26300@x250>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <55F187A5.8050207@tresys.com>
Date: Thu, 10 Sep 2015 09:37:41 -0400
MIME-Version: 1.0
In-Reply-To: <20150910070853.GA26300@x250>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/10/2015 03:08 AM, Dominick Grift wrote:
> On Wed, Sep 09, 2015 at 04:17:13PM -0400, James Carter wrote:
> <snip>
> 
> 
>> Why not use something like this:
> 
>> (block exec_blk
>> 	(blockabstract exec_blk)
>> 	(macro exec ((type ARG1))
>> 	       (call can_exec (ARG1 cmd_file))))
> 
>> (block auditctl
>> 	(blockinherit exec_blk))
> 
>> (call auditctl.exec (some_type))
> 
>> instead of:
> 
>> (block exec_blk
>> 	(blockabstract exec_blk)
>> 	(call can_exec (ARG1 cmd_file)))
> 
>> (block auditctl
>>   	(macro exec ((type ARG1))
>> 		(blockinherit exec_blk)))
> 
>> (call auditctl.exec (some_type))
> 
> 
> I tried your suggestion above in the following two commits:
> 
> https://github.com/DefenSec/dssp/commit/ddb58e7832bf6a815c495f30ae8a4a4060d227b7
> https://github.com/DefenSec/dssp-contrib/commit/6ecb6b2f5830aaa7b3f3ec081af95ce0d71d06dc
> 
> This time it "really" seems to segfault on "in" (i tried moving it out
> of there and that built)
> 
> However I prefer to not put these "macros" in the existing blocks. I
> want to keep these macros in seperate $module/macros.cil files. Thus i
> depend on "in".
> 
> This implementation also feels a bit limited and unintuitive but i suppose i could live
> with that.

The segfault is cause by the in-statement. I'll send a patch shortly.

We don't allow block (and blockinherits/blockabstract) inside macros
because of ordering issues. For example, say you had something like this:

  (block a
    (blockinherit b)
    (call m))

  (block b
    (macro m ()
       ...)

  (macro m ()
    (blockinherit c))

  (block c
    (macro m ()
       ...))

If we performed the blockinherit b first, that would add b.m to block a.
Then if we performed the call m, that would call that b.m that was added
to a. So the global macro m would never be called.

However, if we instead had

  (block a
    (call m)
    (blockinherit b))

and we performed the call m first, that would be equivalent to

  (block a
    (blockinherit c)
    (blockinherit b))

Which would result in the macros from b and c being merged into block a.
So in once case the macro c.m isn't part of block a, but in the other
case it is.

Because of these ordering issues, it was decided to resolve all
blockinherit statements before calls. This has the effect that we can't
allow block, blockinherit, and blockabstract inside macros. This is a
similar reason why we don't allow in-statements and macro statements
inside of macros.

The patch I send out will also include changes to properly restrict
blocks from being defined inside macros.

- Steve
