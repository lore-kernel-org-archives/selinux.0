Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86GjorT021925
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 12:45:50 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86GivvL026844
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 16:44:58 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id DDBC8C4C098
	for <selinux@tycho.nsa.gov>; Mon,  6 Sep 2004 18:45:43 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 02076-08 for <selinux@tycho.nsa.gov>;
	Mon, 6 Sep 2004 18:45:43 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD9E4F00F.dip.t-dialin.net [217.228.240.15])
	by legolas.drinsama.de (Postfix) with ESMTP id 1F385C4C08E
	for <selinux@tycho.nsa.gov>; Mon,  6 Sep 2004 18:45:43 +0200 (CEST)
Received: from [127.0.0.1] (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 3DAEF4880C8
	for <selinux@tycho.nsa.gov>; Mon,  6 Sep 2004 18:45:42 +0200 (CEST)
Subject: domains/local/*.te file_contexts/local/*.fc
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-EhbqdlOMb/uGXr/VPvHG"
Date: Mon, 06 Sep 2004 18:45:41 +0200
Message-Id: <1094489141.3973.40.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EhbqdlOMb/uGXr/VPvHG
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
the patch below adds support for domains/local/*.te and
file_contexts/local/*.fc to the Makefile.

I prefer having my local policy modifications in there, instead of
cluttering the "programs" part.

Also the modifications will be loaded last, which is especially helpful
for the "file_contexts" part, since it allows you to override the file
context of files easily.

If there is a nicer way to achieve this, please tell me.

I also havn't tested the behaviour when the wildcard statements don't
expand, and i'm not enough a make guru to tell you if they'll just
expand to nothing like i'd like them to. ;-)

Greetings,
Erich Schubert
--=20
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
      Which is worse: ignorance or apathy? Who knows? Who cares?      //\
 Man kann sich auch in Gesellschaft anderer einsam f=FChlen. Weizs=E4cker=
 V_/_

--=-EhbqdlOMb/uGXr/VPvHG
Content-Disposition: attachment; filename=Makefile.diff
Content-Type: text/x-patch; name=Makefile.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- /usr/share/selinux/policy/default/Makefile	2004-08-02 09:28:37.000000000 +0200
+++ Makefile	2004-09-06 18:39:42.000000000 +0200
@@ -33,7 +33,7 @@
 ALL_PROGRAM_MACROS := $(wildcard macros/program/*.te)
 ALL_MACROS := $(ALL_PROGRAM_MACROS) $(wildcard macros/*.te)
 ALL_TYPES := $(wildcard types/*.te)
-ALL_DOMAINS := $(wildcard domains/*.te domains/misc/*.te domains/program/*.te)
+ALL_DOMAINS := $(wildcard domains/*.te domains/misc/*.te domains/program/*.te domains/local/*.te)
 ALLTEFILES := attrib.te tmp/program_used_flags.te $(ALL_MACROS) $(ALL_TYPES) $(ALL_DOMAINS) assert.te 
 TE_RBAC_FILES := $(ALLTEFILES) rbac
 ALL_TUNABLES := $(wildcard tunables/*.te )
@@ -49,7 +49,7 @@
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
-FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
+FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) $(wildcard file_contexts/local/*.fc)
 
 APPDIR=$(CONTEXTPATH)
 APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context)

--=-EhbqdlOMb/uGXr/VPvHG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
