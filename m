Subject: Re: [PATCH 1/3] sandbox: tests - use sandbox from cwd
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
 <222079cc-0363-6e7a-ece2-ddec119a14ce@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <2ce87052-2f14-bf5a-c18c-34f91cd3662c@redhat.com>
Date: Thu, 15 Sep 2016 20:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <222079cc-0363-6e7a-ece2-ddec119a14ce@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ekqp1Jf0JkqtFMVkmXhNSsjL7jaexttnw"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ekqp1Jf0JkqtFMVkmXhNSsjL7jaexttnw
Content-Type: multipart/mixed; boundary="NnGGhFmlTalp9LSe5SGlTMx9xKvxXPpG9";
 protected-headers="v1"
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <2ce87052-2f14-bf5a-c18c-34f91cd3662c@redhat.com>
Subject: Re: [PATCH 1/3] sandbox: tests - use sandbox from cwd
References: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
 <222079cc-0363-6e7a-ece2-ddec119a14ce@tycho.nsa.gov>
In-Reply-To: <222079cc-0363-6e7a-ece2-ddec119a14ce@tycho.nsa.gov>

--NnGGhFmlTalp9LSe5SGlTMx9xKvxXPpG9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2016 07:26 PM, Stephen Smalley wrote:
> On 09/15/2016 10:39 AM, Petr Lautrbach wrote:
>> The tests executed sandbox from $PATH while they should test sandbox i=
n
>> cwd. At the same time, tests should be run using the same python as is=

>> used by make to run them.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Do the sandbox tests actually work for you?  For me, most of them fail
> with the error:
> AssertionError: "Sandbox should have succeeded for this test 'ERROR:
> could not find datum for type sandbox_t\nsandbox: Sandbox Policy is not=

> currently installed.\nYou need to install the selinux-policy-sandbox
> package in order to run this command\n'
>=20
> But I do have selinux-policy-sandbox installed.  This is on F24.
> sandbox_x_t is defined, but not sandbox_t.

The tests work for me with both pythons on Fedora 24.

For sandbox_t you need to enable sandbox module:

semodule -e sandbox

It should be enabled by default when you install selinux-policy-sandbox.
But there's probably a bug which causes the module is not enabled in
some cases.

Simon Sekidde suggested to change the error message a little, see
bellow. But it probably won't be sufficient as well.

             try:
                 sepolicy.info(sepolicy.TYPE, "sandbox_t")
             except RuntimeError:
-                raise ValueError(_("Sandbox Policy is not currently
installed.\nYou need to install the selinux-policy-sandbox package in
order to run this command"))
+                raise ValueError(_("Sandbox Policy is currently
disabled.\nYou need to enable the sandbox module in order to run this
command"))


It would need a detection if the module is only disabled or is not
installed at all.


Petr


>=20
>> ---
>>  policycoreutils/sandbox/test_sandbox.py | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/policycoreutils/sandbox/test_sandbox.py b/policycoreutils=
/sandbox/test_sandbox.py
>> index 6f54d0c..d5368c2 100644
>> --- a/policycoreutils/sandbox/test_sandbox.py
>> +++ b/policycoreutils/sandbox/test_sandbox.py
>> @@ -1,6 +1,7 @@
>>  import unittest
>>  import os
>>  import shutil
>> +import sys
>>  from tempfile import mkdtemp
>>  from subprocess import Popen, PIPE
>> =20
>> @@ -26,63 +27,63 @@ class SandboxTests(unittest.TestCase):
>>      def test_simple_success(self):
>>          "Verify that we can read file descriptors handed to sandbox"
>>          p1 =3D Popen(['cat', '/etc/passwd'], stdout=3DPIPE)
>> -        p2 =3D Popen(['sandbox', 'grep', 'root'], stdin=3Dp1.stdout, =
stdout=3DPIPE)
>> +        p2 =3D Popen([sys.executable, 'sandbox', 'grep', 'root'], std=
in=3Dp1.stdout, stdout=3DPIPE)
>>          out, err =3D p2.communicate()
>>          self.assertTrue(b'root' in out)
>> =20
>>      def test_cant_kill(self):
>>          "Verify that we cannot send kill signal in the sandbox"
>>          pid =3D os.getpid()
>> -        p =3D Popen(['sandbox', 'kill', '-HUP', str(pid)], stdout=3DP=
IPE, stderr=3DPIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', 'kill', '-HUP', str(p=
id)], stdout=3DPIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertDenied(err)
>> =20
>>      def test_cant_ping(self):
>>          "Verify that we can't ping within the sandbox"
>> -        p =3D Popen(['sandbox', 'ping', '-c 1 ', '127.0.0.1'], stdout=
=3DPIPE, stderr=3DPIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', 'ping', '-c 1 ', '127=
=2E0.0.1'], stdout=3DPIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertDenied(err)
>> =20
>>      def test_cant_mkdir(self):
>>          "Verify that we can't mkdir within the sandbox"
>> -        p =3D Popen(['sandbox', 'mkdir', '~/test'], stdout=3DPIPE, st=
derr=3DPIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', 'mkdir', '~/test'], s=
tdout=3DPIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertFailure(p.returncode)
>> =20
>>      def test_cant_list_homedir(self):
>>          "Verify that we can't list homedir within the sandbox"
>> -        p =3D Popen(['sandbox', 'ls', '~'], stdout=3DPIPE, stderr=3DP=
IPE)
>> +        p =3D Popen([sys.executable, 'sandbox', 'ls', '~'], stdout=3D=
PIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertFailure(p.returncode)
>> =20
>>      def test_cant_send_mail(self):
>>          "Verify that we can't send mail within the sandbox"
>> -        p =3D Popen(['sandbox', 'mail'], stdout=3DPIPE, stderr=3DPIPE=
)
>> +        p =3D Popen([sys.executable, 'sandbox', 'mail'], stdout=3DPIP=
E, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertDenied(err)
>> =20
>>      def test_cant_sudo(self):
>>          "Verify that we can't run sudo within the sandbox"
>> -        p =3D Popen(['sandbox', 'sudo'], stdout=3DPIPE, stderr=3DPIPE=
)
>> +        p =3D Popen([sys.executable, 'sandbox', 'sudo'], stdout=3DPIP=
E, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertFailure(p.returncode)
>> =20
>>      def test_mount(self):
>>          "Verify that we mount a file system"
>> -        p =3D Popen(['sandbox', '-M', 'id'], stdout=3DPIPE, stderr=3D=
PIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', '-M', 'id'], stdout=3D=
PIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertSuccess(p.returncode, err)
>> =20
>>      def test_set_level(self):
>>          "Verify that we set level a file system"
>> -        p =3D Popen(['sandbox', '-l', 's0', 'id'], stdout=3DPIPE, std=
err=3DPIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', '-l', 's0', 'id'], st=
dout=3DPIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          self.assertSuccess(p.returncode, err)
>> =20
>>      def test_homedir(self):
>>          "Verify that we set homedir a file system"
>>          homedir =3D mkdtemp(dir=3D".", prefix=3D".sandbox_test")
>> -        p =3D Popen(['sandbox', '-H', homedir, '-M', 'id'], stdout=3D=
PIPE, stderr=3DPIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', '-H', homedir, '-M', =
'id'], stdout=3DPIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          shutil.rmtree(homedir)
>>          self.assertSuccess(p.returncode, err)
>> @@ -90,7 +91,7 @@ class SandboxTests(unittest.TestCase):
>>      def test_tmpdir(self):
>>          "Verify that we set tmpdir a file system"
>>          tmpdir =3D mkdtemp(dir=3D"/tmp", prefix=3D".sandbox_test")
>> -        p =3D Popen(['sandbox', '-T', tmpdir, '-M', 'id'], stdout=3DP=
IPE, stderr=3DPIPE)
>> +        p =3D Popen([sys.executable, 'sandbox', '-T', tmpdir, '-M', '=
id'], stdout=3DPIPE, stderr=3DPIPE)
>>          out, err =3D p.communicate()
>>          shutil.rmtree(tmpdir)
>>          self.assertSuccess(p.returncode, err)
>>
>=20


--=20
Petr Lautrbach



--NnGGhFmlTalp9LSe5SGlTMx9xKvxXPpG9--

--ekqp1Jf0JkqtFMVkmXhNSsjL7jaexttnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX2ud8AAoJEGOorUuYLENzt9kQAITSKqd7S8Q3BjMMoAvuzikM
q/a+uX/I96jDdFB+8yxI2+kw2PF3CVb2J8JMafIz8bmpfg3gj42ENdI1x1SQgFwa
BoyR4xRsag8YsHWC7b7G+wLr/fLe1XVmuNWy/AAfJMqVWPgFuczGG8ro5/Q5Gj6y
09uXb4kNP8/6ixVxow2igdOrCuXJCzNbZiJaLHlMsyP2O2nq2YwrPQo1C7h9/cL3
AiewIf7vmAskr1oNf+mStyhxaaUZBX3cFxva/4ntzWogQV4fXr104n14rw86hh6m
WP5XIBzwtzRqQTxMfXINh7FLB6UpTIUAeym8TzEK7rjiUX+HqrHM2bWRqK8JjaX3
0HNCol/z/MX6TZw9HM3RGawb95yaFNc0owITY0ivnWbpXh+WxSRzlRMjE0Pn8xiQ
0Xl7y8QTYAEwnqeNEwC6gKSU/OIBWABiR1Z6FAmyt8lIwrN5KfBUUrdv+C6FUfB4
WnqFfifdvHcAGwuF/1TzkOJdGZl9ana1K+InltJ0Hget23d29goZuGIgNqKWHH/4
2D8MdiIRnrictCIk6bcV2gYrTvIV/GnPTTWIBMT4bg6K8dnz6vaxBJVgO2GKevKa
np/ssfk8X/qF2LNb1voSZ1kGovwJ6lUZg45lIvmibf3O42TJ/OwQx/LIXqnaVayM
meRqrf17yicKUnHl/OIZ
=xG3W
-----END PGP SIGNATURE-----

--ekqp1Jf0JkqtFMVkmXhNSsjL7jaexttnw--
