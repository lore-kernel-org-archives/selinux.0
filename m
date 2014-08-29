Message-ID: <54008BCA.8070609@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 10:18:50 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>,
 Steve Lawrence <slawrence@tresys.com>
Subject: Re: SELinux Userspace Release: 20140826-rc1
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
 <53FE02E5.6080506@tresys.com>
 <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
 <53FF8DE9.6070302@tycho.nsa.gov>
 <CAPzO=Nwwbn8ihZmuj-JGKPUonZwjS69Zjg=1ix1EDbR=QQ56oQ@mail.gmail.com>
 <54006DD4.6040706@tycho.nsa.gov> <54007889.90706@tresys.com>
 <CAPzO=Nwppvd+Q=J4SXk5Q38FVAUpqCeb8vjXhxfMBkbFRYpjsw@mail.gmail.com>
 <54008AC4.6080600@tycho.nsa.gov>
In-Reply-To: <54008AC4.6080600@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/29/2014 10:14 AM, Stephen Smalley wrote:
> On 08/29/2014 10:00 AM, Sven Vermeulen wrote:
>> On Fri, Aug 29, 2014 at 2:56 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>>>>>>> Segmentation fault
>>>>> [...]
>>>>>> Can you provide a copy of your original policy prior to conversion?
>>>>>
>>>>> If you mean the policy.29 file, certainly. You can wget it from
>>>>> http://dev.gentoo.org/~swift/tmp/20140828-policy.29
>>>>
>>>> No, the contents of /etc/selinux/mcs.  The migration script converts the
>>>> old policy module store, not the final kernel policy file.
>>>>
>>>
>>> Hmm, I'm unable to reproduce this. I think the policy store that Stephen
>>> mentions will be help to reproduce it.
>>>
>>
>> Certainly.
>>
>> The policy store can be found at
>> http://dev.gentoo.org/~swift/tmp/20140829-etc-selinux-mcs.tar.gz
> 
> Hmm...semanage_migrate_store worked for me on that policy store.
> 
> Can you reproduce the fault?  If so, can you get debug info?
> Build with debug flags and run semanage_migrate_store under valgrind,
> perhaps?

Ok, I got it to fault (had to change my /etc/selinux/config
SELINUXTYPE=mcs to make it the active policy).

==18786== Invalid write of size 8
==18786==    at 0xD83EC95: cil_reset_level (cil_reset_ast.c:214)
==18786==    by 0xD83E9FE: cil_reset_user (cil_reset_ast.c:102)
==18786==    by 0xD83F243: __cil_reset_node (cil_reset_ast.c:345)
==18786==    by 0xD847FA0: cil_tree_walk_core (cil_tree.c:172)
==18786==    by 0xD848109: cil_tree_walk (cil_tree.c:216)
==18786==    by 0xD83F52C: cil_reset_ast (cil_reset_ast.c:471)
==18786==    by 0xD84644A: cil_resolve_ast (cil_resolve_ast.c:3493)
==18786==    by 0xD8179B6: cil_compile (cil.c:338)
==18786==    by 0xE14E212: semanage_direct_commit (direct_api.c:1107)
==18786==    by 0xE15C205: semanage_commit (handle.c:426)
==18786==    by 0xDEF7264: _wrap_semanage_commit (semanageswig_wrap.c:4098)
==18786==    by 0x31E68E0BD3: PyEval_EvalFrameEx (in
/usr/lib64/libpython2.7.so.1.0)
==18786==  Address 0x20 is not stack'd, malloc'd or (recently) free'd
