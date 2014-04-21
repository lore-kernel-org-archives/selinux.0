In-Reply-To: <535513D3.7000702@tycho.nsa.gov>
References: <OFBD9B9F38.B7665B76-ON86257CBE.006D959B-86257CBE.006E7F32@rockwellcollins.com>
 <535513D3.7000702@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
Subject: Re: Unreadable or missing xattr security.selinux on jffs2
From: jkmeinde@rockwellcollins.com
Message-ID: <OF91F5EBCA.1A99E04C-ON86257CC1.004B42D3-86257CC1.004DB17B@rockwellcollins.com>
Date: Mon, 21 Apr 2014 09:08:37 -0500
Content-Type: multipart/alternative;
 boundary="=_alternative 004DB14C86257CC1_="
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.
--=_alternative 004DB14C86257CC1_=
Content-Type: text/plain; charset="US-ASCII"

Stephen Smalley <sds@tycho.nsa.gov> wrote on 04/21/2014 07:49:23 AM:

> From: Stephen Smalley <sds@tycho.nsa.gov>
> To: jkmeinde@rockwellcollins.com, selinux@tycho.nsa.gov
> Date: 04/21/2014 07:53 AM
> Subject: Re: Unreadable or missing xattr security.selinux on jffs2
> 
> On 04/18/2014 04:06 PM, jkmeinde@rockwellcollins.com wrote:
> > Hello fellow selinux users:
> > I apologize if this is a duplicate email, the first one I sent was 
from
> > an address that I think is not on the list.
> > 
> > I am currently working on a system that uses embedded linux with a few
> > jffs2 file systems on NAND flash.  Each time my device boots, several
> > flash partitions are mounted to various mount points throughout my 
root
> > fs.  Some are readonly, a couple are rw.
> > 
> > What I am seeing is that sometimes, when the mount happens on a rw
> > partition, the label that shows for the mount point is "file_t".  This
> > is not the label that was contained in the xattr on the last boot.  My
> > selinux policy is set up to mark file systems which are missing the
> > security.selinux attrs as file_t.  In each subsequent boot/mount, the
> > root directory of the mounted filesystem remains "file_t" until I
> > manually chcon or restorecon (in premissive)
> > 
> > Furthermore, there are no domains in the selinux policy that have
> > permissions to relabel directories of the type that I am mounting.  So
> > my first question is, does anyone have any idea as to how the label
> > could disappear?  Has anyone ever seen behavior like this on JFFS2?
> > 
> > Is this more of a jffs2 question?  Other attrs like date modified, and
> > DAC permissions remain intact.
> > 
> > I thank anyone for the consideration.
> 
> You said it happens sometimes.  Any distinguishing characteristics of
> when it happens versus when it does not?  And how often does it occur?
> When it does happen, are there any messages with SELinux: in dmesg that
> appear?
> 
> If you boot with SELinux disabled (selinux=0 on kernel command line) and
> manually inspect the xattr via getfattr -n security.selinux
> /path/to/root, does it report the correct value?
> 
> Can you set any other xattrs on the root directory of the filesystem
> (e.g. a user.* attribute, a trusted.* attribute, a POSIX acl) and have
> them preserved across reboot?
> 
> I haven't heard of this behavior but I'm not sure how many people use
> jffs2 with SELinux (I have not).
> 
Thanks for the reply Stephen.  I would say that a file system xattrs will 
survive approx. 40-50 boots before I run into this "missing xattrs" 
problem.  Then, after I fix the security.selinux label, it will last as 
long again.  I am only speculating that the security.selinux xattr is 
totally missing because my selinux policy is a derivation of CLIP, which 
uses the same default context for unlabeled file systems as described 
here.
I have not been able to identify any distinguishing characteristics of 
what happened between the two boots where the context is lost.
I can preserve other xattrs across boot (along with security.selinux), I 
have just now set an ACL which I will look for the next time the "file_t" 
problem manifests.
I suppose I can implement a work around that would restore the labels to 
these file systems during rc.sysinit or something like that, but this is 
not totally desirable as files within these file systems are dynamically 
named and placed with type transitions, so I have no way to predict what 
is there within file_contexts.
I will reply again with my findings on dmesg output and the results of the 
ACL test.

Thanks,
Judd Meinders

--=_alternative 004DB14C86257CC1_=
Content-Type: text/html; charset="US-ASCII"

<tt><font size=2>Stephen Smalley &lt;sds@tycho.nsa.gov&gt; wrote on 04/21/2014
07:49:23 AM:<br>
<br>
&gt; From: Stephen Smalley &lt;sds@tycho.nsa.gov&gt;</font></tt>
<br><tt><font size=2>&gt; To: jkmeinde@rockwellcollins.com, selinux@tycho.nsa.gov</font></tt>
<br><tt><font size=2>&gt; Date: 04/21/2014 07:53 AM</font></tt>
<br><tt><font size=2>&gt; Subject: Re: Unreadable or missing xattr security.selinux
on jffs2</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; On 04/18/2014 04:06 PM, jkmeinde@rockwellcollins.com wrote:<br>
&gt; &gt; Hello fellow selinux users:<br>
&gt; &gt; I apologize if this is a duplicate email, the first one I sent
was from<br>
&gt; &gt; an address that I think is not on the list.<br>
&gt; &gt; <br>
&gt; &gt; I am currently working on a system that uses embedded linux with
a few<br>
&gt; &gt; jffs2 file systems on NAND flash. &nbsp;Each time my device boots,
several<br>
&gt; &gt; flash partitions are mounted to various mount points throughout
my root<br>
&gt; &gt; fs. &nbsp;Some are readonly, a couple are rw.<br>
&gt; &gt; <br>
&gt; &gt; What I am seeing is that sometimes, when the mount happens on
a rw<br>
&gt; &gt; partition, the label that shows for the mount point is &quot;file_t&quot;.
&nbsp;This<br>
&gt; &gt; is not the label that was contained in the xattr on the last
boot. &nbsp;My<br>
&gt; &gt; selinux policy is set up to mark file systems which are missing
the<br>
&gt; &gt; security.selinux attrs as file_t. &nbsp;In each subsequent boot/mount,
the<br>
&gt; &gt; root directory of the mounted filesystem remains &quot;file_t&quot;
until I<br>
&gt; &gt; manually chcon or restorecon (in premissive)<br>
&gt; &gt; <br>
&gt; &gt; Furthermore, there are no domains in the selinux policy that
have<br>
&gt; &gt; permissions to relabel directories of the type that I am mounting.
&nbsp;So<br>
&gt; &gt; my first question is, does anyone have any idea as to how the
label<br>
&gt; &gt; could disappear? &nbsp;Has anyone ever seen behavior like this
on JFFS2?<br>
&gt; &gt; <br>
&gt; &gt; Is this more of a jffs2 question? &nbsp;Other attrs like date
modified, and<br>
&gt; &gt; DAC permissions remain intact.<br>
&gt; &gt; <br>
&gt; &gt; I thank anyone for the consideration.<br>
&gt; <br>
&gt; You said it happens sometimes. &nbsp;Any distinguishing characteristics
of<br>
&gt; when it happens versus when it does not? &nbsp;And how often does
it occur?<br>
&gt; When it does happen, are there any messages with SELinux: in dmesg
that<br>
&gt; appear?<br>
&gt; <br>
&gt; If you boot with SELinux disabled (selinux=0 on kernel command line)
and<br>
&gt; manually inspect the xattr via getfattr -n security.selinux<br>
&gt; /path/to/root, does it report the correct value?<br>
&gt; <br>
&gt; Can you set any other xattrs on the root directory of the filesystem<br>
&gt; (e.g. a user.* attribute, a trusted.* attribute, a POSIX acl) and
have<br>
&gt; them preserved across reboot?<br>
&gt; <br>
&gt; I haven't heard of this behavior but I'm not sure how many people
use<br>
&gt; jffs2 with SELinux (I have not).<br>
&gt; <br>
Thanks for the reply Stephen. &nbsp;I would say that a file system xattrs
will survive approx. 40-50 boots before I run into this &quot;missing xattrs&quot;
problem. &nbsp;Then, after I fix the security.selinux label, it will last
as long again. &nbsp;I am only speculating that the security.selinux xattr
is totally missing because my selinux policy is a derivation of CLIP, which
uses the same default context for unlabeled file systems as described </font></tt><a href="https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-The_file_t_and_default_t_Types.html"><tt><font size=2 color=blue>here.</font></tt></a><a href="https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-The_file_t_and_default_t_Types.html"></a>
<br><tt><font size=2>I have not been able to identify any distinguishing
characteristics of what happened between the two boots where the context
is lost.</font></tt>
<br><tt><font size=2>I can preserve other xattrs across boot (along with
security.selinux), I have just now set an ACL which I will look for the
next time the &quot;file_t&quot; problem manifests.</font></tt>
<br><tt><font size=2>I suppose I can implement a work around that would
restore the labels to these file systems during rc.sysinit or something
like that, but this is not totally desirable as files within these file
systems are dynamically named and placed with type transitions, so I have
no way to predict what is there within file_contexts.</font></tt>
<br><tt><font size=2>I will reply again with my findings on dmesg output
and the results of the ACL test.</font></tt>
<br>
<br><tt><font size=2>Thanks,</font></tt>
<br><tt><font size=2>Judd Meinders</font></tt><font size=2 face="sans-serif"><br>
</font>
--=_alternative 004DB14C86257CC1_=--
