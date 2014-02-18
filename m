Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1ILNMe8030029
 for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2014 16:23:23 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9E7D520EF5
 for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2014 16:23:18 -0500 (EST)
Received: from [192.168.1.5] (unknown [66.31.18.51])
 by mail.messagingengine.com (Postfix) with ESMTPA id 361DD680123
 for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2014 16:23:18 -0500 (EST)
Date: Tue, 18 Feb 2014 21:18:17 +0000
From: Colin Walters <walters@verbum.org>
Subject: cross-labeling vs precompiled PCRE
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-2y+hbG+HUj5XDFZAkhFW"
Message-Id: <20140218212318.361DD680123@frontend2.nyi.mail.srv.osa>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-2y+hbG+HUj5XDFZAkhFW
Content-Type: text/plain; charset=utf-8; format=flowed

Hi,

So my rpm-ostree system is doing "cross labeling" - in my case, the 
build host is RHEL7, and the target system is Fedora rawhide.

Concretely, I'm using selinux_set_policy_root() to load the policy from 
a chroot, then selabel_open (SELABEL_CTX_FILE).

I know this might eventually break if Fedora's SELinux policy format 
breaks from what RHEL7 can understand...but I'm hoping to avoid that 
(or alternatively, update the RHEL7 SELinux libraries to understand 
newer formats).

The advantage of doing it this way is I don't need to run through 
Anaconda (or more generally, execute any *code* from the OS I'm 
building).  Which in turn makes the system reliable and fast.

There is one problem though - the PCRE precompiled regexps in e.g. 
"file_contexts.bin".  It turns out that the RHEL7 pcre silently fails 
to match the ones from rawhide =/

I work around this by temporarily moving the .bin out of the way.

But how about extending the file format to include e.g. the result of 
pcre_version(), and having the label code only use the mmap cache if 
the saved PCRE version exactly matches that on the system?

This would cause labeling slowdowns when the pcre RPM is rebuilt until 
the selinux-policy RPM is later rebuilt, but that seems better than 
potentially silent failures.

Thoughts?

--=-2y+hbG+HUj5XDFZAkhFW
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>So my rpm-ostree system is doing "cross labeling" - =
in my case, the build host is RHEL7, and the target system is Fedora rawhid=
e.</div><div><br></div><div>Concretely, I'm using selinux_set_policy_root()=
 to load the policy from a chroot, then selabel_open (SELABEL_CTX_FILE).</d=
iv><div><br></div><div>I know this might eventually break if Fedora's SELin=
ux policy format breaks from what RHEL7 can understand...but I'm hoping to =
avoid that (or alternatively, update the RHEL7 SELinux libraries to underst=
and newer formats).</div><div><br></div><div>The advantage of doing it this=
 way is I don't need to run through Anaconda (or more generally, execute an=
y *code* from the OS I'm building). &nbsp;Which in turn makes the system re=
liable and fast.</div><div><br></div><div>There is one problem though - the=
 PCRE precompiled regexps in e.g. "file_contexts.bin". &nbsp;It turns out t=
hat the RHEL7 pcre silently fails to match the ones from rawhide =3D/</div>=
<div><br></div><div>I work around this by temporarily moving the .bin out o=
f the way.</div><div><br></div><div>But how about extending the file format=
 to include e.g. the result of pcre_version(), and having the label code on=
ly use the mmap cache if the saved PCRE version exactly matches that on the=
 system?</div><div><br></div><div>This would cause labeling slowdowns when =
the pcre RPM is rebuilt until the selinux-policy RPM is later rebuilt, but =
that seems better than potentially silent failures.</div><div><br></div><di=
v>Thoughts?</div>=

--=-2y+hbG+HUj5XDFZAkhFW--
