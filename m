Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6E6hX6B019196
 for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2017 02:43:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so9049295wmh.3
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 23:43:23 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id l3sm3498730edc.32.2017.07.13.23.43.20
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Jul 2017 23:43:20 -0700 (PDT)
Date: Fri, 14 Jul 2017 08:43:18 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170714064318.GA11183@julius.enp8s0.d30>
References: <1499961595.624.5.camel@tycho.nsa.gov>
 <20170713165557.GA28835@julius.enp8s0.d30>
 <1499969620.624.16.camel@tycho.nsa.gov>
 <20170713181614.GB28835@julius.enp8s0.d30>
 <1499974196.624.20.camel@tycho.nsa.gov>
 <20170713192843.GB13350@julius.enp8s0.d30>
 <20170713194323.GC13350@julius.enp8s0.d30>
 <1499975969.624.22.camel@tycho.nsa.gov>
 <20170713201152.GD13350@julius.enp8s0.d30>
 <8a833359-76f6-c67f-e0d4-8d0e9618243a@ieee.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <8a833359-76f6-c67f-e0d4-8d0e9618243a@ieee.org>
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 07:55:14PM -0400, Chris PeBenito wrote:
> On 07/13/2017 04:11 PM, Dominick Grift wrote:
> > On Thu, Jul 13, 2017 at 03:59:29PM -0400, Stephen Smalley wrote:
> > > On Thu, 2017-07-13 at 21:43 +0200, Dominick Grift wrote:
> > > > On Thu, Jul 13, 2017 at 09:28:43PM +0200, Dominick Grift wrote:
> > > > > On Thu, Jul 13, 2017 at 03:29:56PM -0400, Stephen Smalley wrote:
> > > > > > On Thu, 2017-07-13 at 20:16 +0200, Dominick Grift wrote:
> > > > > > > On Thu, Jul 13, 2017 at 02:13:40PM -0400, Stephen Smalley
> > > > > > > wrote:
> > > > > > > > On Thu, 2017-07-13 at 18:55 +0200, Dominick Grift wrote:
> > > > > > > > > On Thu, Jul 13, 2017 at 11:59:55AM -0400, Stephen Smalley
> > > > > > > > > wrote:
> > > > > > > > > > On Thu, 2017-07-13 at 11:48 -0400, Stephen Smalley wrot=
e:
> > > > > > > > > > > On Thu, 2017-07-13 at 09:25 -0400, Paul Moore wrote:
> > > > > > > > > > > > On Thu, Jul 13, 2017 at 8:44 AM, Stephen Smalley <s=
ds
> > > > > > > > > > > > @tycho
> > > > > > > > > > > > .nsa
> > > > > > > > > > > > .gov
> > > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > On Wed, 2017-07-12 at 20:27 -0400, Chris PeBenito
> > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > On 07/12/2017 05:38 PM, Paul Moore wrote:
> > > > > > > > > > > > > > > On Wed, Jul 12, 2017 at 9:26 AM, Stephen
> > > > > > > > > > > > > > > Smalley <sds
> > > > > > > > > > > > > > > @tyc
> > > > > > > > > > > > > > > ho.n
> > > > > > > > > > > > > > > sa
> > > > > > > > > > > > > > > .gov
> > > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > On Tue, 2017-07-11 at 17:00 -0400, Paul Moo=
re
> > > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > On Mon, Jul 10, 2017 at 4:25 PM, Stephen
> > > > > > > > > > > > > > > > > Smalley
> > > > > > > > > > > > > > > > > <sds
> > > > > > > > > > > > > > > > > @tyc
> > > > > > > > > > > > > > > > > ho
> > > > > > > > > > > > > > > > > .nsa
> > > > > > > > > > > > > > > > > .gov>
> > > > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > While I think splitting the NNP/nosuid
> > > > > > > > > > > > > > > transition
> > > > > > > > > > > > > > > restrictions
> > > > > > > > > > > > > > > might
> > > > > > > > > > > > > > > be a good idea under the new policy capabilit=
y,
> > > > > > > > > > > > > > > I'm
> > > > > > > > > > > > > > > not
> > > > > > > > > > > > > > > sure
> > > > > > > > > > > > > > > it
> > > > > > > > > > > > > > > is
> > > > > > > > > > > > > > > worth the cost of a "process2" object class.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > With that in mind, let's do two things with
> > > > > > > > > > > > > > > this
> > > > > > > > > > > > > > > patch:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > * Mention the nosuid restrictions in the patch
> > > > > > > > > > > > > > > description.  It
> > > > > > > > > > > > > > > doesn't need much text, but something would be
> > > > > > > > > > > > > > > good
> > > > > > > > > > > > > > > so we
> > > > > > > > > > > > > > > have
> > > > > > > > > > > > > > > documentation in the git log.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > * Let's pick a new permission name that is not
> > > > > > > > > > > > > > > specific
> > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > NNP
> > > > > > > > > > > > > > > or
> > > > > > > > > > > > > > > nosuid.  IMHO, nnpnosuid_transition is ... le=
ss
> > > > > > > > > > > > > > > than
> > > > > > > > > > > > > > > good.
> > > > > > > > > > > > > > > Unfortunately, I'm not sure I'm much better at
> > > > > > > > > > > > > > > picking
> > > > > > > > > > > > > > > names;
> > > > > > > > > > > > > > > how
> > > > > > > > > > > > > > > about
> > > > > > > > > > > > > > > "protected_transition"?  "restricted_transiti=
on
> > > > > > > > > > > > > > > "?
> > > > > > > > > > > > > > > "enable_transition"?  "override_transition"?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I vote for nnp_transition anyway.  "No New
> > > > > > > > > > > > > > Privileges"
> > > > > > > > > > > > > > encompasses
> > > > > > > > > > > > > > nosuid in my mind.  If the two perms had been
> > > > > > > > > > > > > > separated
> > > > > > > > > > > > > > I
> > > > > > > > > > > > > > would
> > > > > > > > > > > > > > have
> > > > > > > > > > > > > > been inclined to allow both every time one of
> > > > > > > > > > > > > > them was
> > > > > > > > > > > > > > needed,
> > > > > > > > > > > > > > to
> > > > > > > > > > > > > > make
> > > > > > > > > > > > > > sure no one was surprised by the behavior
> > > > > > > > > > > > > > difference.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I agree; I'll keep it as nnp_transition and just
> > > > > > > > > > > > > document
> > > > > > > > > > > > > it
> > > > > > > > > > > > > in
> > > > > > > > > > > > > the
> > > > > > > > > > > > > patch description.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Sorry to be a stubborn about this, but nnp_transiti=
on
> > > > > > > > > > > > makes
> > > > > > > > > > > > little
> > > > > > > > > > > > sense for the nosuid restriction.  Like it or not,
> > > > > > > > > > > > NNP has
> > > > > > > > > > > > a
> > > > > > > > > > > > concrete
> > > > > > > > > > > > meaning which is distinct from nosuid mounts.  We
> > > > > > > > > > > > don't
> > > > > > > > > > > > have to
> > > > > > > > > > > > pick
> > > > > > > > > > > > any of the permission names I tossed out, none of
> > > > > > > > > > > > those
> > > > > > > > > > > > were
> > > > > > > > > > > > very
> > > > > > > > > > > > good, but I would like to see something that takes
> > > > > > > > > > > > both NNP
> > > > > > > > > > > > and
> > > > > > > > > > > > nosuid
> > > > > > > > > > > > into account, or preferably something that doesn't
> > > > > > > > > > > > use
> > > > > > > > > > > > either
> > > > > > > > > > > > name
> > > > > > > > > > > > explicitly but still conveys the meaning.
> > > > > > > > > > >=20
> > > > > > > > > > > NNP is essentially a superset of nosuid; it applies to
> > > > > > > > > > > all
> > > > > > > > > > > execve()
> > > > > > > > > > > calls by the process and its descendants rather than
> > > > > > > > > > > only to
> > > > > > > > > > > execve()
> > > > > > > > > > > calls on specially marked filesystems.  So I viewed it
> > > > > > > > > > > as the
> > > > > > > > > > > more
> > > > > > > > > > > general term.
> > > > > > > > > > >=20
> > > > > > > > > > > If that's not viable, I can't think of anything clear=
er
> > > > > > > > > > > or
> > > > > > > > > > > better
> > > > > > > > > > > than
> > > > > > > > > > > nnp_nosuid_transition.  That clearly links it to what
> > > > > > > > > > > it
> > > > > > > > > > > means
> > > > > > > > > > > (allow
> > > > > > > > > > > a
> > > > > > > > > > > SELinux domain transition under NNP or nosuid).  It is
> > > > > > > > > > > somewhat
> > > > > > > > > > > ugly
> > > > > > > > > > > and verbose but it is clear in what it means, which I
> > > > > > > > > > > think
> > > > > > > > > > > is
> > > > > > > > > > > more
> > > > > > > > > > > important. All of your suggestions IMHO were less cle=
ar
> > > > > > > > > > > since
> > > > > > > > > > > they
> > > > > > > > > > > had
> > > > > > > > > > > no clear linkage to either NNP or nosuid, and I
> > > > > > > > > > > couldn't tell
> > > > > > > > > > > from
> > > > > > > > > > > reading the permission name what it meant.  The SELin=
ux
> > > > > > > > > > > domain
> > > > > > > > > > > transition isn't protected, it isn't restricted, it
> > > > > > > > > > > isn't
> > > > > > > > > > > clear
> > > > > > > > > > > what
> > > > > > > > > > > enable_transition means versus the regular transition
> > > > > > > > > > > or
> > > > > > > > > > > dyntransition
> > > > > > > > > > > permissions, and we aren't overriding a transition but
> > > > > > > > > > > rather
> > > > > > > > > > > allowing
> > > > > > > > > > > one under NNP/nosuid.
> > > > > > > > > > >=20
> > > > > > > > > > > The only other alternative I see is to introduce a
> > > > > > > > > > > process2
> > > > > > > > > > > class
> > > > > > > > > > > and
> > > > > > > > > > > use separate nnp_transition and nosuid_transition
> > > > > > > > > > > permissions
> > > > > > > > > > > (but in
> > > > > > > > > > > practice I expect them to be both allowed or denied
> > > > > > > > > > > together).  Note
> > > > > > > > > > > that this will require two avtab and AVC entries for
> > > > > > > > > > > every
> > > > > > > > > > > domain
> > > > > > > > > > > pair
> > > > > > > > > > > (if we allow whichever one ends up going in the
> > > > > > > > > > > process2
> > > > > > > > > > > class),
> > > > > > > > > > > so
> > > > > > > > > > > that has an impact on policy and AVC size.  Don't
> > > > > > > > > > > really see
> > > > > > > > > > > that
> > > > > > > > > > > as
> > > > > > > > > > > worthwhile.
> > > > > > > > > > >=20
> > > > > > > > > > > Other approach would be to make the nosuid transition
> > > > > > > > > > > checks
> > > > > > > > > > > file-
> > > > > > > > > > > based
> > > > > > > > > > > instead so that it would go in the file class (while
> > > > > > > > > > > the nnp
> > > > > > > > > > > one
> > > > > > > > > > > would
> > > > > > > > > > > remain in the process class), but I don't think that's
> > > > > > > > > > > really
> > > > > > > > > > > what we
> > > > > > > > > > > want either.  Difference between "Can domain D1
> > > > > > > > > > > transition
> > > > > > > > > > > under
> > > > > > > > > > > nosuid
> > > > > > > > > > >  to D2?" and "Can domain D1 transition under nosuid
> > > > > > > > > > > when
> > > > > > > > > > > executing
> > > > > > > > > > > file
> > > > > > > > > > > with type T1?".
> > > > > > > > > >=20
> > > > > > > > > > Just to be clear, we would also be separately checking
> > > > > > > > > > regular
> > > > > > > > > > transition permission between the old and new contexts =
on
> > > > > > > > > > these
> > > > > > > > > > transitions, so you would need both:
> > > > > > > > > > allow D1 D2:process transition;
> > > > > > > > > > allow D1 T1:file nosuid_transition;
> > > > > > > > > > if we took the latter approach.
> > > > > > > > > >=20
> > > > > > > > > > So we wouldn't lose entirely on a domain-to-domain chec=
k,
> > > > > > > > > > but
> > > > > > > > > > it
> > > > > > > > > > would
> > > > > > > > > > no longer be domain-to-domain for the nosuid part.
> > > > > > > > > >=20
> > > > > > > > > > Whereas with original approach, we end up requiring:
> > > > > > > > > > allow D1 D2:process transition;
> > > > > > > > > > allow D1 D2:process nnp_nosuid_transition; # or whatever
> > > > > > > > > > permission
> > > > > > > > > > name is used
> > > > > > > > >=20
> > > > > > > > > I don't know if i understand all the ins-and-outs of the
> > > > > > > > > matter
> > > > > > > > > but i
> > > > > > > > > think i do like the idea of differentiating between
> > > > > > > > > nosuid_transition
> > > > > > > > > and nnp_transition
> > > > > > > > > It provides more flexibility because i might not want to
> > > > > > > > > allow
> > > > > > > > > one or
> > > > > > > > > the other automatically.
> > > > > > > > >=20
> > > > > > > > > I do not think it its a good idea to allow a process to
> > > > > > > > > transiton
> > > > > > > > > on
> > > > > > > > > nosuid mounted filesystems just because i am forced to
> > > > > > > > > allow it
> > > > > > > > > nnp.
> > > > > > > >=20
> > > > > > > > Can you provide a real use case where you would need to
> > > > > > > > distinguish
> > > > > > > > them?
> > > > > > >=20
> > > > > > > Nope I cannot, but its easy to merge the two permissions in
> > > > > > > policy,
> > > > > > > and thereby preserving flexibility. It will be hard to deal
> > > > > > > with a
> > > > > > > case that might arise that was not foreseen if we cover both
> > > > > > > scenarios with a single permission.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Currently we handle them the same way (i.e. we don't allow
> > > > > > > > transitions
> > > > > > > > unless bounded for both).  The current patch preserves that
> > > > > > > > consistency, and just provides a way to allow transitions
> > > > > > > > without
> > > > > > > > bounds for both.  Of course, you still have to be allowed t=
he
> > > > > > > > usual
> > > > > > > > permissions in order to perform the transition at all (Can
> > > > > > > > the
> > > > > > > > caller
> > > > > > > > execute the file? Can the callee be entered (entrypoint) by
> > > > > > > > the
> > > > > > > > file?
> > > > > > > > Can the caller transition to the callee?) in addition to the
> > > > > > > > new
> > > > > > > > permission check (Can the caller transition under NNP/nosuid
> > > > > > > > to the
> > > > > > > > callee?).
> > > > > > > >=20
> > > > > > > > We can't distinguish them on a domain-to-domain basis witho=
ut
> > > > > > > > introducing a new process2 class, and so far no one has been
> > > > > > > > excited
> > > > > > > > about that.
> > > > > > >=20
> > > > > > > Why is that? Eventually that is going to happen anyway. Besid=
es
> > > > > > > we
> > > > > > > also have a capability2 and its not like that's a big deal is
> > > > > > > it?
> > > > > >=20
> > > > > > Adding it is fine if we have a genuine need for it, but it
> > > > > > doesn't come
> > > > > > for free. It is potentially an extra avtab entry (policy rule)
> > > > > > for
> > > > > > every allowed domain transition in the policy.  There are far
> > > > > > fewer
> > > > > > capability2 rules in comparison, since those are always domain-
> > > > > > self and
> > > > > >  to date the need for those capabilities has also been relative=
ly
> > > > > > sparse.
> > > > >=20
> > > > > Okay i rest my case, just making sure that this is thought over
> > > > > carefully
> > > >=20
> > > > Aw heck on more argument:
> > > >=20
> > > > How about adding another policycap for that?
> > >=20
> > > I doubt we want to require policy writers and analysts to have to che=
ck
> > > a policy capability to determine whether nosuid transitions depend on
> > > their own unique permission or the one shared with nnp transitions.
> > > Complexity for no real gain.
> >=20
> > Yes well "no real gain" I think basically were just saying: nosuid does=
nt apply to selinux anymore
> >=20
> > If i have an executable file type for a daemon that uses NNP and two ex=
ecutables one on a nosuid mounted slice and another one on a non-nosuid mou=
nted partition, then basically from an selinux perspective the nosuid is me=
aningless.
>=20
> I don't think that situation can be addressed with your proposed change
> because the transition checks are between the two domains, not the source
> domain and the executable.

Consider:

1. NNP flags are inherited (this is something I think we really need to tak=
e into account)
2. Take for example "fsutils_t" There are many executable files associated =
with the "fsutils_exec_t" domain entry file type. What if some of those are=
 located on nosuid mounted filesystems and some are not?
3. What if any of the domains that needs to be able to run "fsutils" with a=
 domain transition to "fsutils_t" inherited the NNP flag?

>=20
>=20
> --=20
> Chris PeBenito
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlloaAIACgkQJXSOVTf5
R2mihwwAluYS2wy1Je6VL8X3SyfVy7omYs1jq8M/jDXf5cQTC282fqAjqSlLYLyi
gywtlPXA+ZiDwIw3/n1OK0JfVLCLoKkA6DAd/jpBJWeGdmPdHPqsC9zWHtXvbvGQ
56hE5k+Yd/cX9pWp91RfqHuHhgS9FAxj1XTaJDtF9MLRToF5vc5T2sTGwBEVQwfj
HkhIRw2uBO7KHoxoN0pGuA1kW9ZCrw3w7c397RVzH+1kV7gBHxL5/WfIm6F8mPqa
XglAwOkqE26ZYpa+ydIDlw62mDlaLKtyC9Qzk5X2Rset9LvMeBace3LY1abcup6f
lUfyw70isI9sy1CaYjBihSX6oikh6aKUu4JFoENOMxLrNbDb0WhSNkBL2+8VMGuW
wjzPWDor/wLGKdmn3vLKRJfAMuIS+XN/Aq8Q4F3sjL2njVjc5L57PxwUkrOUaUmK
mJ7CksNUe0cX0EN9NMck8trm8/HESevzE+SHg05VGPjgii2oxZ7ZbUi660v5WPty
hItnsTMR
=M2Ga
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
