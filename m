Subject: Re: sandox -X not working with recent Xephyr
To: Stephen Smalley <sds@tycho.nsa.gov>
References: <940febc8-d309-bab6-9797-11c07cf722fb@debian.org>
 <de735099-3871-b9b6-a4cc-8dc67b36e58e@tycho.nsa.gov>
 <20160919180219.tbmq7yx66wkbk3if@rhel-at-redhat.localdomain>
 <c8e7f2ad-72eb-2175-5916-e5054e431e48@tycho.nsa.gov>
 <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>
Cc: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <43c73baa-fc08-7c50-09cf-e03e12408853@redhat.com>
Date: Tue, 20 Sep 2016 23:56:50 +0200
MIME-Version: 1.0
In-Reply-To: <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XTtO7P03ejEr8eXkoBJOkmlExLDvfSM7G"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XTtO7P03ejEr8eXkoBJOkmlExLDvfSM7G
Content-Type: multipart/mixed; boundary="DRxMG4CabVEnJjhqCFmk2dQs67i5wWf6d";
 protected-headers="v1"
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Message-ID: <43c73baa-fc08-7c50-09cf-e03e12408853@redhat.com>
Subject: Re: sandox -X not working with recent Xephyr
References: <940febc8-d309-bab6-9797-11c07cf722fb@debian.org>
 <de735099-3871-b9b6-a4cc-8dc67b36e58e@tycho.nsa.gov>
 <20160919180219.tbmq7yx66wkbk3if@rhel-at-redhat.localdomain>
 <c8e7f2ad-72eb-2175-5916-e5054e431e48@tycho.nsa.gov>
 <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>
In-Reply-To: <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>

--DRxMG4CabVEnJjhqCFmk2dQs67i5wWf6d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2016 02:49 PM, Stephen Smalley wrote:
> On 09/19/2016 02:26 PM, Stephen Smalley wrote:
>> On 09/19/2016 02:02 PM, Petr Lautrbach wrote:
>>> On Mon, Sep 19, 2016 at 10:39:45AM -0400, Stephen Smalley wrote:
>>>> On 09/18/2016 02:39 PM, Laurent Bigonville wrote:
>>>>> Hi,
>>>>>
>>>>> It seems that sandbox -X is not working anymore on debian.
>>>>>
>>>>> Xephyr (1.18.4) is giving me the following error:
>>>>>
>>>>> _XSERVTransmkdir: ERROR: euid !=3D 0,directory /tmp/.X11-unix will =
not be
>>>>> created.
>>>>>
>>>>> The X socket is not created inside the sandbox and then the applica=
tion
>>>>> can obviously not connect to it.
>>>>>
>>>>> I'm not sure how this could be fixed, maybe let's seunshare create =
that
>>>>> directory?
>>>>
>>>> I don't see this error on Fedora, which also has Xephyr 1.18.4, so m=
aybe
>>>> they have a fix?
>>>>
>>>> That is using the Fedora policycoreutils-sandbox package, which yiel=
ds a
>>>> functioning sandbox -X, e.g. sandbox -X firefox works correctly.
>>>>
>>>> However, if I install sandbox from upstream, e.g.
>>>>
>>>> cd selinux
>>>> sudo make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install install-pywr=
ap relabel
>>>>
>>>> then sandbox -X firefox fails immediately, and I have the following =
in
>>>> the audit log:
>>>> type=3DSELINUX_ERR msg=3Daudit(1474295659.424:2189):
>>>> op=3Dsecurity_bounded_transition seresult=3Ddenied
>>>> oldcontext=3Dunconfined_u:unconfined_r:sandbox_x_t:s0:c658,c1002
>>>> newcontext=3Dunconfined_u:unconfined_r:sandbox_x_client_t:s0:c658,c1=
002
>>>
>>> It's most likely not related. Same error can be seen in stock Fedora.=

>>>
>>>> So I guess there are other patches in the Fedora package that are ne=
eded?
>>>
>>> It's this patch
>>> https://github.com/fedora-selinux/selinux/commit/2540625875ebdfe0ef48=
798437288e8a07aa853d
>>>
>>> But the patch bellow works too:
>>>
>>> --- a/policycoreutils/sandbox/sandboxX.sh
>>> +++ b/policycoreutils/sandbox/sandboxX.sh
>>> @@ -20,7 +20,7 @@ cat > ~/.config/openbox/rc.xml << EOF
>>>  </openbox_config>
>>>  EOF
>>> =20
>>> -(/usr/bin/Xephyr -resizeable -title "$TITLE" -terminate -screen $SCR=
EENSIZE -dpi $DPI -nolisten tcp -displayfd 5 5>&1 2>/dev/null) | while re=
ad D; do
>>> +(/usr/bin/Xephyr -resizeable -title "$TITLE" -screen $SCREENSIZE -dp=
i $DPI -nolisten tcp -displayfd 5 5>&1 2>/dev/null) | while read D; do
>>>      export DISPLAY=3D:$D
>>>      cat > ~/seremote << __EOF
>>>  #!/bin/sh
>>>
>>>
>>>
>>> I'm not sure which one is correct.
>>
>> I don't know either, but the one above does work and seems simpler, so=

>> let's go with that one.
>=20
> So, if you could re-spin that with a proper subject and signed-off-by,
> that would be great.
>=20
>=20

I'll send the patch tomorrow.

In the mean time I try to find out what and I why.

It's the xmodmap command at the beginning of ~/.sandboxrc which doesn't
work and probably resets the server which terminates itself then.

With the following hack I'm able to run Xephyr with -terminate and with
working xmodmap:

--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -282,8 +282,9 @@ class Sandbox:
                 command +=3D "'%s' " % p
             fd.write("""#! /bin/sh
 #TITLE: %s
-/usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
 %s &
+sleep 1
+/usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
 WM_PID=3D$!
 dbus-launch --exit-with-session %s


Petr
--=20
Petr Lautrbach



--DRxMG4CabVEnJjhqCFmk2dQs67i5wWf6d--

--XTtO7P03ejEr8eXkoBJOkmlExLDvfSM7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX4bCnAAoJEGOorUuYLENzvvYQAIAiumk8J0/f3IzkY5yeAH3M
FPzk/yRe0KK+LB0U54qr2iLIJxZX31S2zRrTljsJvt0cpkBlI/EU+IHvxYv1YbgM
MbO3L403kRMUSaer4CVYw2eo1qAB3n1Jz59L2rrAnf5/ofKKzB0tHGLZKA7/rjvY
sJHUEWz3ZZHBDlhgNC+X1HvRkANWummKyRJdN+shBPOH1hZLb5fajOMUw68DUKRn
37amEFalLfKG7wrAuojhQqZ31iuCVnWhPWxEHJlLfPv3r5wWc+a4WCW+peCwiz0d
YGHrOw/j2Iv/CPVCG3Zdhwx9WHQHNyaJyZOO3b+G9cNrb7Sqn7Z1OaIZnIV2ik0l
sWHsXbGji0bJZ6JxHyrl2Rp4tPSoow3kqYBM0/E2KOsuw2b4qJI41yDPjIRH9b2n
2q4eZCmMwcQb4zi+0NGeBdXtuaS5QWbJTJpaOO8hYz3gv6fI2+OMGzuLk8jcTz8t
pBtWIFDXAXHNW6hQuJc6MPdVdF0M834SFpYTZs+9bzJ8R7YlgnCoC2zLu32vv8/8
JESY2IVc2fpxxDZ9ndKdfrbT3yDk0m8DYcYdqkSyN2I9+mWtJKwjChlTJ4G0pQTW
bCl3xYhcnouCWUxgoANyCcntKLFh/F1BKaa0IEtgJiEMCcesWNwR7vZFJ6uw7b3I
/lqR322m5Sxpt98Ws0YS
=uDr7
-----END PGP SIGNATURE-----

--XTtO7P03ejEr8eXkoBJOkmlExLDvfSM7G--
