Subject: Re: [PATCH] semanage: correct fcontext auditing
To: Miroslav Vadkerti <mvadkert@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
 <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
 <CAGFJcwy=ccptSEnJVOX8ArK7y-MXYZK_tfMY-YcurJU9wTU-7g@mail.gmail.com>
 <CAGFJcwzEW0DG1i5u3p1QRJ9-D40vLMSwu2FAsyU9rRiAAwTPtw@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <6e95d55a-cc29-0b53-fa07-06112ce4de09@gmail.com>
Date: Mon, 15 Aug 2016 11:16:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAGFJcwzEW0DG1i5u3p1QRJ9-D40vLMSwu2FAsyU9rRiAAwTPtw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7G6gT10bMNTtFpDEmXBpbN1a48qvC8mBp"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7G6gT10bMNTtFpDEmXBpbN1a48qvC8mBp
Content-Type: multipart/mixed; boundary="OpQGIBEEVpqAFgETcnpeB6UWeO1iSp7i6"
From: Dominick Grift <dac.override@gmail.com>
To: Miroslav Vadkerti <mvadkert@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <6e95d55a-cc29-0b53-fa07-06112ce4de09@gmail.com>
Subject: Re: [PATCH] semanage: correct fcontext auditing
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
 <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
 <CAGFJcwy=ccptSEnJVOX8ArK7y-MXYZK_tfMY-YcurJU9wTU-7g@mail.gmail.com>
 <CAGFJcwzEW0DG1i5u3p1QRJ9-D40vLMSwu2FAsyU9rRiAAwTPtw@mail.gmail.com>
In-Reply-To: <CAGFJcwzEW0DG1i5u3p1QRJ9-D40vLMSwu2FAsyU9rRiAAwTPtw@mail.gmail.com>

--OpQGIBEEVpqAFgETcnpeB6UWeO1iSp7i6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2016 10:55 AM, Miroslav Vadkerti wrote:
> Anyway, could we have this patch applied and sort out a better way
> of supplying defaults later please?
>=20

I hope you do realize that this also affects your customers by
essentially forcing them to use your identifiers. with these MLS
identifiers that is not a big deal but with system_u it is a bigger deal
because now your customers will have to work around this if they wish to
take advantage of CIL and its namespace features by namespacing selinux
user identities.

> Thanks,
> /M
>=20
> On Mon, Aug 15, 2016 at 8:33 AM, Miroslav Vadkerti <mvadkert@redhat.com=
>
> wrote:
>=20
>> On Fri, Aug 12, 2016 at 4:58 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>>
>>> On 08/12/2016 10:22 AM, Dominick Grift wrote:
>>>> On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:
>>>>> For modify action actually audit the selinux type, i.e. use
>>>>> setype variable.
>>>>>
>>>>> For deleting equal fcontext rules do not audit ftype, as the
>>>>> ftype value for equal rules makes little sense.
>>>>>
>>>>> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com> ---
>>>>> policycoreutils/semanage/seobject.py | 4 ++-- 1 file changed, 2
>>>>> insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/policycoreutils/semanage/seobject.py
>>>>> b/policycoreutils/semanage/seobject.py index 786ed0e..8d3088c
>>>>> 100644 --- a/policycoreutils/semanage/seobject.py +++
>>>>> b/policycoreutils/semanage/seobject.py @@ -1992,7 +1992,7 @@
>>>>> class fcontextRecords(semanageRecords): if not seuser: seuser =3D
>>>>> "system_u"
>>>>
>>>> system_u is reference policy specific. this is selinux user space
>>>> not reference policy user space.
>>>
>>> Yes, that's pre-existing though (not added by this patch), and
>>> unfortunately pervasive throughout seobject.py.
>>>
>>> I guess we'll need to decide how to provide this information so that
>>> it doesn't have to be hardcoded in seobject.py, e.g. yet another
>>> policy configuration file with default values for each security
>>> context field?
>>>
>>
>> =E2=80=8BThe same issue might apply for serange, which also
>> can be an empty string and thus gets audited badly
>> if not some default value.
>>
>>
>>>
>>>>
>>>>>
>>>>> -        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s
>>>>> ftype=3D%s tcontext=3D%s:%s:%s:%s" %
>>>>> (audit.audit_encode_nv_string("tglob", target, 0),
>>>>> ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
>>>>> self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=3D%s
>>>>> tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob",
>>>>> target, 0), ftype_to_audit[ftype], seuser, "object_r", setype,
>>>>> serange))
>>>>>
>>>>> def modify(self, target, setype, ftype, serange, seuser):
>>>>> self.begin() @@ -2030,7 +2030,7 @@ class
>>>>> fcontextRecords(semanageRecords): self.equiv.pop(target)
>>>>> self.equal_ind =3D True
>>>>>
>>>>> -            self.mylog.log_change("resrc=3Dfcontext
>>>>> op=3Ddelete-equal %s ftype=3D%s" %
>>>>> (audit.audit_encode_nv_string("tglob", target, 0),
>>>>> ftype_to_audit[ftype])) +
>>>>> self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal %s" %
>>>>> (audit.audit_encode_nv_string("tglob", target, 0)))
>>>>>
>>>>> return
>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________ Selinux mailing
>>>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>>>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>>>> "help" to Selinux-request@tycho.nsa.gov.
>>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>>
>>
>>
>> --
>> Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
>> IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
>> Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
>> Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR
>>
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--OpQGIBEEVpqAFgETcnpeB6UWeO1iSp7i6--

--7G6gT10bMNTtFpDEmXBpbN1a48qvC8mBp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXsYh3AAoJECV0jlU3+Udp2VAL/0BnvlWOC+xDVZbO+b6G5Zpj
PzU5YhVblm3wUyx5Yq+dZCZ5oCAdapA+YiqM6fC/5+FtBweVtQv1ItTpq/ZpYmUI
JbGJxKWgr2nQihyTCkg7BjEhdxW9mFUzwbPTP6sZ58xr3s2WYq2uX4ZOw7Z7NUU1
ivjylfljOSUqwqIV6XYbrSOHMsULKaI0GIfAZm84lyq7I2HCi7ZDyX+KWVDk7Nl/
m1on/6BC2KLd2nAk8d6rvRD4FMQNsDm1zq8n0aVXdjm8P5qjBMXeKV5INofWUmsf
QzCck86MZSbHhvrAuMGpOPWy7i3uFEHcAPQBzlsztXf7Bivj6fSMyM7YUOg4wGty
1/G7fR/kz3jYZoMvAFcBlyjmmJ/AML8+jmIoyioKs0C5+Mwu/WUnbxhf/mtyRYN1
Q9Gv8YQnFZkjz5Q7up9+vmi+HVYJCojcjx5sCD2K/pvbupCYuhgxg86zqQO2MxLl
MZgFM6bgoaQPhEcIHXfvMMiRsoNKHt3qhEF0LRCHQA==
=kfu7
-----END PGP SIGNATURE-----

--7G6gT10bMNTtFpDEmXBpbN1a48qvC8mBp--
