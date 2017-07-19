Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6JLiXjw006875
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 17:44:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id 15so1383263wmm.3
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 13:49:50 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id a25sm483923eda.44.2017.07.19.13.49.48
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Jul 2017 13:49:48 -0700 (PDT)
Date: Wed, 19 Jul 2017 22:49:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170719204946.GA2890@julius.enp8s0.d30>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
 <1500383878.18445.1.camel@tycho.nsa.gov>
 <1500405609.18445.14.camel@tycho.nsa.gov>
 <CAHC9VhQz686zC06smDZHf_GYF8EmHpErX5xXnx9bifU51EkwrQ@mail.gmail.com>
 <03f326bc-599c-0074-0cc2-7f46808673a1@ieee.org>
 <20170719071233.GA7053@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
In-Reply-To: <20170719071233.GA7053@julius.enp8s0.d30>
Subject: [SUSPECTED SPAM] [SUSPICIOUS MESSAGE] Re: [PATCH] selinux: Generalize
 support for NNP/nosuid SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--n8g4imXOkfNTN/H1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 19, 2017 at 09:12:33AM +0200, Dominick Grift wrote:
> On Tue, Jul 18, 2017 at 09:07:45PM -0400, Chris PeBenito wrote:
> > On 07/18/2017 05:26 PM, Paul Moore wrote:
> > > On Tue, Jul 18, 2017 at 3:20 PM, Stephen Smalley <sds@tycho.nsa.gov> =
wrote:
> > > > On Tue, 2017-07-18 at 09:17 -0400, Stephen Smalley wrote:
> > > > > On Mon, 2017-07-17 at 15:54 -0400, Paul Moore wrote:
> > > > > > On Sun, Jul 16, 2017 at 11:15 AM, Jason Zaman <jason@perfinion.=
com>
> > > > > > wrote:
> > >=20
> > > ...
> > >=20
> > > > > > > Why do we want to disallow type-bounds to work even with the
> > > > > > > capability?
> > > > > > > it seems sensible to me to allow typebounds to transition eve=
n in
> > > > > > > the
> > > > > > > future. If we do then we probably dont need the policycap whi=
ch
> > > > > > > seems
> > > > > > > less complicated.
> > > > > >=20
> > > > > > The suggestion to continue to support bounded domain transitions
> > > > > > seems
> > > > > > reasonable to me, although we would need to worry about which c=
heck
> > > > > > to
> > > > > > do first (bounded transition or process:nnp_nosuid_transition),=
 and
> > > > > > how to limit the auditing/reporting so admins are confused by t=
he
> > > > > > first check failing, yet the transition still taking place.  No=
ne
> > > > > > of
> > > > > > these are unsolvable problems, but it will likely need a bit mo=
re
> > > > > > work.
> > > > > >=20
> > > > > > I'm sure Stephen has some thoughts on this as well.
> > > > >=20
> > > > > Others (e.g. Dominick) seemed to take the opposite view on the
> > > > > earlier
> > > > > RFC discussion, i.e. that we should only check the new permission=
 if
> > > > > the capability is enabled.  I specifically raised that as a quest=
ion
> > > > > there.
> > > > >=20
> > > > > I'm willing to change it to fallback to checking for a bounded ty=
pe,
> > > > > but that will mean two audit messages (I don't think we can just =
hide
> > > > > one of them) when neither is allowed.  That said, it is unlikely =
to
> > > > > cause much confusion in practice because users typically only look
> > > > > for
> > > > > and pay attention to AVC messages, and anyone using audit2allow w=
ill
> > > > > just end up allowing the permission, not the bounds.
> > > >=20
> > > > As Jason noted, if we fallback to checking for a bounded type, then=
 we
> > > > don't strictly need a policy capability for it.
> > >=20
> > > It seems as though Dominick is okay with the fallback, what do the
> > > rest of the policy folks think about that approach?
>=20
> I am okay with the faillback
>=20
> > >=20
> > > I'm of the opinion that changes which don't require a new policy
> > > capability are slightly more favorable, but since one of the goals
> > > with this change is to make policy development easier, I want to make
> > > sure we are actually doing that.  It would appear we are, but a few
> > > explicit nods from the policy folks would be nice to see.
> >=20
> > With my coder hat on, I can see the value of having the existing behavi=
or be
> > available for anyone who currently uses it, so it makes sense.
>=20
> I agree, its only that I believe that no one is using it because it is im=
practical (except for mod_selinux users, and people that currently use type=
_bounds to deal with nosuid),, mainly because the nnp flag is inherited.
> The only scenario currently where, I believe, type_bounds might be prefer=
ed is containers since container process types do not change and the inheri=
tance aspect is not much of a problem.
>=20
> >=20
> > With my policy hat on, I don't have an opinion on a fallback.  What I do
> > know is I don't like typebounds, avoid it as much as possible, and stro=
ngly
> > prefer it not be forced on me.  There are no typebounds in refpolicy.
> >=20
> > In fact, I think NNP should not affecting SELinux at all as NNP is
> > discretionary and SELinux is mandatory.  NNP makes sense where you star=
t out
> > with lots of privileges and have to shed them, (i.e. the Linux
> > DAC/capabilities perspective) whereas you have no privileges in SELinux
> > except what is explicitly allowed.
> >=20
> > Once this permission is implemented I'll likely add the permission acro=
ss
> > most if not all transitions out of systemd.
>=20
> Yes but do not expect that to ,always, be enough due to the inheritance a=
spect. A process may have inherited the NNP flag, not because its started b=
y systemd but because its started by a process that inherited the NNP flag =
because it was started by systemd.

In dssp2 i have this concept called forked subject types, basically these a=
re systemd daemons *and* any processes types transitioned to by systemd dae=
mons.

These are rules specific for systemd (system) forked subject types*:

[root@julius ~]# sesearch -A -t systemd.system.forked_subj_type_attribute -=
dt
allow systemd.system.subj systemd.system.forked_subj_type_attribute:process=
 { getsched setrlimit setsched };

[root@julius ~]# sesearch -A -s systemd.system.forked_subj_type_attribute -=
ds
allow systemd.system.forked_subj_type_attribute systemd.system.subj:fd use;
allow systemd.system.forked_subj_type_attribute systemd.system.subj:unix_st=
ream_socket { append bind connect getattr getopt ioctl read setattr setopt =
shutdown write };

Here are some types of process types that are (potentially) associated with=
 children of systemd system daemons (but arent daemons themselves):

[root@julius ~]# for i in `seinfo -xasystemd.system.forked_subj_type_attrib=
ute`; do [[ $(seinfo -xt $i | grep "systemd.system.daemon_subj_type_attribu=
te") ]] || echo $i | grep ".subj$"; done
apache.rotatelogs.subj
bootloader.subj
chage.subj
dracut.subj
fuse.fusermount.subj
iputils.subj
kernel_install.subj
kexec_tools.mkdumprd.subj
loadkeys.subj
logger.subj
mysql.daemon.utils.subj
nm_openvpn.subj
notify.subj
nspawn.generic_container.subj
resolve.subj
semodule.subj
seutils.load_policy.subj
seutils.setfiles.subj
sysadm_systemd.subj
tunctl.subj
udisks.lvm.subj
user_systemd.subj
usermanage.groupadd.subj
usermanage.useradd.subj
wheel_systemd.subj
xserver.subj

So if i were to use the nnp_nosuid_transition permission then i would proba=
bly associate it with systemd.system.forked_subj_type_attribute

* output might not be accurate due to limitations CIL/setools

>=20
> >=20
> > --=20
> > Chris PeBenito
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://secure-web.cisco.com/1p1yJD5SgewwVGBgT_zKJkJvFL8qog155yQggcavHJLj=
q48wjbhNA8aQVb-yKQytK0gkNSJhEmUqMNd7ObjKqKswecjvBELF3FoljHWmV5zG0pB2nieTMCq=
4GE3au_YNQm5K0alYZfpAYKBkjlB_W_Ggozlt-y4ubCZAZslUDrFPKKKD8bt3id7r7bbLHxRm9Y=
HUfoGFUUIkGL_yDuJL3Sl1eg0m10DIZooifM6xADBJLIcRPkSRgIK2740270KkcloQimp3iGjxZ=
S04dN6GpqA/https%3A%2F%2Fsks-keyservers.net%2Fpks%2Flookup%3Fop%3Dget%26sea=
rch%3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://secure-web.cisco.com/1p1yJD5SgewwVGBgT_zKJkJvFL8qog155yQggcavHJLjq4=
8wjbhNA8aQVb-yKQytK0gkNSJhEmUqMNd7ObjKqKswecjvBELF3FoljHWmV5zG0pB2nieTMCq4G=
E3au_YNQm5K0alYZfpAYKBkjlB_W_Ggozlt-y4ubCZAZslUDrFPKKKD8bt3id7r7bbLHxRm9YHU=
foGFUUIkGL_yDuJL3Sl1eg0m10DIZooifM6xADBJLIcRPkSRgIK2740270KkcloQimp3iGjxZS0=
4dN6GpqA/https%3A%2F%2Fsks-keyservers.net%2Fpks%2Flookup%3Fop%3Dget%26searc=
h%3D0x3B6C5F1D2C7B6B02
Dominick Grift

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllvxeYACgkQJXSOVTf5
R2kuVwwArdOXtsq8UOYf0lBlxIf+gvrVGlKS9PJUmnxMknAQpzi1bIL86yBwTSem
FHG/N1FIaxV4Eutwjha1LUr0Lgf95OaLsiCmZUxRz/NY9iQ+IK5+LtzzIL8AKHFn
Gkj1yZy/yS/cPzxwISm2bI5pUOQu62eeIGuFLBRKDbVS/ohQ8Oscu/Om2XbVshdG
/639xptwX5FkId12euW/MGu5EpzLox5JyvD7yTr9a6g0uEevJfJviCwhtJUASDvC
tYQd9Dl9c05pPPUqN9pYeD5Ng8GNh8gXOO2HKjyqGJeGZurYwUy0fs1egezxTeFk
mr2/PJw8MFJSGWQAwY19ByRJhBLvKVWDkVybdDtZSI6yOnef+nN+sVbXrJH4eYZ0
rE0DsrWYLeCq7O9QrgTMbaeDLAgM5p7kumYAjNvE5IcsKBNZuF3Qmuq6gjckY9Su
ymvFMwcz/kr6mR4cyn5nvnXub/0bkVDOsOItcYBii3hBH75XqQtetEoVRBixYkwK
x4YC/AXj
=GJ9e
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
