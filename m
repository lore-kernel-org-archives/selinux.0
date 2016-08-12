Subject: Re: [PATCH] semanage: correct fcontext auditing
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
 <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <7e8015e4-cd7d-1cb2-8490-7080b8f41215@gmail.com>
Date: Fri, 12 Aug 2016 17:00:00 +0200
MIME-Version: 1.0
In-Reply-To: <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WwUn2tnxLgiqQsCqh49ISBhJCPEbfM9tm"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwUn2tnxLgiqQsCqh49ISBhJCPEbfM9tm
Content-Type: multipart/mixed; boundary="Ut1fhDmXn3kWbvrUWPSAehjaqhpBtvSVT"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <7e8015e4-cd7d-1cb2-8490-7080b8f41215@gmail.com>
Subject: Re: [PATCH] semanage: correct fcontext auditing
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
 <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
In-Reply-To: <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>

--Ut1fhDmXn3kWbvrUWPSAehjaqhpBtvSVT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2016 04:58 PM, Stephen Smalley wrote:
> On 08/12/2016 10:22 AM, Dominick Grift wrote:
>> On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:
>>> For modify action actually audit the selinux type, i.e. use
>>> setype variable.
>>>
>>> For deleting equal fcontext rules do not audit ftype, as the
>>> ftype value for equal rules makes little sense.
>>>
>>> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com> ---=20
>>> policycoreutils/semanage/seobject.py | 4 ++-- 1 file changed, 2
>>> insertions(+), 2 deletions(-)
>>>
>>> diff --git a/policycoreutils/semanage/seobject.py
>>> b/policycoreutils/semanage/seobject.py index 786ed0e..8d3088c
>>> 100644 --- a/policycoreutils/semanage/seobject.py +++
>>> b/policycoreutils/semanage/seobject.py @@ -1992,7 +1992,7 @@
>>> class fcontextRecords(semanageRecords): if not seuser: seuser =3D
>>> "system_u"
>>
>> system_u is reference policy specific. this is selinux user space
>> not reference policy user space.
>=20
> Yes, that's pre-existing though (not added by this patch), and
> unfortunately pervasive throughout seobject.py.
>=20
> I guess we'll need to decide how to provide this information so that
> it doesn't have to be hardcoded in seobject.py, e.g. yet another
> policy configuration file with default values for each security
> context field?

I would not mind that if that is the best approach.

Those object_r occurrences raise another question. Should we be
"supporting" defaultrole source (RBACSEP) or not (i suppose we should)

>=20
>>
>>>
>>> -        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s
>>> ftype=3D%s tcontext=3D%s:%s:%s:%s" %
>>> (audit.audit_encode_nv_string("tglob", target, 0),
>>> ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
>>> self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=3D%s
>>> tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob",
>>> target, 0), ftype_to_audit[ftype], seuser, "object_r", setype,
>>> serange))
>>>
>>> def modify(self, target, setype, ftype, serange, seuser):=20
>>> self.begin() @@ -2030,7 +2030,7 @@ class
>>> fcontextRecords(semanageRecords): self.equiv.pop(target)=20
>>> self.equal_ind =3D True
>>>
>>> -            self.mylog.log_change("resrc=3Dfcontext
>>> op=3Ddelete-equal %s ftype=3D%s" %
>>> (audit.audit_encode_nv_string("tglob", target, 0),
>>> ftype_to_audit[ftype])) +
>>> self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal %s" %
>>> (audit.audit_encode_nv_string("tglob", target, 0)))
>>>
>>> return
>>>
>>>
>>
>>
>>
>>
>> _______________________________________________ Selinux mailing
>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>> "help" to Selinux-request@tycho.nsa.gov.
>>
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--Ut1fhDmXn3kWbvrUWPSAehjaqhpBtvSVT--

--WwUn2tnxLgiqQsCqh49ISBhJCPEbfM9tm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXreRwAAoJECV0jlU3+UdpYvsL/Rha6czOi891aYfeKh0n2m9b
t1Bsgohpg2oEtxNYIU1KUjtNIEes3V3WQLqzn8HUxOq44/fqRP/5cO4TU+A3d94l
SFtucp3NqjkiiKU1/4ub2d127jacjTmBUx42/kXOR6OhLPiu1Oiu0QKSWIVzrkyC
lY7qLFLk4wUoCfBAG5hdXthfWI2zcn5fqiZ/rM+EKqvd3E15WBYzLSFsD4nhJJVR
u2cvrNiUGi96kQRvCi8XzojmXmj0Hohs2c8LLsGN7nFDXlntX6L+XFUwQ62NLTY8
j9hOmGUqT8Fi6v9Imp6h0PzhXaXhvlKA2k9rn6XrROkNUWmtu05BdZ69+3itJVzN
f1khQKYTyudYDaN5K6uxioFU5hpI26u3eksTaZDyIem/ddgm5phcyx8vMck2vGPI
bkDQCFV1Q9xppaUv4yaupj4SxyD86kMWxbl955hfyv8kt5pgU7irrM4NHppx4e59
PhGBPDZtGadycOUewevI0tVFDVIC62ErZsJGaKDbjg==
=4+Rk
-----END PGP SIGNATURE-----

--WwUn2tnxLgiqQsCqh49ISBhJCPEbfM9tm--
