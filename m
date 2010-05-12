Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4CE4J3X003982
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 10:04:21 -0400
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4CE5PfL019141
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 14:05:32 GMT
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o4CE9jxP026402
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 09:09:48 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Wed, 12 May 2010 10:04:08 -0400
Subject: Labeling home directories in refpolicy
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95F@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95FEUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95FEUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm trying to adapt a recent refpolicy snapshot (May 4) to OpenSUSE.  (Prev=
iously I adapted the Fedora 12 policy, more as a learning exercise.)  Now I=
'm finding that the refpolicy is not labeling home directories properly (th=
ey all end up as default_t after "fixfiles -F relabel").   I'm running unpr=
ivileged users as user_u and root as sysadm_u, so I expect corresponding la=
bels on files in the home directory.  Is there a special mechanism for gett=
ing the home dirs labeled consistent with the corresponding selinux user, o=
r do I need to define labeling for the files individually in a new module? =
  And how do files in the home dir such as .ssh (which should have a type o=
ther than user_t) get their types?

Or perhaps something is broken in the distribution that is causing labels f=
rom the refpolicy not to be applied in the home dir?

Any insights would be appreciated!

Alan



--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95FEUSAACMS0703e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>I'm trying to adapt a recent refpolicy snapshot (May 4) to OpenSUSE.&n=
bsp; (Previously I adapted the Fedora 12 policy, more as a learning exercis=
e.)&nbsp; Now I'm finding that the refpolicy is not labeling home directori=
es properly (they all end up as default_t
after &quot;fixfiles -F relabel&quot;).&nbsp;&nbsp; I'm running unprivilege=
d users as user_u and root as sysadm_u, so I expect corresponding labels on=
 files in the home directory.&nbsp; Is there a special mechanism for gettin=
g the home dirs labeled consistent with the corresponding
selinux user, or do I need to define labeling for the files individually in=
 a new module?&nbsp;&nbsp; And how do files in the home dir such as .ssh (w=
hich should have a type other than user_t) get their types?</div>
<div>&nbsp;</div>
<div>Or perhaps something is broken in the distribution that is causing lab=
els from the refpolicy not to be applied in the home dir?</div>
<div>&nbsp;</div>
<div>Any insights would be appreciated!</div>
<div>&nbsp;</div>
<div>Alan</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95FEUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
