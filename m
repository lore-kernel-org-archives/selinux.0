Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s15I80oO023909
 for <selinux@tycho.nsa.gov>; Wed, 5 Feb 2014 13:08:00 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so1079687qac.22
 for <selinux@tycho.nsa.gov>; Wed, 05 Feb 2014 10:07:59 -0800 (PST)
MIME-Version: 1.0
From: leo kirotawa <kirotawa@gmail.com>
Date: Wed, 5 Feb 2014 16:07:39 -0200
Message-ID: <CA+KS1kaJu1RarB3X60NZFsoJduYrP4ZD+UnzppeHH9-x+jPYiw@mail.gmail.com>
Subject: audit2allow: invalid binary policy
To: Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c3f2b4159b8504f1aca3c5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c3f2b4159b8504f1aca3c5
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm having issues when use audit2allow in a Z machine with Fedora 19.
This is the output message it raises:

audit2allow -a
security: ebitmap: map size 1064 does not match my size 64 (high bit was
595)
invalid binary policy


As a solution I thought in recompile my whole policy and generate a new
/policy/binary, but this time I grabbed a ERROR: (serefpolicy-3.12.1)

/usr/bin/checkmodule base.conf -o tmp/base.mod
/usr/bin/checkmodule:  loading policy configuration from base.conf
policy/modules/kernel/domain.te":256:ERROR 'unknown type tape_device_t used
in transition definition' at token ';' on line 22729:
#line 256
    type_transition unconfined_domain_type device_t:chr_file tape_device_t
"ht00";
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/base.mod] Error 1

Looking in my /dev/ I did not find any 'ht00' device, what makes me suppose
maybe it is the problem. Also looking in .te files I saw tape_device_t is
defined into storage.te, and in this point I have no idea what is cause of
this problem or how to fix it.

Have you ever seen it before?

--001a11c3f2b4159b8504f1aca3c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I&#39;m having issues when use =
audit2allow in a Z machine with Fedora 19. <br></div>This is the output mes=
sage it raises:<br><br>audit2allow -a<br>security: ebitmap: map size 1064 d=
oes not match my size 64 (high bit was 595)<br clear=3D"all">

<div><div><div>invalid binary policy<br><br><br></div><div>As a solution I =
thought in recompile my whole policy and generate a new /policy/binary, but=
 this time I grabbed a ERROR: (serefpolicy-3.12.1)<br><br>/usr/bin/checkmod=
ule base.conf -o tmp/base.mod<br>

/usr/bin/checkmodule:=A0 loading policy configuration from base.conf<br>pol=
icy/modules/kernel/domain.te&quot;:256:ERROR &#39;unknown type tape_device_=
t used in transition definition&#39; at token &#39;;&#39; on line 22729:<br=
>

#line 256<br>=A0=A0=A0 type_transition unconfined_domain_type device_t:chr_=
file tape_device_t &quot;ht00&quot;;<br>/usr/bin/checkmodule:=A0 error(s) e=
ncountered while parsing configuration<br>make: *** [tmp/base.mod] Error 1<=
br>
<br>
</div><div>Looking in my /dev/ I did not find any &#39;ht00&#39; device, wh=
at makes me suppose maybe it is the problem. Also looking in .te files I sa=
w tape_device_t is defined into storage.te, and in this point I have no ide=
a what is cause of this problem or how to fix it. <br>

</div><div><br></div><div>Have you ever seen it before? <br></div><div><br>=
</div><div><br></div><div><br><br><br>
</div></div></div></div>

--001a11c3f2b4159b8504f1aca3c5--
