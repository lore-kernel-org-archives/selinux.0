Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HENveC019252
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 09:23:57 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HENrPl021507
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 14:23:54 GMT
Message-ID: <43F5DC70.3070103@gentoo.org>
Date: Fri, 17 Feb 2006 09:23:44 -0500
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Chris PeBenito <pebenito@gentoo.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net> <43F561F3.4080200@cornell.edu>
In-Reply-To: <43F561F3.4080200@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> # semanage login -l
>>
>> Login Name                SELinux User              MLS/MCS Range
>>
>> root                      root                      __default__:user_u
>>
>> # semanage login -a -s staff_u pebenito
>> Segmentation fault
>>
>>   
> PeBenito, can you provide a trace with line numbers (i.e. 
> libsemanage-debuginfo, and libsepol-debuginfo installed)?
I don't think he can install libsemanage-debuginfo (since those are Red 
Hat packages) but I've encountered this before as well, here is a backtrace:

#0  0x0017ebd3 in strdup () from /lib/libc.so.6
#1  0x00474d5e in mls_from_string (handle=0x8b06b70, policydb=0x8b30a78, 
str=0x0, mls=0x8b8a930) at mls.c:85
#2  0x00476143 in sepol_mls_contains (handle=0x8b06b70, 
policydb=0x8b30a78, mls1=0x0, mls2=0x8b2fd98 "s0", response=0xbfdc7068)
    at mls.c:635
#3  0x008bec55 in validate_handler (seuser=0x8b2fd68, varg=0xbfdc713c) 
at seusers_local.c:126
#4  0x008b101a in dbase_llist_iterate (handle=0x8aa0ea8, 
dbase=0x8a83110, fn=0x8beac6 <validate_handler>, arg=0xbfdc713c)
    at database_llist.c:278
#5  0x008af638 in dbase_iterate (handle=0x8aa0ea8, dconfig=0x8aa0f28, 
fn=0x8beac6 <validate_handler>, fn_arg=0xbfdc713c)
    at database.c:191
#6  0x008bea7a in *semanage_seuser_iterate_local_internal 
(handle=0x8aa0ea8, handler=0x8beac6 <validate_handler>,
    handler_arg=0xbfdc713c) at seusers_local.c:68
#7  0x008bee41 in semanage_seuser_validate_local (handle=0x8aa0ea8, 
policydb=0x8b30a78) at seusers_local.c:163
#8  0x008b3b0a in semanage_direct_commit (sh=0x8aa0ea8) at direct_api.c:545
#9  0x008b60b0 in semanage_commit (sh=0x8aa0ea8) at handle.c:227
#10 0x00810ea3 in _wrap_semanage_commit (self=0x0, args=0xb7f490cc) at 
semanageswig_wrap.c:2419
#11 0x009f109a in PyCFunction_Call () from /usr/lib/libpython2.4.so.1.0
#12 0x00a295e4 in PyEval_EvalFrame () from /usr/lib/libpython2.4.so.1.0
#13 0x00a28e0f in PyEval_EvalFrame () from /usr/lib/libpython2.4.so.1.0
#14 0x00a2a1ff in PyEval_EvalCodeEx () from /usr/lib/libpython2.4.so.1.0
#15 0x00a2a283 in PyEval_EvalCode () from /usr/lib/libpython2.4.so.1.0
#16 0x00a45f53 in Py_CompileString () from /usr/lib/libpython2.4.so.1.0
#17 0x00a47539 in PyRun_SimpleFileExFlags () from 
/usr/lib/libpython2.4.so.1.0
#18 0x00a47bb5 in PyRun_AnyFileExFlags () from /usr/lib/libpython2.4.so.1.0
#19 0x00a4deb6 in Py_Main () from /usr/lib/libpython2.4.so.1.0
#20 0x0804859a in main ()


It is easy to reproduce, build a non-mls policy and try to add a user.. 
this brings up something else, semanage currently lacks the ability to 
specify a store to connect to, semodule has this ability and I think 
semanage needs it (and will need it much more when networked 
policy-server access is possible)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
