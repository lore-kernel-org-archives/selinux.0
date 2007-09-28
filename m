Date: Fri, 28 Sep 2007 14:09:50 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] Improve SELinux performance when AVC misses.
In-Reply-To: <46FD37F7.4020602@ak.jp.nec.com>
Message-ID: <Xine.LNX.4.64.0709281408080.18330@us.intercode.com.au>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
 <200708211111.27019.paul.moore@hp.com>  <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>
  <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>
 <46E7583C.9030103@ak.jp.nec.com>  <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
  <46F22BEF.9050208@ak.jp.nec.com>  <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>
  <46F89767.2090203@ak.jp.nec.com>  <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil>
  <46F9F2E2.4060406@ak.jp.nec.com> <46FB13EE.3040907@ak.jp.nec.com>
 <46FB18D1.6080608@ak.jp.nec.com>  <Xine.LNX.4.64.0709271342000.21590@us.intercode.com.au>
  <46FCDDF0.9090707@ak.jp.nec.com> <1190990867.22078.29.camel@moss-spartans.epoch.ncsc.mil>
 <46FD37F7.4020602@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="927316971-1700419040-1191013790=:18330"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--927316971-1700419040-1191013790=:18330
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by jazzhorn.ncsc.mil id l8SLAEDp014012

On Sat, 29 Sep 2007, KaiGai Kohei wrote:

> Stephen Smalley wrote:
> > On Fri, 2007-09-28 at 19:56 +0900, KaiGai Kohei wrote:
> >> James Morris wrote:
> >>>> ++			struct ebitmap_node *_n;
> >>>> ++			_n =3D kzalloc(sizeof(*_n), GFP_KERNEL);
> >>> Leading underscores are usually used to indicate that core code is =
not=20
> >>> supposed to use the symbol.  Please change it to not have a leading=
=20
> >>> underscore.  'tmp' or 'n2' is probably ok.
> >> OK, I replaced all of '_n' by 'tmp'.
> >> Rest of the part in the following patch is same as the previous one.
> >=20
> > Seems to be damaged, or at least doesn't apply for me.  What is it
> > relative to?
>=20
> I generated the patch against to the latest of James's git tree
> But it seems to me that all tab chatacters are translated into
> four white spaces, when I copied and pasted the patch.
> I'm sorry, it was my misoperation.
>=20
> Can you receive it with tab kept in this time?

Yes, but there are compiler warnings on 64-bit.

Please test it on a 64-bit machine.

$ make -j3 SUBDIRS=3Dsecurity
  CC      security/selinux/ss/ebitmap.o
  CC      security/selinux/ss/sidtab.o
  CC      security/selinux/ss/avtab.o
security/selinux/ss/ebitmap.c: In function =E2=80=98ebitmap_netlbl_import=
=E2=80=99:
security/selinux/ss/ebitmap.c:196: warning: right shift count >=3D width =
of type
security/selinux/ss/ebitmap.c: In function =E2=80=98ebitmap_read=E2=80=99=
:
security/selinux/ss/ebitmap.c:393: warning: format =E2=80=98%Zd=E2=80=99 =
expects type =E2=80=98signed size_t=E2=80=99, but argument 3 has type =E2=
=80=98u32=E2=80=99
security/selinux/ss/ebitmap.c:399: warning: format =E2=80=98%Zd=E2=80=99 =
expects type =E2=80=98signed size_t=E2=80=99, but argument 3 has type =E2=
=80=98u32=E2=80=99
security/selinux/ss/ebitmap.c:437: warning: right shift count >=3D width =
of type


--=20
James Morris
<jmorris@namei.org>
--927316971-1700419040-1191013790=:18330--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
