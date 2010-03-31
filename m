Message-ID: <4BB36B5C.6050602@tresys.com>
Date: Wed, 31 Mar 2010 11:33:48 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] Add implicit lib requirements to LDLIBS
References: <1269983319-10453-1-git-send-email-jbrindle@tresys.com>	 <4BB28AA1.9060508@tycho.nsa.gov>  <4BB34C5C.7030309@tresys.com>	 <1270048549.19608.163.camel@moss-pluto.epoch.ncsc.mil> <1270048645.19608.164.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1270048645.19608.164.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2010-03-31 at 11:15 -0400, Stephen Smalley wrote:
>> On Wed, 2010-03-31 at 09:21 -0400, Joshua Brindle wrote:
>>> Eamon Walsh wrote:
>>>> On 03/30/2010 05:08 PM, Joshua Brindle wrote:
>>>>> Fedora 13 changed their linker behavior to not link indirect libraries.
>>>>> See information at: http://fedoraproject.org/wiki/UnderstandingDSOLinkChange
>>>>>
>>>> I skimmed over semodule.c and setsebool.c and I didn't see any
>>>> references to bzip2 or ustr symbols.  My reading of the article suggests
>>>> the below fix should only be needed if that were the case.  Most likely
>>>> I missed them?
>>>>
>>> The link above is confusing. The change was made so that people who
>>> _did_ use eg., libxml but didn't explicitly link against it would have
>>> to do so even if other libraries they link against already did.
>>>
>>> In our case it means that anything libsemanage needs semodule and
>>> setsebool will also need to link against explicitly.
>>>
>>> Here is another page about the "feature":
>>> http://fedoraproject.org/wiki/Features/ChangeInImplicitDSOLinking
>>>
>>> The summary pretty much covers it I think:
>>> ""Change DSO-linking semantics of the gcc compiler. Previously calls to
>>> the linker (ld) from gcc would result in dangerous default behaviour
>>> where ld would attempt to implicitly satisfy link requirements. The
>>> proposed change will prevent ld from automatically searching in the
>>> dependencies of linked objects.""
>>>
>>>> Without this patch, do you get the linker error that says to add them?
>>>>
>>> Yes. It complains about missing bz2 and ustr symbols on my F13 system.
>> This doesn't seem right to me either, and I don't quite understand why
>> Dan wouldn't have encountered it already if it was an issue.
>>
>> As I read it, the change in behavior should only affect the program if
>> the program makes calls to symbols in the library and was previously
>> implicitly getting a dependency through another library.  But if the
>> program makes no calls to the library in question, it shouldn't need to
>> link against it.
>
> See:
> http://lists.fedoraproject.org/pipermail/devel/2010-January/129131.html
>

Bug it may be but I can't build on F13 right now without these changes. 
I suppose I'll keep them local until something is fixed.

On another note I also see this on F13:

cc -Wall -W -Wundef -Wshadow -Wmissing-noreturn 
-Wmissing-format-attribute -Wno-unused-parameter -I../include 
-I/home/method/s/usr/include -D_GNU_SOURCE   -shared -o libsemanage.so.1 
boolean_record.lo booleans_active.lo booleans_activedb.lo 
booleans_file.lo booleans_local.lo booleans_policy.lo 
booleans_policydb.lo context_record.lo database_activedb.lo database.lo 
database_file.lo database_join.lo database_llist.lo database_policydb.lo 
debug.lo direct_api.lo fcontext_record.lo fcontexts_file.lo 
fcontexts_local.lo fcontexts_policy.lo genhomedircon.lo handle.lo 
iface_record.lo interfaces_file.lo interfaces_local.lo 
interfaces_policy.lo interfaces_policydb.lo modules.lo node_record.lo 
nodes_file.lo nodes_local.lo nodes_policy.lo nodes_policydb.lo 
parse_utils.lo policy_components.lo port_record.lo ports_file.lo 
ports_local.lo ports_policy.lo ports_policydb.lo semanage_store.lo 
seuser_record.lo seusers_file.lo seusers_local.lo seusers_policy.lo 
user_base_record.lo user_extra_record.lo user_record.lo 
users_base_file.lo users_base_policydb.lo users_extra_file.lo 
users_join.lo users_local.lo users_policy.lo utilities.lo conf-scan.lo 
conf-parse.lo -lsepol -lselinux -lbz2 -lustr -L/home/method/s/lib64 
-Wl,-soname,libsemanage.so.1,--version-script=libsemanage.map,-z,defs
/usr/bin/ld: /home/method/s/lib64/libselinux.a(booleans.o): relocation 
R_X86_64_32 against `.rodata' can not be used when making a shared 
object; recompile with -fPIC
/home/method/s/lib64/libselinux.a: could not read symbols: Bad value
collect2: ld returned 1 exit status

it only happens if I set LIBDIR and SHLIBDIR.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
