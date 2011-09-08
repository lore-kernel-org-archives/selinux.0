Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p888SMHx024675
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2011 04:28:22 -0400
Received: from snt0-omc4-s13.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p888SL3n009749
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2011 08:28:21 GMT
Message-ID: <SNT139-W470DE8D4A03FB695DB5C13AB1E0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a89507e5-fe0f-4d84-a534-be44921dd1ad_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: RE: [v2 PATCH 3/8] Write and read TUNABLE flags in related data
 structures.
Date: Thu, 8 Sep 2011 08:28:14 +0000
In-Reply-To: 
 <CACLa4pt0EcnT996uPCjYw2Hepqym4q0hs81t08Fxu_bkFASocA@mail.gmail.com>
References: 
 <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>,<1314847787-4055-4-git-send-email-qingtao.cao@windriver.com>,<CACLa4pt0EcnT996uPCjYw2Hepqym4q0hs81t08Fxu_bkFASocA@mail.gmail.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a89507e5-fe0f-4d84-a534-be44921dd1ad_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


I just realized that I could use the checkpatch.pl in linux source tree to detect any potential whitespace problems in the userspace patches as well. Although we put less strict constraints on the style of userspace patches than kernel patches, it still would be advisable to run checkpatch.pl.

Maybe we could mention this in the "How to Create A Patch Set" section in the wiki of http://oss.tresys.com/projects/refpolicy/wiki/HowToContribute

Thanks,
Harry

> Date: Wed, 7 Sep 2011 17:47:43 -0400
> Subject: Re: [v2 PATCH 3/8] Write and read TUNABLE flags in related data structures.
> From: eparis@parisplace.org
> To: qingtao.cao@windriver.com
> CC: selinux@tycho.nsa.gov
> 
> This patch contained 2 whitespace errors.  they have been fixed before
> applying it to my queue branch, however please fix them if there is a
> need to resubmit a v3.
> 
> -Eric
> 
> On Wed, Aug 31, 2011 at 11:29 PM, Harry Ciao <qingtao.cao@windriver.com> wrote:
> > All flags in cond_bool_datum_t and cond_node_t structures are written
> > or read for policy modules which version is no less than
> > MOD_POLICYDB_VERSION_TUNABLE_SEP.
> >
> > Note, for cond_node_t the TUNABLE flag bit would be used only at expand,
> > however, it won't hurt to read/write this field for modules(potentially
> > for future usage).
> >
> > Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> > ---
> > ивlibsepol/src/conditional.c | ив 21 +++++++++++++++++++--
> > ивlibsepol/src/write.c ив ив ив | ив 18 ++++++++++++++++++
> > ив2 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index efdedb0..d9d4fee 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -564,8 +564,8 @@ static int bool_isvalid(cond_bool_datum_t * b)
> > ив ив ив ивreturn 1;
> > ив}
> >
> > -int cond_read_bool(policydb_t * p
> > - ив ив ив ив ив ив ив ив ив__attribute__ ((unused)), hashtab_t h,
> > +int cond_read_bool(policydb_t * p,
> > + ив ив ив ив ив ив ив ив ивhashtab_t h,
> > ив ив ив ив ив ив ив ив ив struct policy_file *fp)
> > ив{
> > ив ив ив ивchar *key = 0;
> > @@ -597,6 +597,15 @@ int cond_read_bool(policydb_t * p
> > ив ив ив ивif (rc < 0)
> > ив ив ив ив ив ив ив ивgoto err;
> > ив ив ив ивkey[len] = 0;
> > +
> > + ив ив ив if (p->policy_type != POLICY_KERN &&
> > + ив ив ив ив ив p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> > + ив ив ив ив ив ив ив rc = next_entry(buf, fp, sizeof(uint32_t));
> > + ив ив ив ив ив ив ив if (rc < 0)
> > + ив ив ив ив ив ив ив ив ив ив ив goto err;
> > + ив ив ив ив ив ив ив booldatum->flags = le32_to_cpu(buf[0]);
> > + ив ив ив }
> > +
> > ив ив ив ивif (hashtab_insert(h, key, booldatum))
> > ив ив ив ив ив ив ив ивgoto err;
> >
> > @@ -810,6 +819,14 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
> > ив ив ив ив ив ив ив ивif (avrule_read_list(p, &node->avfalse_list, fp))
> > ив ив ив ив ив ив ив ив ив ив ив ивgoto err;
> > ив ив ив ив}
> > +
> > + ив ив ив if (p->policy_type != POLICY_KERN &&
> > + ив ив ив ив ив p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> > + ив ив ив ив ив ив ив rc = next_entry(buf, fp, sizeof(uint32_t));
> > + ив ив ив ив ив ив ив if (rc < 0)
> > + ив ив ив ив ив ив ив ив ив ив ив goto err;
> > + ив ив ив ив ив ив ив node->flags = le32_to_cpu(buf[0]);
> > + ив ив ив }
> >
> > ив ив ив ивreturn 0;
> > ив ив ив err:
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index 290e036..4284c93 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -607,6 +607,7 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > ив ив ив ивunsigned int items, items2;
> > ив ив ив ивstruct policy_data *pd = ptr;
> > ив ив ив ивstruct policy_file *fp = pd->fp;
> > + ив ив ив struct policydb *p = pd->p;
> >
> > ив ив ив ивbooldatum = (cond_bool_datum_t *) datum;
> >
> > @@ -621,6 +622,15 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > ив ив ив ивitems = put_entry(key, 1, len, fp);
> > ив ив ив ивif (items != len)
> > ив ив ив ив ив ив ив ивreturn POLICYDB_ERROR;
> > +
> > + ив ив ив if (p->policy_type != POLICY_KERN &&
> > + ив ив ив ив ив p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> > + ив ив ив ив ив ив ив buf[0] = cpu_to_le32(booldatum->flags);
> > + ив ив ив ив ив ив ив items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > + ив ив ив ив ив ив ив if (items != 1)
> > + ив ив ив ив ив ив ив ив ив ив ив return POLICYDB_ERROR;
> > + ив ив ив }
> > +
> > ив ив ив ивreturn POLICYDB_SUCCESS;
> > ив}
> >
> > @@ -727,6 +737,14 @@ static int cond_write_node(policydb_t * p,
> > ив ив ив ив ив ив ив ив ив ив ив ивreturn POLICYDB_ERROR;
> > ив ив ив ив}
> >
> > + ив ив ив if (p->policy_type != POLICY_KERN &&
> > + ив ив ив ив ив p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> > + ив ив ив ив ив ив ив buf[0] = cpu_to_le32(node->flags);
> > + ив ив ив ив ив ив ив items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > + ив ив ив ив ив ив ив if (items != 1)
> > + ив ив ив ив ив ив ив ив ив ив ив return POLICYDB_ERROR;
> > + ив ив ив }
> > +
> > ив ив ив ивreturn POLICYDB_SUCCESS;
> > ив}
> >
> > --
> > 1.7.0.4
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_a89507e5-fe0f-4d84-a534-be44921dd1ad_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:╬в╚э╤┼║┌
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
I just realized that I could use the checkpatch.pl in linux source tree to detect any potential whitespace problems in the userspace patches as well. Although we put less strict constraints on the style of userspace patches than kernel patches, it still would be advisable to run checkpatch.pl.<br><br>Maybe we could mention this in the "How to Create A Patch Set" section in the wiki of http://oss.tresys.com/projects/refpolicy/wiki/HowToContribute<br><br>Thanks,<br>Harry<br><br><div>&gt; Date: Wed, 7 Sep 2011 17:47:43 -0400<br>&gt; Subject: Re: [v2 PATCH 3/8] Write and read TUNABLE flags in related data structures.<br>&gt; From: eparis@parisplace.org<br>&gt; To: qingtao.cao@windriver.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; <br>&gt; This patch contained 2 whitespace errors.  they have been fixed before<br>&gt; applying it to my queue branch, however please fix them if there is a<br>&gt; need to resubmit a v3.<br>&gt; <br>&gt; -Eric<br>&gt; <br>&gt; On Wed, Aug 31, 2011 at!
  11:29 PM, Harry Ciao &lt;qingtao.cao@windriver.com&gt; wrote:<br>&gt; &gt; All flags in cond_bool_datum_t and cond_node_t structures are written<br>&gt; &gt; or read for policy modules which version is no less than<br>&gt; &gt; MOD_POLICYDB_VERSION_TUNABLE_SEP.<br>&gt; &gt;<br>&gt; &gt; Note, for cond_node_t the TUNABLE flag bit would be used only at expand,<br>&gt; &gt; however, it won't hurt to read/write this field for modules(potentially<br>&gt; &gt; for future usage).<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Harry Ciao &lt;qingtao.cao@windriver.com&gt;<br>&gt; &gt; ---<br>&gt; &gt; ивlibsepol/src/conditional.c | ив 21 +++++++++++++++++++--<br>&gt; &gt; ивlibsepol/src/write.c ив ив ив | ив 18 ++++++++++++++++++<br>&gt; &gt; ив2 files changed, 37 insertions(+), 2 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c<br>&gt; &gt; index efdedb0..d9d4fee 100644<br>&gt; &gt; --- a/libsepol/src/conditional.c<br>&gt; &gt; !
 +++ b/libsepol/src/conditional.c<br>&gt; &gt; @@ -564,8 +564,8 @@ stat
ic int bool_isvalid(cond_bool_datum_t * b)<br>&gt; &gt; ив ив ив ивreturn 1;<br>&gt; &gt; ив}<br>&gt; &gt;<br>&gt; &gt; -int cond_read_bool(policydb_t * p<br>&gt; &gt; - ив ив ив ив ив ив ив ив ив__attribute__ ((unused)), hashtab_t h,<br>&gt; &gt; +int cond_read_bool(policydb_t * p,<br>&gt; &gt; + ив ив ив ив ив ив ив ив ивhashtab_t h,<br>&gt; &gt; ив ив ив ив ив ив ив ив ив struct policy_file *fp)<br>&gt; &gt; ив{<br>&gt; &gt; ив ив ив ивchar *key = 0;<br>&gt; &gt; @@ -597,6 +597,15 @@ int cond_read_bool(policydb_t * p<br>&gt; &gt; ив ив ив ивif (rc &lt; 0)<br>&gt; &gt; ив ив ив ив ив ив ив ивgoto err;<br>&gt; &gt; ив ив ив ивkey[len] = 0;<br>&gt; &gt; +<br>&gt; &gt; + ив ив ив if (p-&gt;policy_type != POLICY_KERN &amp;&amp;<br>&gt; &gt; + ив ив ив ив ив p-&gt;policyvers &gt;= MOD_POLICYDB_VERSION_TUNABLE_SEP) {<br>&gt; &gt; + ив ив ив ив ив ив ив rc = next_entry(buf, fp, sizeof(uint32_t));<br>&gt; &gt; + ив ив ив ив ив ив ив if (rc &lt; 0)<br>&gt; &gt; + ив ив ив ив ив ив !
 ив ив ив ив ив goto err;<br>&gt; &gt; + ив ив ив ив ив ив ив booldatum-&gt;flags = le32_to_cpu(buf[0]);<br>&gt; &gt; + ив ив ив }<br>&gt; &gt; +<br>&gt; &gt; ив ив ив ивif (hashtab_insert(h, key, booldatum))<br>&gt; &gt; ив ив ив ив ив ив ив ивgoto err;<br>&gt; &gt;<br>&gt; &gt; @@ -810,6 +819,14 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)<br>&gt; &gt; ив ив ив ив ив ив ив ивif (avrule_read_list(p, &amp;node-&gt;avfalse_list, fp))<br>&gt; &gt; ив ив ив ив ив ив ив ив ив ив ив ивgoto err;<br>&gt; &gt; ив ив ив ив}<br>&gt; &gt; +<br>&gt; &gt; + ив ив ив if (p-&gt;policy_type != POLICY_KERN &amp;&amp;<br>&gt; &gt; + ив ив ив ив ив p-&gt;policyvers &gt;= MOD_POLICYDB_VERSION_TUNABLE_SEP) {<br>&gt; &gt; + ив ив ив ив ив ив ив rc = next_entry(buf, fp, sizeof(uint32_t));<br>&gt; &gt; + ив ив ив ив ив ив ив if (rc &lt; 0)<br>&gt; &gt; + ив ив ив ив ив ив ив ив ив ив ив goto err;<br>&gt; &gt; + ив ив ив ив ив ив ив node-&gt;flags = le32_to_cpu(buf[0]);!
 <br>&gt; &gt; + ив ив ив }<br>&gt; &gt;<br>&gt; &gt; ив ив ив ивreturn
 0;<br>&gt; &gt; ив ив ив err:<br>&gt; &gt; diff --git a/libsepol/src/write.c b/libsepol/src/write.c<br>&gt; &gt; index 290e036..4284c93 100644<br>&gt; &gt; --- a/libsepol/src/write.c<br>&gt; &gt; +++ b/libsepol/src/write.c<br>&gt; &gt; @@ -607,6 +607,7 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)<br>&gt; &gt; ив ив ив ивunsigned int items, items2;<br>&gt; &gt; ив ив ив ивstruct policy_data *pd = ptr;<br>&gt; &gt; ив ив ив ивstruct policy_file *fp = pd-&gt;fp;<br>&gt; &gt; + ив ив ив struct policydb *p = pd-&gt;p;<br>&gt; &gt;<br>&gt; &gt; ив ив ив ивbooldatum = (cond_bool_datum_t *) datum;<br>&gt; &gt;<br>&gt; &gt; @@ -621,6 +622,15 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)<br>&gt; &gt; ив ив ив ивitems = put_entry(key, 1, len, fp);<br>&gt; &gt; ив ив ив ивif (items != len)<br>&gt; &gt; ив ив ив ив ив ив ив ивreturn POLICYDB_ERROR;<br>&gt; &gt; +<br>&gt; &gt; + ив ив ив if (p-&gt;policy_type != P!
 OLICY_KERN &amp;&amp;<br>&gt; &gt; + ив ив ив ив ив p-&gt;policyvers &gt;= MOD_POLICYDB_VERSION_TUNABLE_SEP) {<br>&gt; &gt; + ив ив ив ив ив ив ив buf[0] = cpu_to_le32(booldatum-&gt;flags);<br>&gt; &gt; + ив ив ив ив ив ив ив items = put_entry(buf, sizeof(uint32_t), 1, fp);<br>&gt; &gt; + ив ив ив ив ив ив ив if (items != 1)<br>&gt; &gt; + ив ив ив ив ив ив ив ив ив ив ив return POLICYDB_ERROR;<br>&gt; &gt; + ив ив ив }<br>&gt; &gt; +<br>&gt; &gt; ив ив ив ивreturn POLICYDB_SUCCESS;<br>&gt; &gt; ив}<br>&gt; &gt;<br>&gt; &gt; @@ -727,6 +737,14 @@ static int cond_write_node(policydb_t * p,<br>&gt; &gt; ив ив ив ив ив ив ив ив ив ив ив ивreturn POLICYDB_ERROR;<br>&gt; &gt; ив ив ив ив}<br>&gt; &gt;<br>&gt; &gt; + ив ив ив if (p-&gt;policy_type != POLICY_KERN &amp;&amp;<br>&gt; &gt; + ив ив ив ив ив p-&gt;policyvers &gt;= MOD_POLICYDB_VERSION_TUNABLE_SEP) {<br>&gt; &gt; + ив ив ив ив ив ив ив buf[0] = cpu_to_le32(node-&gt;flags);<br>&gt; &gt; + ив ив ив ив ив ив ив items = put_!
 entry(buf, sizeof(uint32_t), 1, fp);<br>&gt; &gt; + ив ив ив ив ив ив 
ив if (items != 1)<br>&gt; &gt; + ив ив ив ив ив ив ив ив ив ив ив return POLICYDB_ERROR;<br>&gt; &gt; + ив ив ив }<br>&gt; &gt; +<br>&gt; &gt; ив ив ив ивreturn POLICYDB_SUCCESS;<br>&gt; &gt; ив}<br>&gt; &gt;<br>&gt; &gt; --<br>&gt; &gt; 1.7.0.4<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; --<br>&gt; &gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; &gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; &gt; the words "unsubscribe selinux" without quotes as the message.<br>&gt; &gt;<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_a89507e5-fe0f-4d84-a534-be44921dd1ad_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
