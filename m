MIME-Version: 1.0
In-Reply-To: <CAFftDdqc3GaWcu0PDwFPb34arKgqv8HyYrsX8dS_kEuYArfO5g@mail.gmail.com>
References: <20180308201926.28435-1-sds@tycho.nsa.gov>
 <6c5512f2-8818-a44c-46e7-fd46e065f622@tycho.nsa.gov>
 <CAFftDdqc3GaWcu0PDwFPb34arKgqv8HyYrsX8dS_kEuYArfO5g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 15 Mar 2018 13:53:08 -0700
Message-ID: <CAFftDdr2sYsEyLqqS0cw1RiZaJ-BuFJyeEU=gFxpDpb+pPcvbw@mail.gmail.com>
To: jwcart2 <jwcart2@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsepol: Export sepol_polcap_getnum/name
 functions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

merged:
https://github.com/SELinuxProject/selinux/pull/85


On Thu, Mar 15, 2018 at 11:31 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Mar 15, 2018 at 11:01 AM, jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>> On 03/08/2018 03:19 PM, Stephen Smalley wrote:
>>>
>>> Export the sepol_polcap_getnum/name() functions to users of
>>> the shared library.  This will enable SETools to stop depending
>>> on the static library.
>>>
>>> Note that we may want to move polcaps.h up one level since
>>> the convention is that headers directly under include/sepol are
>>> shared library APIs while headers under include/sepol/policydb
>>> are limited to static users.  However, this will unnecessarily
>>> break the build for existing static users so it is deferred.
>>>
>>> Suggested-by: Chris PeBenito <pebenito@ieee.org>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>>
>> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
>>
>>> ---
>>>   libsepol/src/libsepol.map.in | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
>>> index 2a9996f7..d879016c 100644
>>> --- a/libsepol/src/libsepol.map.in
>>> +++ b/libsepol/src/libsepol.map.in
>>> @@ -56,4 +56,6 @@ LIBSEPOL_1.1 {
>>>         sepol_module_policydb_to_cil;
>>>         sepol_kernel_policydb_to_cil;
>>>         sepol_kernel_policydb_to_conf;
>>> +       sepol_polcap_getnum;
>>> +       sepol_polcap_getname;
>>>   } LIBSEPOL_1.0;
>>>
> Acked-by: William Roberts <william.c.roberts@intel.com>
