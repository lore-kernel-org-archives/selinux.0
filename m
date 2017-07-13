Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6DJhk3r009492
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 15:43:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id u23so7071804wma.2
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 12:43:27 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id d36sm2871705edb.63.2017.07.13.12.43.24
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Jul 2017 12:43:24 -0700 (PDT)
Date: Thu, 13 Jul 2017 21:43:23 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170713194323.GC13350@julius.enp8s0.d30>
References: <7596a965-4283-94ae-eb34-796e5979f288@ieee.org>
 <1499949843.624.0.camel@tycho.nsa.gov>
 <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
 <1499960906.624.3.camel@tycho.nsa.gov>
 <1499961595.624.5.camel@tycho.nsa.gov>
 <20170713165557.GA28835@julius.enp8s0.d30>
 <1499969620.624.16.camel@tycho.nsa.gov>
 <20170713181614.GB28835@julius.enp8s0.d30>
 <1499974196.624.20.camel@tycho.nsa.gov>
 <20170713192843.GB13350@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
In-Reply-To: <20170713192843.GB13350@julius.enp8s0.d30>
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 09:28:43PM +0200, Dominick Grift wrote:
> On Thu, Jul 13, 2017 at 03:29:56PM -0400, Stephen Smalley wrote:
> > On Thu, 2017-07-13 at 20:16 +0200, Dominick Grift wrote:
> > > On Thu, Jul 13, 2017 at 02:13:40PM -0400, Stephen Smalley wrote:
> > > > On Thu, 2017-07-13 at 18:55 +0200, Dominick Grift wrote:
> > > > > On Thu, Jul 13, 2017 at 11:59:55AM -0400, Stephen Smalley wrote:
> > > > > > On Thu, 2017-07-13 at 11:48 -0400, Stephen Smalley wrote:
> > > > > > > On Thu, 2017-07-13 at 09:25 -0400, Paul Moore wrote:
> > > > > > > > On Thu, Jul 13, 2017 at 8:44 AM, Stephen Smalley <sds@tycho
> > > > > > > > .nsa
> > > > > > > > .gov
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > wrote:
> > > > > > > > > On Wed, 2017-07-12 at 20:27 -0400, Chris PeBenito wrote:
> > > > > > > > > > On 07/12/2017 05:38 PM, Paul Moore wrote:
> > > > > > > > > > > On Wed, Jul 12, 2017 at 9:26 AM, Stephen Smalley <sds
> > > > > > > > > > > @tyc
> > > > > > > > > > > ho.n
> > > > > > > > > > > sa
> > > > > > > > > > > .gov
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > On Tue, 2017-07-11 at 17:00 -0400, Paul Moore
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley
> > > > > > > > > > > > > <sds
> > > > > > > > > > > > > @tyc
> > > > > > > > > > > > > ho
> > > > > > > > > > > > > .nsa
> > > > > > > > > > > > > .gov>
> > > > > > > > > > > > > wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > While I think splitting the NNP/nosuid transition
> > > > > > > > > > > restrictions
> > > > > > > > > > > might
> > > > > > > > > > > be a good idea under the new policy capability, I'm
> > > > > > > > > > > not
> > > > > > > > > > > sure
> > > > > > > > > > > it
> > > > > > > > > > > is
> > > > > > > > > > > worth the cost of a "process2" object class.
> > > > > > > > > > >=20
> > > > > > > > > > > With that in mind, let's do two things with this
> > > > > > > > > > > patch:
> > > > > > > > > > >=20
> > > > > > > > > > > * Mention the nosuid restrictions in the patch
> > > > > > > > > > > description.=A0=A0It
> > > > > > > > > > > doesn't need much text, but something would be good
> > > > > > > > > > > so we
> > > > > > > > > > > have
> > > > > > > > > > > documentation in the git log.
> > > > > > > > > > >=20
> > > > > > > > > > > * Let's pick a new permission name that is not
> > > > > > > > > > > specific
> > > > > > > > > > > to
> > > > > > > > > > > NNP
> > > > > > > > > > > or
> > > > > > > > > > > nosuid.=A0=A0IMHO, nnpnosuid_transition is ... less t=
han
> > > > > > > > > > > good.
> > > > > > > > > > > Unfortunately, I'm not sure I'm much better at
> > > > > > > > > > > picking
> > > > > > > > > > > names;
> > > > > > > > > > > how
> > > > > > > > > > > about
> > > > > > > > > > > "protected_transition"?=A0=A0"restricted_transition"?
> > > > > > > > > > > "enable_transition"?=A0=A0"override_transition"?
> > > > > > > > > >=20
> > > > > > > > > > I vote for nnp_transition anyway.=A0=A0"No New Privileg=
es"
> > > > > > > > > > encompasses
> > > > > > > > > > nosuid in my mind.=A0=A0If the two perms had been separ=
ated
> > > > > > > > > > I
> > > > > > > > > > would
> > > > > > > > > > have
> > > > > > > > > > been inclined to allow both every time one of them was
> > > > > > > > > > needed,
> > > > > > > > > > to
> > > > > > > > > > make
> > > > > > > > > > sure no one was surprised by the behavior difference.
> > > > > > > > >=20
> > > > > > > > > I agree; I'll keep it as nnp_transition and just document
> > > > > > > > > it
> > > > > > > > > in
> > > > > > > > > the
> > > > > > > > > patch description.
> > > > > > > >=20
> > > > > > > > Sorry to be a stubborn about this, but nnp_transition makes
> > > > > > > > little
> > > > > > > > sense for the nosuid restriction.=A0=A0Like it or not, NNP =
has
> > > > > > > > a
> > > > > > > > concrete
> > > > > > > > meaning which is distinct from nosuid mounts.=A0=A0We don't
> > > > > > > > have to
> > > > > > > > pick
> > > > > > > > any of the permission names I tossed out, none of those
> > > > > > > > were
> > > > > > > > very
> > > > > > > > good, but I would like to see something that takes both NNP
> > > > > > > > and
> > > > > > > > nosuid
> > > > > > > > into account, or preferably something that doesn't use
> > > > > > > > either
> > > > > > > > name
> > > > > > > > explicitly but still conveys the meaning.
> > > > > > >=20
> > > > > > > NNP is essentially a superset of nosuid; it applies to all
> > > > > > > execve()
> > > > > > > calls by the process and its descendants rather than only to
> > > > > > > execve()
> > > > > > > calls on specially marked filesystems.=A0=A0So I viewed it as=
 the
> > > > > > > more
> > > > > > > general term.
> > > > > > >=20
> > > > > > > If that's not viable, I can't think of anything clearer or
> > > > > > > better
> > > > > > > than
> > > > > > > nnp_nosuid_transition.=A0=A0That clearly links it to what it
> > > > > > > means
> > > > > > > (allow
> > > > > > > a
> > > > > > > SELinux domain transition under NNP or nosuid).=A0=A0It is
> > > > > > > somewhat
> > > > > > > ugly
> > > > > > > and verbose but it is clear in what it means, which I think
> > > > > > > is
> > > > > > > more
> > > > > > > important. All of your suggestions IMHO were less clear since
> > > > > > > they
> > > > > > > had
> > > > > > > no clear linkage to either NNP or nosuid, and I couldn't tell
> > > > > > > from
> > > > > > > reading the permission name what it meant.=A0=A0The SELinux
> > > > > > > domain
> > > > > > > transition isn't protected, it isn't restricted, it isn't
> > > > > > > clear
> > > > > > > what
> > > > > > > enable_transition means versus the regular transition or
> > > > > > > dyntransition
> > > > > > > permissions, and we aren't overriding a transition but rather
> > > > > > > allowing
> > > > > > > one under NNP/nosuid.
> > > > > > >=20
> > > > > > > The only other alternative I see is to introduce a process2
> > > > > > > class
> > > > > > > and
> > > > > > > use separate nnp_transition and nosuid_transition permissions
> > > > > > > (but in
> > > > > > > practice I expect them to be both allowed or denied
> > > > > > > together).=A0=A0Note
> > > > > > > that this will require two avtab and AVC entries for every
> > > > > > > domain
> > > > > > > pair
> > > > > > > (if we allow whichever one ends up going in the process2
> > > > > > > class),
> > > > > > > so
> > > > > > > that has an impact on policy and AVC size.=A0=A0Don't really =
see
> > > > > > > that
> > > > > > > as
> > > > > > > worthwhile.
> > > > > > >=20
> > > > > > > Other approach would be to make the nosuid transition checks
> > > > > > > file-
> > > > > > > based=A0
> > > > > > > instead so that it would go in the file class (while the nnp
> > > > > > > one
> > > > > > > would
> > > > > > > remain in the process class), but I don't think that's really
> > > > > > > what we
> > > > > > > want either.=A0=A0Difference between "Can domain D1 transition
> > > > > > > under
> > > > > > > nosuid
> > > > > > > =A0to D2?" and "Can domain D1 transition under nosuid when
> > > > > > > executing
> > > > > > > file
> > > > > > > with type T1?".
> > > > > >=20
> > > > > > Just to be clear, we would also be separately checking regular
> > > > > > transition permission between the old and new contexts on these
> > > > > > transitions, so you would need both:
> > > > > > allow D1 D2:process transition;
> > > > > > allow D1 T1:file nosuid_transition;
> > > > > > if we took the latter approach.
> > > > > >=20
> > > > > > So we wouldn't lose entirely on a domain-to-domain check, but
> > > > > > it
> > > > > > would
> > > > > > no longer be domain-to-domain for the nosuid part.
> > > > > >=20
> > > > > > Whereas with original approach, we end up requiring:
> > > > > > allow D1 D2:process transition;
> > > > > > allow D1 D2:process nnp_nosuid_transition; # or whatever
> > > > > > permission
> > > > > > name is used
> > > > >=20
> > > > > I don't know if i understand all the ins-and-outs of the matter
> > > > > but i
> > > > > think i do like the idea of differentiating between
> > > > > nosuid_transition
> > > > > and nnp_transition
> > > > > It provides more flexibility because i might not want to allow
> > > > > one or
> > > > > the other automatically.
> > > > >=20
> > > > > I do not think it its a good idea to allow a process to transiton
> > > > > on
> > > > > nosuid mounted filesystems just because i am forced to allow it
> > > > > nnp.
> > > >=20
> > > > Can you provide a real use case where you would need to distinguish
> > > > them?
> > >=20
> > > Nope I cannot, but its easy to merge the two permissions in policy,
> > > and thereby preserving flexibility. It will be hard to deal with a
> > > case that might arise that was not foreseen if we cover both
> > > scenarios with a single permission.
> > >=20
> > > >=20
> > > > Currently we handle them the same way (i.e. we don't allow
> > > > transitions
> > > > unless bounded for both).=A0=A0The current patch preserves that
> > > > consistency, and just provides a way to allow transitions without
> > > > bounds for both.=A0=A0Of course, you still have to be allowed the u=
sual
> > > > permissions in order to perform the transition at all (Can the
> > > > caller
> > > > execute the file? Can the callee be entered (entrypoint) by the
> > > > file?
> > > > Can the caller transition to the callee?) in addition to the new
> > > > permission check (Can the caller transition under NNP/nosuid to the
> > > > callee?).
> > > >=20
> > > > We can't distinguish them on a domain-to-domain basis without
> > > > introducing a new process2 class, and so far no one has been
> > > > excited
> > > > about that.
> > >=20
> > > Why is that? Eventually that is going to happen anyway. Besides we
> > > also have a capability2 and its not like that's a big deal is it?
> >=20
> > Adding it is fine if we have a genuine need for it, but it doesn't come
> > for free. It is potentially an extra avtab entry (policy rule) for
> > every allowed domain transition in the policy.  There are far fewer
> > capability2 rules in comparison, since those are always domain-self and
> >  to date the need for those capabilities has also been relatively
> > sparse.
>=20
> Okay i rest my case, just making sure that this is thought over carefully

Aw heck on more argument:

How about adding another policycap for that?
Also if were talking about excessive avtab entries. cap(2)?_userns seems pr=
etty excessive to me (you pretty much end duplicating cap and cap2 equivale=
nts for any process that needs to deal with userns)

>=20
> >=20
> > > But again, its not that big of a deal for me.
> > >=20
> > > >=20
> > > > > So since the stuff is ugly one way or another might as well make
> > > > > it
> > > > > consistent with SELinux flexibility goals
> > > > >=20
> > > > > Just my preference but I dont have a really strong opinion on the
> > > > > matter
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > On a separate note, I plan to cc luto on the next version of
> > > > > > > the
> > > > > > > patch
> > > > > > > as I suspect he will have concerns about relaxing this
> > > > > > > constraint
> > > > > > > on
> > > > > > > NNP and this likely requires updating
> > > > > > > Documentation/prctl/no_new_privs*
> > > > > > > and the man pages that describe NNP behavior.
> > > > > > >=20
> > > > > > > The other model would be to figure out a way to make the
> > > > > > > typebounds
> > > > > > > logic work cleanly in a manner that preserves the desired
> > > > > > > NNP/nosuid
> > > > > > > invariant _and_ doesn't require leaking unnecessary accesses
> > > > > > > into
> > > > > > > the
> > > > > > > ancestor domains that make them less secure, plus CIL support
> > > > > > > for
> > > > > > > automatically propagating permissions in the desired
> > > > > > > way.=A0=A0But I
> > > > > > > haven't yet come up with a way to do that.=A0=A0We can do it =
in
> > > > > > > some
> > > > > > > cases
> > > > > > > by creating typebounds between the object types, e.g.:
> > > > > > > typebounds parent_t child_t;
> > > > > > > allow child_t self:process execmem;
> > > > > > > allow child_t child_exec_t:file entrypoint;
> > > > > > > allow child_t child_tmp_t:file create;
> > > > > > > can be allowed via:
> > > > > > > allow parent_t child_t:process execmem; # an otherwise
> > > > > > > nonsensical
> > > > > > > rule
> > > > > > > typebounds parent_exec_t child_exec_t;
> > > > > > > typebounds parent_tmp_t child_tmp_t;
> > > > > > > but this breaks down when there isn't an equivalent type and
> > > > > > > permission
> > > > > > > set already allowed to the parent for every type allowed to
> > > > > > > the
> > > > > > > child.
> > > > >=20
> > > > >=20
> > >=20
> > >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllnzVUACgkQJXSOVTf5
R2mSzgwAhfZssynzTlSXmac5jiUsym1Nka2gtk8dNxoPAyDmK8sfJtmWdZOnTHuU
d5E9GnCWscIwZKxZj3xJ7n77QD5sPHYDDRcxoPy6Je1QLlZXUiOrupYOnNDdiFJx
ESUfbRvXwXIzSe2hLkVnD9T7DOynTpa9MBxK7Bnh8SdwoKgV4e5mPj8w98+FOyFm
zrIkW0W5nCNPB+g+Eek32xpPlQBp7yjCmF7qwXtC90wlMaaFna9HbJyucUVezOW9
LgNRJzYnypP6g5v4I6PjVbgn1hb2reCYtaksGaCMh6+snFuWYkd0DPjIAhezVPBD
50wjs6ml2YJL54KsnSPmlje3liPNqo2UuglzWqb1pTS2MxI3iNJLJYeog8pTgVVL
lOBf3zl4FlW+zH00CV0XpwxKBamNjyZQAjeib+Q4Qw2a+FCZh5TNeZTaDNFOYtE2
IacPxOTEXQ25lMs0K4Y7dpjslj2JCyiJYITMjDdSryKPCpydMumOJlLFxCgTIx3j
wEI+mkxv
=Ouwe
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
