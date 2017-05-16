From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 7/9] semanage: Update semanage to allow runtime
 labeling of Infiniband Pkeys
Date: Tue, 16 May 2017 19:40:33 +0000
Message-ID: <VI1PR05MB1678D10E63A52099878E8E7BC4E60@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-8-git-send-email-danielj@mellanox.com>
 <1494963296.21557.13.camel@tycho.nsa.gov>
 <VI1PR05MB167829E79B7450B9B0979818C4E60@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <1494963647.21557.15.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/16/2017 2:36 PM, Stephen Smalley wrote:
> On Tue, 2017-05-16 at 19:34 +0000, Daniel Jurgens wrote:
>> On 5/16/2017 2:30 PM, Stephen Smalley wrote:
>>> On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> Update libsepol and libsemanage to work with pkey records. Add
>>>> local
>>>> storage for new and modified pkey records in pkeys.local. Update
>>>> semanage
>>>> to parse the pkey command options to add, modify, and delete
>>>> pkeys.
>>>>
>>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> ---
>>>> v1:
>>>> Fixed semanage_pkey_exists -> semanage_ibpkey_exists in delete
>>>> flow
>>>> in
>>>> seobject.py
>>>>
>>>> Stephen Smalley:
>>>> - Subnet prefix can't vary in size always 16 bytes, remove size
>>>> field.
>>>> - Removed extraneous change in libsepol/VERSION
>>>> - Removed ifdef DARWIN s6_addr/32 blocks in favor of s6_addr.
>>>> - Got rid of magic constant for subnet prefix size.
>>>>
>>>> Jason Zaman:
>>>> - Use SETools directly to query types in seobject.py.
>>>>
>>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>>> ---
>>>>  libsemanage/include/semanage/ibpkey_record.h  |  76 +++++
>>>>  libsemanage/include/semanage/ibpkeys_local.h  |  36 +++
>>>>  libsemanage/include/semanage/ibpkeys_policy.h |  28 ++
>>>>  libsemanage/include/semanage/semanage.h       |   3 +
>>>>  libsemanage/src/direct_api.c                  |  29 +-
>>>>  libsemanage/src/handle.h                      |  36 ++-
>>>>  libsemanage/src/ibpkey_internal.h             |  52 +++
>>>>  libsemanage/src/ibpkey_record.c               | 185 +++++++++++
>>>>  libsemanage/src/ibpkeys_file.c                | 181 +++++++++++
>>>>  libsemanage/src/ibpkeys_local.c               | 178 ++++++++++
>>>>  libsemanage/src/ibpkeys_policy.c              |  52 +++
>>>>  libsemanage/src/ibpkeys_policydb.c            |  62 ++++
>>>>  libsemanage/src/libsemanage.map               |   1 +
>>>>  libsemanage/src/policy_components.c           |   5 +-
>>>>  libsemanage/src/semanage_store.c              |   1 +
>>>>  libsemanage/src/semanage_store.h              |   1 +
>>>>  libsemanage/src/semanageswig.i                |   3 +
>>>>  libsemanage/src/semanageswig_python.i         |  43 +++
>>>>  libsemanage/utils/semanage_migrate_store      |   3 +-
>>>>  libsepol/include/sepol/ibpkey_record.h        |  77 +++++
>>>>  libsepol/include/sepol/ibpkeys.h              |  44 +++
>>>>  libsepol/include/sepol/sepol.h                |   2 +
>>>>  libsepol/src/ibpkey_internal.h                |  21 ++
>>>>  libsepol/src/ibpkey_record.c                  | 448
>>>> ++++++++++++++++++++++++++
>>>>  libsepol/src/ibpkeys.c                        | 263
>>>> +++++++++++++++
>>>>  python/semanage/semanage                      |  60 +++-
>>>>  python/semanage/seobject.py                   | 255
>>>> +++++++++++++++
>>>>  27 files changed, 2129 insertions(+), 16 deletions(-)
>>>>  create mode 100644 libsemanage/include/semanage/ibpkey_record.h
>>>>  create mode 100644 libsemanage/include/semanage/ibpkeys_local.h
>>>>  create mode 100644 libsemanage/include/semanage/ibpkeys_policy.h
>>>>  create mode 100644 libsemanage/src/ibpkey_internal.h
>>>>  create mode 100644 libsemanage/src/ibpkey_record.c
>>>>  create mode 100644 libsemanage/src/ibpkeys_file.c
>>>>  create mode 100644 libsemanage/src/ibpkeys_local.c
>>>>  create mode 100644 libsemanage/src/ibpkeys_policy.c
>>>>  create mode 100644 libsemanage/src/ibpkeys_policydb.c
>>>>  create mode 100644 libsepol/include/sepol/ibpkey_record.h
>>>>  create mode 100644 libsepol/include/sepol/ibpkeys.h
>>>>  create mode 100644 libsepol/src/ibpkey_internal.h
>>>>  create mode 100644 libsepol/src/ibpkey_record.c
>>>>  create mode 100644 libsepol/src/ibpkeys.c
>>>>
>>>> diff --git a/python/semanage/seobject.py
>>>> b/python/semanage/seobject.py
>>>> index 7a54373..41b0aca 100644
>>>> --- a/python/semanage/seobject.py
>>>> +++ b/python/semanage/seobject.py
>>>> @@ -32,6 +32,7 @@ import socket
>>>>  from semanage import *
>>>>  PROGNAME = "policycoreutils"
>>>>  import sepolicy
>>>> +import setools
>>>>  from IPy import IP
>>>>  
>>>>  try:
>>>> @@ -1309,6 +1310,260 @@ class portRecords(semanageRecords):
>>>>                  rec += ", %s" % p
>>>>              print(rec)
>>>>  
>>>> +class ibpkeyRecords(semanageRecords):
>>>> +    try:
>>>> +        q =
>>>> setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_installed_po
>>>> licy
>>>> ()), attrs=["ibpkey_type"])
>>>> +        valid_types = sorted(str(t) for t in q.results())
>>>> +    except RuntimeError:
>>>> +        valid_types = []
>>> This causes all semanage commands to fail (without a patched
>>> refpolicy
>>> to define ibpkey_type).
>>>
>>> Traceback (most recent call last):
>>>   File "/usr/sbin/semanage", line 28, in <module>
>>>     import seobject
>>>   File "/usr/lib64/python2.7/site-packages/seobject.py", line 1313,
>>> in
>>> <module>
>>>     class ibpkeyRecords(semanageRecords):
>>>   File "/usr/lib64/python2.7/site-packages/seobject.py", line 1315,
>>> in
>>> ibpkeyRecords
>>>     q =
>>> setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_installed_poli
>>> cy()
>>> ), attrs=["ibpkey_type"])
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/typequery.py", line 72, in __init__
>>>     super(TypeQuery, self).__init__(policy, **kwargs)
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/query.py", line 39, in __init__
>>>     setattr(self, name, kwargs[name])
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/descriptors.py", line 104, in __set__
>>>     self.instances[obj] = set(lookup(v) for v in value)
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/descriptors.py", line 104, in <genexpr>
>>>     self.instances[obj] = set(lookup(v) for v in value)
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/policyrep/__init__.py", line 449, in
>>> lookup_typeattr
>>>     return typeattr.attribute_factory(self.policy, name)
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/policyrep/typeattr.py", line 42, in
>>> attribute_factory
>>>     qpol_symbol = _symbol_lookup(qpol_policy, name)
>>>   File "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-
>>> linux-
>>> x86_64.egg/setools/policyrep/typeattr.py", line 32, in
>>> _symbol_lookup
>>>     raise exception.InvalidType("{0} is not a valid
>>> type/attribute".format(name))
>>> setools.policyrep.exception.InvalidType: ibpkey_type is not a valid
>>> type/attribute
>> Yes, it's the same with all the others too.  They require attribute
>> synchronization between the tool and the policy.  I'm preparing
>> refpolicy patches right now.
> I think we just need to handle that exception cleanly.  I agree that it
> is wrong that we don't do this for the other attributes, but those are
> long-established in refpolicy and therefore haven't shown up before
> (also, the particular exception has changed with the migration to
> setools4, so we likely just never adapted the handlers).  We can't have
> a newer version of semanage break users with older policies.
Sure, that makes sense.  I'll address this and your other comments today this week and post a v2.
