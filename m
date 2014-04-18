Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3IK73Iq001834
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 16:07:03 -0400
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Unreadable or missing xattr security.selinux on jffs2
From: jkmeinde@rockwellcollins.com
Message-ID: <OFBD9B9F38.B7665B76-ON86257CBE.006D959B-86257CBE.006E7F32@rockwellcollins.com>
Date: Fri, 18 Apr 2014 15:06:54 -0500
Content-Type: multipart/alternative;
 boundary="=_alternative 006E7ECF86257CBE_="
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.
--=_alternative 006E7ECF86257CBE_=
Content-Type: text/plain; charset="US-ASCII"

Hello fellow selinux users:
I apologize if this is a duplicate email, the first one I sent was from an 
address that I think is not on the list.

I am currently working on a system that uses embedded linux with a few 
jffs2 file systems on NAND flash.  Each time my device boots, several 
flash partitions are mounted to various mount points throughout my root 
fs.  Some are readonly, a couple are rw.

What I am seeing is that sometimes, when the mount happens on a rw 
partition, the label that shows for the mount point is "file_t".  This is 
not the label that was contained in the xattr on the last boot.  My 
selinux policy is set up to mark file systems which are missing the 
security.selinux attrs as file_t.  In each subsequent boot/mount, the root 
directory of the mounted filesystem remains "file_t" until I manually 
chcon or restorecon (in premissive)

Furthermore, there are no domains in the selinux policy that have 
permissions to relabel directories of the type that I am mounting.  So my 
first question is, does anyone have any idea as to how the label could 
disappear?  Has anyone ever seen behavior like this on JFFS2?

Is this more of a jffs2 question?  Other attrs like date modified, and DAC 
permissions remain intact.

I thank anyone for the consideration.

Judd

--=_alternative 006E7ECF86257CBE_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 color=#2f2f2f face="Arial">Hello fellow selinux users:</font>
<br><font size=2 color=#2f2f2f face="Arial">I apologize if this is a duplicate
email, the first one I sent was from an address that I think is not on
the list.</font>
<br>
<br><font size=2 color=#2f2f2f face="Arial">I am currently working on a
system that uses embedded linux with a few jffs2 file systems on NAND flash.
&nbsp;Each time my device boots, several flash partitions are mounted to
various mount points throughout my root fs. &nbsp;Some are readonly, a
couple are rw.</font>
<br>
<br><font size=2 color=#2f2f2f face="Arial">What I am seeing is that sometimes,
when the mount happens on a rw partition, the label that shows for the
mount point is &quot;file_t&quot;. &nbsp;This is not the label that was
contained in the xattr on the last boot. &nbsp;My selinux policy is set
up to mark file systems which are missing the security.selinux attrs as
file_t. &nbsp;In each subsequent boot/mount, the root directory of the
mounted filesystem remains &quot;file_t&quot; until I manually chcon or
restorecon (in premissive)</font>
<br>
<br><font size=2 color=#2f2f2f face="Arial">Furthermore, there are no domains
in the selinux policy that have permissions to relabel directories of the
type that I am mounting. &nbsp;So my first question is, does anyone have
any idea as to how the label could disappear? &nbsp;Has anyone ever seen
behavior like this on JFFS2?</font>
<br>
<br><font size=2 color=#2f2f2f face="Arial">Is this more of a jffs2 question?
&nbsp;Other attrs like date modified, and DAC permissions remain intact.</font>
<br>
<br><font size=2 color=#2f2f2f face="Arial">I thank anyone for the consideration.</font>
<br>
<br><font size=2 color=#2f2f2f face="Arial">Judd</font><font size=2 face="sans-serif"><br>
</font>
--=_alternative 006E7ECF86257CBE_=--
