Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u877FvjH017783
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 03:15:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id w12so1442605wmf.1
 for <selinux@tycho.nsa.gov>; Wed, 07 Sep 2016 00:15:51 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id 137sm2633206wmi.16.2016.09.07.00.15.48
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Sep 2016 00:15:48 -0700 (PDT)
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <d6692a63-fd95-86f1-7ec9-641bab44efef@gmail.com>
Date: Wed, 7 Sep 2016 09:15:35 +0200
MIME-Version: 1.0
In-Reply-To: <20160907044233.GA3000@home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x09LJl8B0N0qGfCSMSriao4I4Lkw4qAON"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x09LJl8B0N0qGfCSMSriao4I4Lkw4qAON
Content-Type: multipart/mixed; boundary="vV0PUobDVEHO8AkLpVVce7CVCmmpTJokl"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <d6692a63-fd95-86f1-7ec9-641bab44efef@gmail.com>
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
In-Reply-To: <20160907044233.GA3000@home>

--vV0PUobDVEHO8AkLpVVce7CVCmmpTJokl
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/07/2016 06:42 AM, Gary Tierney wrote:
> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley wrote:
>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>> Removes the "system_u" and "s0" string literals from refpolicy and
>>> replaces the seuser and range in each homedir, uid, and username cont=
ext
>>> specification for every user.
>>>
>>> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
>>> ---
>>>  libsemanage/src/genhomedircon.c | 79
>>> ++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 66 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/libsemanage/src/genhomedircon.c
>>> b/libsemanage/src/genhomedircon.c
>>> index cce3884..cca97f6 100644
>>> --- a/libsemanage/src/genhomedircon.c
>>> +++ b/libsemanage/src/genhomedircon.c
>>> @@ -20,6 +20,7 @@
>>>   *  02110-1301  USA
>>>   */
>>>
>>> +#include <selinux/context.h>
>>
>> I think we likely want to use the sepol/context_record.h (already
>> included here) functions instead.  Those are already in use by
>> libsemanage.  I agree it is confusing and not helped by the fact that =
we
>> lack man pages for most sepol functions.  Sorry.
>>
>>
> Thanks, wasn't aware of those.  Will update to use the libsepol API.
>=20
>>>  #include <semanage/handle.h>
>>>  #include <semanage/seusers_policy.h>
>>>  #include <semanage/users_policy.h>
>>> @@ -82,9 +83,6 @@
>>>  #define TEMPLATE_USERNAME "%{USERNAME}"
>>>  #define TEMPLATE_USERID "%{USERID}"
>>>
>>> -#define TEMPLATE_SEUSER "system_u"
>>> -#define TEMPLATE_LEVEL "s0"
>>> -
>>>  #define FALLBACK_SENAME "user_u"
>>>  #define FALLBACK_PREFIX "user"
>>>  #define FALLBACK_LEVEL "s0"
>>> @@ -92,6 +90,8 @@
>>>  #define FALLBACK_UIDGID "[0-9]+"
>>>  #define DEFAULT_LOGIN "__default__"
>>>
>>> +#define CONTEXT_NONE "<<none>>"
>>> +
>>>  typedef struct user_entry {
>>>      char *name;
>>>      char *uid;
>>> @@ -599,14 +599,72 @@ static int
>>> write_replacements(genhomedircon_settings_t * s, FILE * out,
>>>      return STATUS_ERR;
>>>  }
>>>
>>> +static int write_user_replacements(genhomedircon_settings_t *s, FILE=

>>> *out,
>>> +              semanage_list_t *tpl, const replacement_pair_t *repl,
>>> +              const genhomedircon_user_entry_t *user)
>>> +{
>>> +    Ustr *line =3D USTR_NULL;
>>> +    context_t context =3D NULL;
>>> +
>>> +    for (; tpl; tpl =3D tpl->next) {
>>> +        line =3D replace_all(tpl->data, repl);
>>> +        if (!line) {
>>> +            goto fail;
>>> +        }
>>> +
>>> +        const char *old_context_str =3D extract_context(line);
>>> +        if (!old_context_str) {
>>> +            goto fail;
>>> +        }
>>> +
>>> +        if (strcmp(old_context_str, CONTEXT_NONE) =3D=3D 0) {
>>> +            if (check_line(s, line) &&
>>> +                !ustr_io_putfileline(&line, out)) {
>>> +                goto fail;
>>> +            }
>>> +
>>> +            continue;
>>> +        }
>>> +
>>> +        context =3D context_new(old_context_str);
>>
>> sepol_context_from_string()
>>
>>> +        if (!context) {
>>> +            goto fail;
>>> +        }
>>> +
>>> +        if (context_user_set(context, user->sename) !=3D 0 ||
>>
>> sepol_context_set_user()
>>
>>> +            context_range_set(context, user->level) !=3D 0) {
>>
>> sepol_context_set_mls()
>>
>>> +            goto fail;
>>> +        }
>>> +
>>> +        const char *new_context_str =3D context_str(context);
>>
>> sepol_context_to_string()
>>
>>> +        if (!ustr_replace_cstr(&line, old_context_str,
>>> +                       new_context_str, 1)) {
>>> +            goto fail;
>>> +        }
>>> +
>>> +        if (check_line(s, line) =3D=3D STATUS_SUCCESS) {
>>> +            if (!ustr_io_putfileline(&line, out)) {
>>> +                goto fail;
>>> +            }
>>> +        }
>>> +
>>> +        ustr_sc_free(&line);
>>> +        context_free(context);
>>
>> sepol_context_free()
>>
>>> +    }
>>> +
>>> +    return STATUS_SUCCESS;
>>> +fail:
>>> +    ustr_sc_free(&line);
>>> +    context_free(context);
>>> +    return STATUS_ERR;
>>> +}
>>> +
>>>  static int write_home_dir_context(genhomedircon_settings_t * s, FILE=

>>> * out,
>>>                    semanage_list_t * tpl, const
>>> genhomedircon_user_entry_t *user)
>>>  {
>>>      replacement_pair_t repl[] =3D {
>>> -        {.search_for =3D TEMPLATE_SEUSER,.replace_with =3D user->sen=
ame},
>>>          {.search_for =3D TEMPLATE_HOME_DIR,.replace_with =3D user->h=
ome},
>>>          {.search_for =3D TEMPLATE_ROLE,.replace_with =3D user->prefi=
x},
>>> -        {.search_for =3D TEMPLATE_LEVEL,.replace_with =3D user->leve=
l},
>>>          {NULL, NULL}
>>>      };
>>>
>>> @@ -618,7 +676,7 @@ static int
>>> write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
>>>              return STATUS_ERR;
>>>      }
>>>
>>> -    return write_replacements(s, out, tpl, repl);
>>> +    return write_user_replacements(s, out, tpl, repl, user);
>>>  }
>>>
>>>  static int write_home_root_context(genhomedircon_settings_t * s,
>>> FILE * out,
>>> @@ -640,11 +698,10 @@ static int
>>> write_username_context(genhomedircon_settings_t * s, FILE * out,
>>>          {.search_for =3D TEMPLATE_USERNAME,.replace_with =3D user->n=
ame},
>>>          {.search_for =3D TEMPLATE_USERID,.replace_with =3D user->uid=
},
>>>          {.search_for =3D TEMPLATE_ROLE,.replace_with =3D user->prefi=
x},
>>> -        {.search_for =3D TEMPLATE_SEUSER,.replace_with =3D user->sen=
ame},
>>>          {NULL, NULL}
>>>      };
>>>
>>> -    return write_replacements(s, out, tpl, repl);
>>> +    return write_user_replacements(s, out, tpl, repl, user);
>>>  }
>>>
>>>  static int write_user_context(genhomedircon_settings_t * s, FILE * o=
ut,
>>> @@ -653,11 +710,10 @@ static int
>>> write_user_context(genhomedircon_settings_t * s, FILE * out,
>>>      replacement_pair_t repl[] =3D {
>>>          {.search_for =3D TEMPLATE_USER,.replace_with =3D user->name}=
,
>>>          {.search_for =3D TEMPLATE_ROLE,.replace_with =3D user->prefi=
x},
>>> -        {.search_for =3D TEMPLATE_SEUSER,.replace_with =3D user->sen=
ame},
>>>          {NULL, NULL}
>>>      };
>>>
>>> -    return write_replacements(s, out, tpl, repl);
>>> +    return write_user_replacements(s, out, tpl, repl, user);
>>>  }
>>>
>>>  static int seuser_sort_func(const void *arg1, const void *arg2)
>>> @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t
>>> *get_users(genhomedircon_settings_t * s,
>>>          if (strcmp(name, DEFAULT_LOGIN) =3D=3D 0)
>>>              continue;
>>>
>>> -        if (strcmp(name, TEMPLATE_SEUSER) =3D=3D 0)
>>> -            continue;
>>> -
>>
>> This yields a warning/error on Fedora:
>> $ sudo semodule -B
>> libsemanage.add_user: user system_u not in password file
>>
>=20
> I can re-add this conditional to prevent outputting the warning, though=

> is there a reason for a login named "system_u" ?
>=20

Is that warning really useful in the first place though? My requirement
to create a gdm selinux id also causes these messages for user gdm when
ever semodule -B is run on systems that do not have the gdm user.

Can we not just print that message only when semodule is run with -v
instead?



>> And I end up with a slightly different file_contexts.homedirs:
>> @@ -39,7 +39,6 @@
>> /home/[^/]+/\.xauth.*    --    unconfined_u:object_r:xauth_home_t:s0
>> /home/[^/]+/\.Xauth.*    --    unconfined_u:object_r:xauth_home_t:s0
>> /home/[^/]+/\.local.*    unconfined_u:object_r:gconf_home_t:s0
>> -/home/[^/]+/\.gvfs/.*    <<none>>
>> /home/[^/]+/\.cache(/.*)?    unconfined_u:object_r:cache_home_t:s0
>> /home/[^/]+/\.gnupg(/.+)?    unconfined_u:object_r:gpg_secret_t:s0
>> /home/[^/]+/\.irssi(/.*)?    unconfined_u:object_r:irc_home_t:s0
>> @@ -51,7 +50,6 @@
>> /home/[^/]+/\.pyzor(/.*)?    unconfined_u:object_r:spamc_home_t:s0
>> /home/[^/]+/\.razor(/.*)?    unconfined_u:object_r:spamc_home_t:s0
>> /home/[^/]+/\.spamd(/.*)?    unconfined_u:object_r:spamc_home_t:s0
>> -/home/[^/]+/\.debug(/.*)?    <<none>>
>> /home/[^/]+/vmware(/.*)?    unconfined_u:object_r:vmware_file_t:s0
>> /home/[^/]+/\.fonts(/.*)?    unconfined_u:object_r:user_fonts_t:s0
>> /home/[^/]+/\.gconf(d)?(/.*)?    unconfined_u:object_r:gconf_home_t:s0=

>>
>> The homedir_template has:
>> ...
>> HOME_DIR/\.gvfs/.*      <<none>>
>> HOME_DIR/\.cache(/.*)?  system_u:object_r:cache_home_t:s0
>> HOME_DIR/\.gnupg(/.+)?  system_u:object_r:gpg_secret_t:s0
>> HOME_DIR/\.irssi(/.*)?  system_u:object_r:irc_home_t:s0
>> HOME_DIR/irclog(/.*)?   system_u:object_r:irc_home_t:s0
>> HOME_DIR/\.adobe(/.*)?  system_u:object_r:mozilla_home_t:s0
>> HOME_DIR/\.gnash(/.*)?  system_u:object_r:mozilla_home_t:s0
>> HOME_DIR/\.webex(/.*)?  system_u:object_r:mozilla_home_t:s0
>> HOME_DIR/\.pulse(/.*)?  system_u:object_r:pulseaudio_home_t:s0
>> HOME_DIR/\.pyzor(/.*)?  system_u:object_r:spamc_home_t:s0
>> HOME_DIR/\.razor(/.*)?  system_u:object_r:spamc_home_t:s0
>> HOME_DIR/\.spamd(/.*)?  system_u:object_r:spamc_home_t:s0
>> HOME_DIR/\.debug(/.*)?  <<none>>
>> ...
>>
>>
>=20
> Ah, sorry, missed a comparison in a check_line() call.  Will send a v2
> with this fixed.
>=20
>>>          /* find the user structure given the name */
>>>          u =3D bsearch(seuname, user_list, nusers,
>>> sizeof(semanage_user_t *),
>>>                  (int (*)(const void *, const void *))
>>>
>>
>=20
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--vV0PUobDVEHO8AkLpVVce7CVCmmpTJokl--

--x09LJl8B0N0qGfCSMSriao4I4Lkw4qAON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXz76eAAoJECV0jlU3+UdpeMcMALfbUYrAaTguVEJQrkfjkBXX
nbGtHTa3wcdnCDnE3oR8IlfrK7Z08Nk/QPUQdXqDZpYEx4ygwYQ9qg/+Trb1TrWa
bWQRgYBmy9yQo6anMjJbcioBP6i95sIji9KvuDtTYfEEpV4L6PgpPISLT+66WAxm
bqk2Zmh2Mwv0osXMLmx898lyu/UC50wXESpKYnNzDktTPZfihuYsQqfIeaUE9Zv5
7yzhpEAvzuf6y6Y4nqHFK/jFCo1ToGXtDO79P//IUTp+OL3kimm6n+0R2b/pqCsR
ZXz/ojMu6ZFVvNkfV6yaiCTrwgixCa+13Cs6/hpPlLZlkZeDLQc7pz2OAWUc2ETt
NMfbfS8YohjM31c2pe3b1bdehjaXq0PTqy2G0zELzdSLtnIm+GjYBrPpLeVUofF1
TObd1EbPPli17NtZgVTK8iejL2s5luLjiTLuCWF4WNEd5mPaMzxi4NPyfqAVywI4
M88EzKgQEfQZ4lChnKo0oJIeaXZSuA69+GvyZcv7OA==
=3QzR
-----END PGP SIGNATURE-----

--x09LJl8B0N0qGfCSMSriao4I4Lkw4qAON--
