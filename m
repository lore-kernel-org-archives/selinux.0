Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KGjqgV007502
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 12:45:52 -0400
Received: by mail-lf0-f50.google.com with SMTP id m77so78700515lfe.0
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 09:45:31 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id i42sm6993607ede.5.2017.06.20.09.45.22
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Jun 2017 09:45:22 -0700 (PDT)
Date: Tue, 20 Jun 2017 18:45:20 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Collecting ideas for audit2allow improvement
Message-ID: <20170620164520.GB10431@julius.enp8s0.d30>
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
 <1497450625.9239.6.camel@tycho.nsa.gov>
 <20170614143541.GB5298@julius.enp8s0.d30>
 <20170614144732.GC5298@julius.enp8s0.d30>
 <340e54c1-3a75-a35f-09ca-d3f831aaa08f@redhat.com>
 <20170616160801.GA19587@julius.enp8s0.d30>
 <19450f92-bf4b-cf20-71d3-9253a4b08cbe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
In-Reply-To: <19450f92-bf4b-cf20-71d3-9253a4b08cbe@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 11:45:53AM -0400, Daniel Walsh wrote:
> On 06/16/2017 12:08 PM, Dominick Grift wrote:
> > On Fri, Jun 16, 2017 at 08:21:25AM -0400, Daniel Walsh wrote:
> > > On 06/14/2017 10:47 AM, Dominick Grift wrote:
> > > > On Wed, Jun 14, 2017 at 04:35:41PM +0200, Dominick Grift wrote:
> > > > > On Wed, Jun 14, 2017 at 10:30:25AM -0400, Stephen Smalley wrote:
> > > > > > On Wed, 2017-06-14 at 09:01 -0400, Jan Zarsky wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > I would like to improve SELinux audit2allow tool as my bachel=
or
> > > > > > > thesis.
> > > > > > > I collected ideas from my colleagues from RedHat SELinux team=
 and I
> > > > > > > would also
> > > > > > > like to hear your ideas - what would you improve to make audi=
t2allow
> > > > > > > smarter or
> > > > > > > easier to use.
> > > > > > >=20
> > > > > > > Ideas collected so far:
> > > > > > >=20
> > > > > > >     * offer dac_read_search when sufficient instead of dac_ov=
erride
> > > > > > >       (see <https://github.com/SELinuxProject/selinux/issues/=
31>)
> > > > > > The hard part here is knowing when it is sufficient.  Might req=
uire
> > > > > > further kernel patches to get to the point where it is complete=
ly
> > > > > > unambiguous from the audit messages alone.  You could perhaps d=
efault
> > > > > > to only allowing dac_read_search and only allow dac_override if=
 you see
> > > > > > that dac_read_search is already allowed and you are still getti=
ng a
> > > > > > dac_override denial.
> > > > > This should not be an issue anymore. Becuase now (linux v4.12) da=
c_read_search is first checked
> > > > > so translating a rule for dac_read_search will always be the most=
 secure option. It might not be enough but youll notice if it isnt. Just re=
run it again and you'll end up with dac_override if needed.
> > > > >=20
> > > > > > >     * offer multiple solutions to a problem (example: 1) add =
allow rule
> > > > > > > for
> > > > > > >       execute + execute_no_trans or 2) add allow rule for exe=
cute
> > > > > > >       + type_transition rule)
> > > > > > Is this type_transition to an existing type that already exists=
, or
> > > > > > defining a new type and transitioning to it, or both?  Generati=
ng new
> > > > > > domains and types dynamically is one of the major gaps in curre=
nt
> > > > > > audit2allow, and to date has only been supported in separate to=
ols like
> > > > > > sepolicy generate.
> > > > > One should be extremely careful here. "execute" does not automati=
cally imply "execute_no_trans". That assumption can lead to disaster (https=
://www.cvedetails.com/cve/CVE-2015-1815/)
> > > > > > >     * interactive mode: ask questions and choose best solution
> > > > > > >     * warn when solution touches trusted computing base (rule=
s you
> > > > > > > should not be
> > > > > > >       adding)
> > > > > > >     * suggest alternate labels for content, example: httpd_t =
not
> > > > > > > allowed to write
> > > > > > >       to user_home_t, might suggest that changing the label to
> > > > > > >       httpd_user_content_t
> > > > > > This seems more along the lines of what setroubleshoot does, an=
d tends
> > > > > > to be policy-specific. We need to preserve the usability of aud=
it2allow
> > > > > > for other policies (e.g. Android, DSSP), so any policy-specific=
 logic
> > > > > > needs to be encapsulated, configuration-driven, and optional.
> > > > > setroubleshoot is not smart enough to suggest httpd_user_content_=
t, instead it suggest you allow full access to /home/* by toggling the bool=
ean that grants access to user home content.
> > > > >=20
> > > > > I know this from experience. There was a bug in fedora's apache_u=
ser_content_template for more than a year and hardly anyone noticed it, pro=
bably because setroubleshoot would have just suggested you allow full acces=
s to user home content.
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1457406
> > > I actually think the suggest a accessible type is  the best improveme=
nt.
> > > audit2allow has defaulted for years to suggesting adding allow rules,
> > > usually the worst solution.  Later we added boolean support, which was
> > > better but as you point out the not a great solution in a lot of case=
s.
> > The "best" improvement. I agree, but that say's more about the overal s=
tate of things than about the quality of this particular improvement.
> >=20
> > The guy in the tweet was overwhelmed and intimidated by the large list =
of "accessible" types returned by setroubleshoot (and audit2allow would pro=
bably do the same)
> > Also things arent as simple, its not just about "what type grants the a=
ccess needed to my domain". Other domains access to that type should also b=
e considered.
> Which is why I suggested we filter it down to a list that has the same
> prefix.  Also I think we should at least stick in the beginning to
> permissions that can effect the content of data, rather then just reveal =
the
> content.
>=20
> write, append, add_name unlink setattr, remove_name rmdir link create ...
>=20
> I think anything we can do to making it easier for the user to get a prop=
er
> type, would be really helpful.
> > > Most AVC's are caused by mislabeled files or processes.  Having audit=
2allow
> > > attempt to examine the policy and figure out which types would have b=
een
> > > allowed with some simple sorting rules might be a big improvement.
> > audit2allow INHO shouldnt "examine" the policy (at least not in any sig=
nificant way) because it cannot do it right. audit2allow should just stick =
with the basics + audit2why.
> >=20
> > audit2why is the only functionality that works reasonably well. provide=
d that some of the more recent "improvements" to audit2why get removed.
> audit2why does nothing to reveal the crutch of the problem, SELinux is a
> Labeling system, if things go wrong, most of the time the labels are wron=
g.
> audit2allow/audit2why does not consider this. THis is why you get a boole=
an
> suggestion as the first outcome.
>=20
> I believe the checks should be
>=20
> 1. Is the target mislabeled?  If yes, suggest restorecon, ( I believe it
> already does this)
> 2. If this is a modification permission, suggest a type if one exists that
> matches the the prefix of the source type.  This helps a lot with people
> using default_t types, or types labeled var_log_t or var_lib_t.  Somewhat
> with user_home_t.
> 3. Look for a boolean to satisfy the needs.
> 4. Suggest audit2allow -M mypol
>=20
> There are probably a couple of other things that could happen.

Call me a pessimist but I have my doubts that some code will ever be able t=
o consistently ask SELinux the right questions on behalf of users to get th=
e right answers for the users.

I suspect that the more sustainable approach would be to somehow enhance, o=
r/and build on setools to make it even easier and more enjoyable to use so =
that people can use it to make sound decisions, rather than to rely on some=
 code to ask the questions on the users behalf by facilitation but leave th=
e subjective aspects to users (make it easier for users to ask the question=
s, but do not try to ask the questions on the users behalf)

I wish that some code could be intelligent enough to consistently suggest t=
he best solutions, but i suppose best is subjective, and not sure whether c=
omputers are good at making rational decisions or good at rational thinking

One can literaly pour infinite resources into trying to make what seems to =
be impossible possible or one could spend these valuable resources to impro=
ving things that helps everyone: find ways to *improve* setools (make it mo=
re enjoyable to use and thereby stimulating people to think about security =
more)

>=20
>=20
> > > Avc denying httpd_t ability to write to httpd_sys_content_t.
> > >=20
> > > audit2allow should examine policy and figure out which domains httpd_=
t can
> > > write to with the current policy settings.  Then it should sort the
> > > solutions based on the characters of the sources context.  Perhaps ch=
opping
> > > a characters off, maybe down to 3.
> > >=20
> > >   sesearch -A -s httpd_t -p write -c | cut -f1 -d ":"  | cut -d" " -f=
 3 |
> > > sort -u | grep httpd
> > > httpd_cache_t
> > > httpdcontent
> > > httpd_lock_t
> > > httpd_squirrelmail_t
> > > httpd_sys_rw_content_t
> > > httpd_t
> > > httpd_tmpfs_t
> > > httpd_tmp_t
> > > httpd_user_rw_content_t
> > > httpd_var_lib_t
> > > httpd_var_run_t
> > >=20
> > > Now eliminate the non file types, removes httpd_t.
> > >=20
> > > That would give the user a much better chance of solving the problem =
without
> > > becoming policy specific.
> > It cannot do this right. If you look to be bugzilla i pasted above:
> >=20
> > All that was needed was to allow the httpd_t domain access to read dirs=
 with the httpd_sys_content_t type. sealert couldnt figure this out
> > and instead it suggested that he toggle the "httpd_use_user_content" bo=
olean instead, which would grant httpd_t broad access to user home content,=
 and defeat the purpose of "httpd_user_content_t"
> >=20
> > > Now if you wanted to become a little more smart, you could look at the
> > > second field of the label, and have a table that says "var" indicates=
 the
> > > path begins with /var and "tmp" indicates a directory that ends with =
tmp.
> > > But users could probably determine this.
> > >=20
> > >=20
> > >=20
> > >=20
> > > Sort by types starting with httpd, http, htt
> > The audience that uses this functionality get intimidated by the large =
lists of types that are returned and various "solutions" returned.
> > plus often times the solutions returned are sub-optimal, but the user d=
oesnt know this.
> >=20
> > Seasoned users will only use audit2allow for simple things like transla=
tion of avc to raw rules (maybe resolving of interfaces but this is prone t=
o bad results as well). quickly determining whether its a missing TE rule, =
boolean, or constraint. These users will use setools to do further analysis
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllJUR0ACgkQJXSOVTf5
R2lUJQv/XqTmZHTQTADJ4Ec6691fOSHXVG+OMnxb9IffcEdG8OY1qB2UxXShVWa3
V8O6LBp/vDmRfHOG5yAWimXOH94IpFzfkxZd7pyKtMDVzEtV66qeiwdpZQPgR6TJ
BKQ6ox7WBysN3yfd/gkq5CPaERXyHVDM2/mvE2s4tYgNsfCpV02zlWojW6DRk4Xi
1DqdLd5d9ypIv2fy6PbEAVy/sH3OJLQTrrQIuZCv2I8rPgq0047iW4AQt0R+G+dd
4yKdFrhWdiqoLYm7NjK8ALdmDejY7PEkIU5u0R8MrZ5vD0nEAzRvH7/KvttG+qyG
UwaVO19doYyheHR86oHyc7X9X1/FYEkZtU2NnrsKChTtzqgavSJq2niKuEig8Bf/
3Qn2DDkb9aPUNQaORvfK9v621LGRMdOQHUbEz8ejoE5+RmaxHfviEDanyAoqQ03E
RChVec/WR1MhIyKfc2+a2SlbpSn5doykh/97GFgTCDbTvyHbywpUH9Cc5MkgKX5D
ZzY5mGVa
=VGUk
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
