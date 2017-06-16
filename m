Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5GG89Z7030910
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 12:08:09 -0400
Received: by mail-wm0-f54.google.com with SMTP id m125so30241130wmm.1
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 09:08:05 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id y55sm990615edb.64.2017.06.16.09.08.02
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 16 Jun 2017 09:08:03 -0700 (PDT)
Date: Fri, 16 Jun 2017 18:08:01 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Collecting ideas for audit2allow improvement
Message-ID: <20170616160801.GA19587@julius.enp8s0.d30>
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
 <1497450625.9239.6.camel@tycho.nsa.gov>
 <20170614143541.GB5298@julius.enp8s0.d30>
 <20170614144732.GC5298@julius.enp8s0.d30>
 <340e54c1-3a75-a35f-09ca-d3f831aaa08f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
In-Reply-To: <340e54c1-3a75-a35f-09ca-d3f831aaa08f@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 08:21:25AM -0400, Daniel Walsh wrote:
> On 06/14/2017 10:47 AM, Dominick Grift wrote:
> > On Wed, Jun 14, 2017 at 04:35:41PM +0200, Dominick Grift wrote:
> > > On Wed, Jun 14, 2017 at 10:30:25AM -0400, Stephen Smalley wrote:
> > > > On Wed, 2017-06-14 at 09:01 -0400, Jan Zarsky wrote:
> > > > > Hi,
> > > > >=20
> > > > > I would like to improve SELinux audit2allow tool as my bachelor
> > > > > thesis.
> > > > > I collected ideas from my colleagues from RedHat SELinux team and=
 I
> > > > > would also
> > > > > like to hear your ideas - what would you improve to make audit2al=
low
> > > > > smarter or
> > > > > easier to use.
> > > > >=20
> > > > > Ideas collected so far:
> > > > >=20
> > > > >    * offer dac_read_search when sufficient instead of dac_override
> > > > >      (see <https://github.com/SELinuxProject/selinux/issues/31>)
> > > > The hard part here is knowing when it is sufficient.  Might require
> > > > further kernel patches to get to the point where it is completely
> > > > unambiguous from the audit messages alone.  You could perhaps defau=
lt
> > > > to only allowing dac_read_search and only allow dac_override if you=
 see
> > > > that dac_read_search is already allowed and you are still getting a
> > > > dac_override denial.
> > > This should not be an issue anymore. Becuase now (linux v4.12) dac_re=
ad_search is first checked
> > > so translating a rule for dac_read_search will always be the most sec=
ure option. It might not be enough but youll notice if it isnt. Just rerun =
it again and you'll end up with dac_override if needed.
> > >=20
> > > > >    * offer multiple solutions to a problem (example: 1) add allow=
 rule
> > > > > for
> > > > >      execute + execute_no_trans or 2) add allow rule for execute
> > > > >      + type_transition rule)
> > > > Is this type_transition to an existing type that already exists, or
> > > > defining a new type and transitioning to it, or both?  Generating n=
ew
> > > > domains and types dynamically is one of the major gaps in current
> > > > audit2allow, and to date has only been supported in separate tools =
like
> > > > sepolicy generate.
> > > One should be extremely careful here. "execute" does not automaticall=
y imply "execute_no_trans". That assumption can lead to disaster (https://w=
ww.cvedetails.com/cve/CVE-2015-1815/)
> > > > >    * interactive mode: ask questions and choose best solution
> > > > >    * warn when solution touches trusted computing base (rules you
> > > > > should not be
> > > > >      adding)
> > > > >    * suggest alternate labels for content, example: httpd_t not
> > > > > allowed to write
> > > > >      to user_home_t, might suggest that changing the label to
> > > > >      httpd_user_content_t
> > > > This seems more along the lines of what setroubleshoot does, and te=
nds
> > > > to be policy-specific. We need to preserve the usability of audit2a=
llow
> > > > for other policies (e.g. Android, DSSP), so any policy-specific log=
ic
> > > > needs to be encapsulated, configuration-driven, and optional.
> > > setroubleshoot is not smart enough to suggest httpd_user_content_t, i=
nstead it suggest you allow full access to /home/* by toggling the boolean =
that grants access to user home content.
> > >=20
> > > I know this from experience. There was a bug in fedora's apache_user_=
content_template for more than a year and hardly anyone noticed it, probabl=
y because setroubleshoot would have just suggested you allow full access to=
 user home content.
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1457406
> I actually think the suggest a accessible type is  the best improvement.
> audit2allow has defaulted for years to suggesting adding allow rules,
> usually the worst solution.  Later we added boolean support, which was
> better but as you point out the not a great solution in a lot of cases.

The "best" improvement. I agree, but that say's more about the overal state=
 of things than about the quality of this particular improvement.

The guy in the tweet was overwhelmed and intimidated by the large list of "=
accessible" types returned by setroubleshoot (and audit2allow would probabl=
y do the same)
Also things arent as simple, its not just about "what type grants the acces=
s needed to my domain". Other domains access to that type should also be co=
nsidered.

> Most AVC's are caused by mislabeled files or processes.  Having audit2all=
ow
> attempt to examine the policy and figure out which types would have been
> allowed with some simple sorting rules might be a big improvement.

audit2allow INHO shouldnt "examine" the policy (at least not in any signifi=
cant way) because it cannot do it right. audit2allow should just stick with=
 the basics + audit2why.

audit2why is the only functionality that works reasonably well. provided th=
at some of the more recent "improvements" to audit2why get removed.

>=20
> Avc denying httpd_t ability to write to httpd_sys_content_t.
>=20
> audit2allow should examine policy and figure out which domains httpd_t can
> write to with the current policy settings.  Then it should sort the
> solutions based on the characters of the sources context.  Perhaps choppi=
ng
> a characters off, maybe down to 3.
>=20
>  sesearch -A -s httpd_t -p write -c | cut -f1 -d ":"  | cut -d" " -f 3 |
> sort -u | grep httpd
> httpd_cache_t
> httpdcontent
> httpd_lock_t
> httpd_squirrelmail_t
> httpd_sys_rw_content_t
> httpd_t
> httpd_tmpfs_t
> httpd_tmp_t
> httpd_user_rw_content_t
> httpd_var_lib_t
> httpd_var_run_t
>=20
> Now eliminate the non file types, removes httpd_t.
>=20
> That would give the user a much better chance of solving the problem with=
out
> becoming policy specific.

It cannot do this right. If you look to be bugzilla i pasted above:

All that was needed was to allow the httpd_t domain access to read dirs wit=
h the httpd_sys_content_t type. sealert couldnt figure this out
and instead it suggested that he toggle the "httpd_use_user_content" boolea=
n instead, which would grant httpd_t broad access to user home content, and=
 defeat the purpose of "httpd_user_content_t"

>=20
> Now if you wanted to become a little more smart, you could look at the
> second field of the label, and have a table that says "var" indicates the
> path begins with /var and "tmp" indicates a directory that ends with tmp.
> But users could probably determine this.
>=20
>=20
>=20
>=20
> Sort by types starting with httpd, http, htt

The audience that uses this functionality get intimidated by the large list=
s of types that are returned and various "solutions" returned.
plus often times the solutions returned are sub-optimal, but the user doesn=
t know this.

Seasoned users will only use audit2allow for simple things like translation=
 of avc to raw rules (maybe resolving of interfaces but this is prone to ba=
d results as well). quickly determining whether its a missing TE rule, bool=
ean, or constraint. These users will use setools to do further analysis

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllEAl0ACgkQJXSOVTf5
R2nkmwwAmyNg5b6Lw8evgevieZaDn6UHjSI+5305ktDGV3HQ5CkXg4GQMsSnnems
cncQO78w1Xtpzh7l5ARF+Z6yuc+YA7wknYSLit+Zg+NzxErgc8T3GiGU7hSxEwdT
I+PVUQvMOT57yYouKCsT27wcnQAls6xwE3reNzYuKYfvSvRgSW+qSsBPbrUQHJK7
mXgoNeWwzMnKLNj6hTPT7BhRUigt8tdTIJzKGH4x97c4GY/FpvnHJrF10BPLV+sz
nHmXqjFXaaGqNMYmcMWLyou0C6jzFN4JpghdUYIMoitY+eJ/qVB32jnKt2P2aAUn
KjzRE6CP7drL8whrd7BFBKnIl1lC0Kx6H81qLeV4bnR4U3tbig2LzLCH6m5dEoIU
YfRs/yyTvRwEVCAhLm3+mv+JRkq+dWEyKsN+xVTrE9R65TN1QrNt08wMzbZ/Xdun
QNMY0OlGivBHkZYHQ7c+qElF+i8sOLGaVepr9lK96zDQqm9iZkpw3VGXSJqeiwpO
j3jGqmQY
=0GT7
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
