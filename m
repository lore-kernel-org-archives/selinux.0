Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2F4nrco025914
 for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2018 00:49:53 -0400
Received: by mail-qt0-f171.google.com with SMTP id y6so5953396qtm.7
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 21:49:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdoET57viF6i4A1RKM9qBjdqCrggjDR7OUjtP8MtfcZgkg@mail.gmail.com>
References: <20180314221728.115654-1-trong@android.com>
 <CAFftDdoET57viF6i4A1RKM9qBjdqCrggjDR7OUjtP8MtfcZgkg@mail.gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 14 Mar 2018 21:49:46 -0700
Message-ID: <CABXk95D_PMLP0JY_R89UOr6XWYA=unKPCp6mC_Z3aTa3uMLonQ@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Tri Vo <trong@android.com>, Daniel Cashman <dcashman@google.com>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] secilc: resolve conflicts in expandattribute.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 14, 2018 at 4:05 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 3:17 PM, Tri Vo <trong@android.com> wrote:
>> When Android combines multiple .cil files from system.img and vendor.img
>> it's possible to have conflicting expandattribute statements, e.g.
>>  expandattribute hal_audio true;
>>  expandattribute hal_audio false;
>
> Isn't this the policy.conf version? I thought cil files had:
> expandtypeattribute, am I wrong here?

You'll need to fix checkpolicy too for consistency. See
https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/policy_define.c#L1185

>
>>
>> This change deals with scenario be resolving the value of the
>> corresponding expandattribute to false. The rationale behind this
>> override is that true is used for reduce run-time lookups, while
>> false is used for tests which must pass.
>
> So in a conflict, it's always forced to false, which prevents expansion.
> That seems reasonable. I would imagine this should also update some
> document somewhere that describes this behavior, does one exist?
> I couldn't find anything, but not sure if it's on some external webpage.
> Stephen do you know?
>
>> ---
>>  libsepol/cil/src/cil_resolve_ast.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index d1a5ed87..5c66f663 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -271,7 +271,6 @@ exit:
>>
>>  int cil_type_used(struct cil_symtab_datum *datum, int used)

Change from int to void. The return value is no longer useful.

>>  {
>> -       int rc = SEPOL_ERR;
>>         struct cil_typeattribute *attr = NULL;
>>
>>         if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
>> @@ -279,16 +278,13 @@ int cil_type_used(struct cil_symtab_datum *datum, int used)
>>                 attr->used |= used;
>>                 if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
>>                                 (attr->used & CIL_ATTR_EXPAND_FALSE)) {
>> -                       cil_log(CIL_ERR, "Conflicting use of expandtypeattribute. "
>> -                                       "Expandtypeattribute may be set to true or false "
>> -                                       "but not both. \n");
>> -                       goto exit;
>> +                       cil_log(CIL_WARN, "Conflicting use of expandtypeattribute. "
>> +                                       "Expandtypeattribute was set to both true or false for %s. "
>> +                                       "Resolving to false. \n", attr->datum.name);
>> +                       attr->used ^= CIL_ATTR_EXPAND_TRUE;
>
> Sure, this saves an operation, but:
>
> attr->used &= ~CIL_ATTR_EXPAND_TRUE;

+1

>
> Is less fragile and the usual unset idiom. I won't request this changed unless
> either you agree or someone else has the same opinion as me.
>
> One could always argue that conditional code that relies on the entry
> condition is the whole
> point of conditional code :-P
>
>>                 }
>>         }
>> -
>>         return SEPOL_OK;
>> -exit:
>> -       return rc;
>>  }
>>
>>  int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
>> --
>> 2.16.2.804.g6dcf76e118-goog
>>
>>
>
