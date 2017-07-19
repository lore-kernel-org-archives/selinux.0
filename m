Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6JMOYpb023694
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 18:24:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id m4so1471750wmi.4
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 14:31:47 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id h28sm524451ede.56.2017.07.19.14.31.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Jul 2017 14:31:43 -0700 (PDT)
Date: Wed, 19 Jul 2017 23:31:41 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170719213141.GB2890@julius.enp8s0.d30>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
 <1500383878.18445.1.camel@tycho.nsa.gov>
 <1500405609.18445.14.camel@tycho.nsa.gov>
 <CAHC9VhQz686zC06smDZHf_GYF8EmHpErX5xXnx9bifU51EkwrQ@mail.gmail.com>
 <03f326bc-599c-0074-0cc2-7f46808673a1@ieee.org>
 <20170719071233.GA7053@julius.enp8s0.d30>
 <20170719204946.GA2890@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
In-Reply-To: <20170719204946.GA2890@julius.enp8s0.d30>
Subject: [SUSPECTED SPAM] [SUSPICIOUS MESSAGE] Re: [PATCH] selinux: Generalize
 support for NNP/nosuid SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--dc+cDN39EJAMEtIO
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 19, 2017 at 10:49:46PM +0200, Dominick Grift wrote:
> On Wed, Jul 19, 2017 at 09:12:33AM +0200, Dominick Grift wrote:
> > On Tue, Jul 18, 2017 at 09:07:45PM -0400, Chris PeBenito wrote:
> > > On 07/18/2017 05:26 PM, Paul Moore wrote:
> > > > On Tue, Jul 18, 2017 at 3:20 PM, Stephen Smalley <sds@tycho.nsa.gov=
> wrote:
> > > > > On Tue, 2017-07-18 at 09:17 -0400, Stephen Smalley wrote:
> > > > > > On Mon, 2017-07-17 at 15:54 -0400, Paul Moore wrote:
> > > > > > > On Sun, Jul 16, 2017 at 11:15 AM, Jason Zaman <jason@perfinio=
n.com>
> > > > > > > wrote:
> > > >=20
> > > > ...
> > > >=20
> > > > > > > > Why do we want to disallow type-bounds to work even with the
> > > > > > > > capability?
> > > > > > > > it seems sensible to me to allow typebounds to transition e=
ven in
> > > > > > > > the
> > > > > > > > future. If we do then we probably dont need the policycap w=
hich
> > > > > > > > seems
> > > > > > > > less complicated.
> > > > > > >=20
> > > > > > > The suggestion to continue to support bounded domain transiti=
ons
> > > > > > > seems
> > > > > > > reasonable to me, although we would need to worry about which=
 check
> > > > > > > to
> > > > > > > do first (bounded transition or process:nnp_nosuid_transition=
), and
> > > > > > > how to limit the auditing/reporting so admins are confused by=
 the
> > > > > > > first check failing, yet the transition still taking place.  =
None
> > > > > > > of
> > > > > > > these are unsolvable problems, but it will likely need a bit =
more
> > > > > > > work.
> > > > > > >=20
> > > > > > > I'm sure Stephen has some thoughts on this as well.
> > > > > >=20
> > > > > > Others (e.g. Dominick) seemed to take the opposite view on the
> > > > > > earlier
> > > > > > RFC discussion, i.e. that we should only check the new permissi=
on if
> > > > > > the capability is enabled.  I specifically raised that as a que=
stion
> > > > > > there.
> > > > > >=20
> > > > > > I'm willing to change it to fallback to checking for a bounded =
type,
> > > > > > but that will mean two audit messages (I don't think we can jus=
t hide
> > > > > > one of them) when neither is allowed.  That said, it is unlikel=
y to
> > > > > > cause much confusion in practice because users typically only l=
ook
> > > > > > for
> > > > > > and pay attention to AVC messages, and anyone using audit2allow=
 will
> > > > > > just end up allowing the permission, not the bounds.
> > > > >=20
> > > > > As Jason noted, if we fallback to checking for a bounded type, th=
en we
> > > > > don't strictly need a policy capability for it.
> > > >=20
> > > > It seems as though Dominick is okay with the fallback, what do the
> > > > rest of the policy folks think about that approach?
> >=20
> > I am okay with the faillback
> >=20
> > > >=20
> > > > I'm of the opinion that changes which don't require a new policy
> > > > capability are slightly more favorable, but since one of the goals
> > > > with this change is to make policy development easier, I want to ma=
ke
> > > > sure we are actually doing that.  It would appear we are, but a few
> > > > explicit nods from the policy folks would be nice to see.
> > >=20
> > > With my coder hat on, I can see the value of having the existing beha=
vior be
> > > available for anyone who currently uses it, so it makes sense.
> >=20
> > I agree, its only that I believe that no one is using it because it is =
impractical (except for mod_selinux users, and people that currently use ty=
pe_bounds to deal with nosuid),, mainly because the nnp flag is inherited.
> > The only scenario currently where, I believe, type_bounds might be pref=
ered is containers since container process types do not change and the inhe=
ritance aspect is not much of a problem.
> >=20
> > >=20
> > > With my policy hat on, I don't have an opinion on a fallback.  What I=
 do
> > > know is I don't like typebounds, avoid it as much as possible, and st=
rongly
> > > prefer it not be forced on me.  There are no typebounds in refpolicy.
> > >=20
> > > In fact, I think NNP should not affecting SELinux at all as NNP is
> > > discretionary and SELinux is mandatory.  NNP makes sense where you st=
art out
> > > with lots of privileges and have to shed them, (i.e. the Linux
> > > DAC/capabilities perspective) whereas you have no privileges in SELin=
ux
> > > except what is explicitly allowed.
> > >=20
> > > Once this permission is implemented I'll likely add the permission ac=
ross
> > > most if not all transitions out of systemd.
> >=20
> > Yes but do not expect that to ,always, be enough due to the inheritance=
 aspect. A process may have inherited the NNP flag, not because its started=
 by systemd but because its started by a process that inherited the NNP fla=
g because it was started by systemd.
>=20
> In dssp2 i have this concept called forked subject types, basically these=
 are systemd daemons *and* any processes types transitioned to by systemd d=
aemons.
>=20
> These are rules specific for systemd (system) forked subject types*:
>=20
> [root@julius ~]# sesearch -A -t systemd.system.forked_subj_type_attribute=
 -dt
> allow systemd.system.subj systemd.system.forked_subj_type_attribute:proce=
ss { getsched setrlimit setsched };
>=20
> [root@julius ~]# sesearch -A -s systemd.system.forked_subj_type_attribute=
 -ds
> allow systemd.system.forked_subj_type_attribute systemd.system.subj:fd us=
e;
> allow systemd.system.forked_subj_type_attribute systemd.system.subj:unix_=
stream_socket { append bind connect getattr getopt ioctl read setattr setop=
t shutdown write };
>=20
> Here are some types of process types that are (potentially) associated wi=
th children of systemd system daemons (but arent daemons themselves):
>=20
> [root@julius ~]# for i in `seinfo -xasystemd.system.forked_subj_type_attr=
ibute`; do [[ $(seinfo -xt $i | grep "systemd.system.daemon_subj_type_attri=
bute") ]] || echo $i | grep ".subj$"; done
> apache.rotatelogs.subj
> bootloader.subj
> chage.subj
> dracut.subj
> fuse.fusermount.subj
> iputils.subj
> kernel_install.subj
> kexec_tools.mkdumprd.subj
> loadkeys.subj
> logger.subj
> mysql.daemon.utils.subj
> nm_openvpn.subj
> notify.subj
> nspawn.generic_container.subj
> resolve.subj
> semodule.subj
> seutils.load_policy.subj
> seutils.setfiles.subj
> sysadm_systemd.subj
> tunctl.subj
> udisks.lvm.subj
> user_systemd.subj
> usermanage.groupadd.subj
> usermanage.useradd.subj
> wheel_systemd.subj
> xserver.subj
>=20
> So if i were to use the nnp_nosuid_transition permission then i would pro=
bably associate it with systemd.system.forked_subj_type_attribute
>=20
> * output might not be accurate due to limitations CIL/setools

By the way. If i am going to use nnp_nosuid_transition then am not going to=
 "just" associate this permission. I am going to deal with this on a case b=
y case basis.

In the systemd world this concept is very common. Systemd "potentially" nee=
ds to be able to do a lot of things to assets owned by its children. If you=
 generalize this then you might as well make systemd unconfined.

Containing systemd is very expensive in terms of policy rules. I am startin=
g to wonder whether it is even worth bothering.

It is not just the state today. Things still escalate. It is getting worse =
by the day.

>=20
> >=20
> > >=20
> > > --=20
> > > Chris PeBenito
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://secure-web.cisco.com/1A_WrTj3kAjkwuBmWXg6PuoiAjXyH8UU-z-ApV2MDP=
3SSs0P2YkubSRbbCGiWxhWgNW5klo0gJ7QkLGwI7-11-jTt1HK7ypKpW7DtXtM4yOgy0_5N5yjC=
h3Ow77XpHYfc97klOQlmQONWNDBLC8rWkav3UqnwZHYhXbRyCqUA6iaRo6dq3FnPFa9IGl_iQuK=
doTF1_-lhkKf-NPcuCWzcdMELJKhoFAQjnj3eu2j053TxFKhnVi_vCMqnqub0qfS7cGjZLJ7lPi=
oFySKJn4J23g/https%3A%2F%2Fsks-keyservers.net%2Fpks%2Flookup%3Fop%3Dget%26s=
earch%3D0x3B6C5F1D2C7B6B02
> > Dominick Grift
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://secure-web.cisco.com/1A_WrTj3kAjkwuBmWXg6PuoiAjXyH8UU-z-ApV2MDP3S=
Ss0P2YkubSRbbCGiWxhWgNW5klo0gJ7QkLGwI7-11-jTt1HK7ypKpW7DtXtM4yOgy0_5N5yjCh3=
Ow77XpHYfc97klOQlmQONWNDBLC8rWkav3UqnwZHYhXbRyCqUA6iaRo6dq3FnPFa9IGl_iQuKdo=
TF1_-lhkKf-NPcuCWzcdMELJKhoFAQjnj3eu2j053TxFKhnVi_vCMqnqub0qfS7cGjZLJ7lPioF=
ySKJn4J23g/https%3A%2F%2Fsks-keyservers.net%2Fpks%2Flookup%3Fop%3Dget%26sea=
rch%3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://secure-web.cisco.com/1A_WrTj3kAjkwuBmWXg6PuoiAjXyH8UU-z-ApV2MDP3SSs=
0P2YkubSRbbCGiWxhWgNW5klo0gJ7QkLGwI7-11-jTt1HK7ypKpW7DtXtM4yOgy0_5N5yjCh3Ow=
77XpHYfc97klOQlmQONWNDBLC8rWkav3UqnwZHYhXbRyCqUA6iaRo6dq3FnPFa9IGl_iQuKdoTF=
1_-lhkKf-NPcuCWzcdMELJKhoFAQjnj3eu2j053TxFKhnVi_vCMqnqub0qfS7cGjZLJ7lPioFyS=
KJn4J23g/https%3A%2F%2Fsks-keyservers.net%2Fpks%2Flookup%3Fop%3Dget%26searc=
h%3D0x3B6C5F1D2C7B6B02
Dominick Grift

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllvz7gACgkQJXSOVTf5
R2kJGgwApxyptoZxm3ql8GixwDF4HzqSqI1W0SnwhNQLl8ETJEu4vszDBPObllGH
KR7SOZwacbuGtYkvqx4Qj3iqAclBB44k2tHXgF7iExVJwUvgRjwhhIySkitvis3n
u4vnb7bBbKU1IJ+H1ZIpyKIu1Z82nit/qNlUDs8F2wEqdTGgd3WxtRY8aUGSaUcg
txYsPuBdOubKbp2I4xTuXdYh76CRrVQMxXCPTtfemBIXgKgpxeQnSO36ihljhVPq
m3vNiteyOriRjr3N8fLFTBNqjYJ9UqXzLYyESAeDp0/zsQO3BcsmDPqb6sgjl0sq
iR5w/wovuYqnihjAb77ERmQEoRI8kvZL6EZe4+FqlVf1vtDEbN3fBsw3QzDngDDp
LP/ySReKe+RoJ2shDEyViw6q1A07wT8C4b4kW/WJ/wRfeVkcVm2EQSJtWHhQCWJ7
BlhldFqL7r7illBwBnSWs8kmFcEfsWStCVKFNs5b49eKOZUD3TD1FwQ1NhaxFRU6
8HdI76Mr
=9O8F
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
