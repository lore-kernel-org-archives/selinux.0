Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3IJr46J000721
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 15:53:04 -0400
Received: by mail-ve0-f182.google.com with SMTP id jw12so3692453veb.27
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 12:53:03 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Apr 2014 14:53:03 -0500
Message-ID: <CAGReGbRtk7pAZ+vz4W4cfXggo1zO5xuJOGWNxdi2xEHt=QOfZQ@mail.gmail.com>
Subject: Unreadable or missing xattr security.selinux on jffs2
From: Judd Meinders <judd.meinders@rockwellcollins.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b339db160557e04f7567f6b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b339db160557e04f7567f6b
Content-Type: text/plain; charset=ISO-8859-1

Hello fellow selinux users:

I am currently working on a system that uses embedded linux with a few
jffs2 file systems on NAND flash.  Each time my device boots, several flash
partitions are mounted to various mount points throughout my root fs.  Some
are readonly, a couple are rw.

What I am seeing is that sometimes, when the mount happens on a rw
partition, the label that shows for the mount point is "file_t".  This is
not the label that was contained in the xattr on the last boot.  My selinux
policy is set up to mark file systems which are missing the
security.selinux attrs as file_t.  In each subsequent boot/mount, the root
directory of the mounted filesystem remains "file_t" until I manually chcon
or restorecon (in premissive)

Furthermore, there are no domains in the selinux policy that have
permissions to relabel directories of the type that I am mounting.  So my
first question is, does anyone have any idea as to how the label could
disappear?  Has anyone ever seen behavior like this on JFFS2?

Is this more of a jffs2 question?  Other attrs like date modified, and DAC
permissions remain intact.

I thank anyone for the consideration.

Judd

--047d7b339db160557e04f7567f6b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello fellow selinux users:<div><br></div><div>I am curren=
tly working on a system that uses embedded linux with a few jffs2 file syst=
ems on NAND flash. =A0Each time my device boots, several flash partitions a=
re mounted to various mount points throughout my root fs. =A0Some are reado=
nly, a couple are rw.
</div><div><br></div><div>What I am seeing is that sometimes, when the moun=
t happens on a rw partition, the label that shows for the mount point is &q=
uot;file_t&quot;. =A0This is not the label that was contained in the xattr =
on the last boot. =A0My selinux policy is set up to mark file systems which=
 are missing the security.selinux attrs as file_t. =A0In each subsequent bo=
ot/mount, the root directory of the mounted filesystem remains &quot;file_t=
&quot; until I manually chcon or restorecon (in premissive)</div>
<div><br></div><div>Furthermore, there are no domains in the selinux policy=
 that have permissions to relabel directories of the type that I am mountin=
g. =A0So my first question is, does anyone have any idea as to how the labe=
l could disappear? =A0Has anyone ever seen behavior like this on JFFS2?</di=
v>
<div><br></div><div>Is this more of a jffs2 question? =A0Other attrs like d=
ate modified, and DAC permissions remain intact.</div><div><br></div><div>I=
 thank anyone for the consideration.</div><div><br></div><div>Judd</div></d=
iv>

--047d7b339db160557e04f7567f6b--
