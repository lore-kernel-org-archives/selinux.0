Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA4DVpxT018645
 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2014 08:31:51 -0500
Received: by mail-oi0-f41.google.com with SMTP id e131so10478491oig.0
 for <selinux@tycho.nsa.gov>; Tue, 04 Nov 2014 05:31:48 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
References: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
Date: Tue, 4 Nov 2014 14:31:48 +0100
Message-ID: <CAPzO=NxBnkkQgJSS_mtdGqW0G6Pb9rVZ8yafG5-qSmjVZjEAPg@mail.gmail.com>
Subject: Re: user_r/sysadm_r/staff_r/unconfined_r
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1137dd48375b8e0507087c63
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1137dd48375b8e0507087c63
Content-Type: text/plain; charset=UTF-8

On Nov 4, 2014 12:46 PM, "Russell Coker" <russell@coker.com.au> wrote:
>
> The role separation seems to give no benefit apart from
sysadm_r/unconfined_r given that we have seuser based constraints and MCS
labels to separate users and that they all use the same types.

I disagree. Roles allow for restricting the domains that users can
transition into. I use them often for granting users "limited root". For
instance dbadm_r for DBAs versus webadm_r for web app server admins.

Wkr,
  Sven Vermeulen

--001a1137dd48375b8e0507087c63
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Nov 4, 2014 12:46 PM, &quot;Russell Coker&quot; &lt;<a href=3D"mailto:ru=
ssell@coker.com.au">russell@coker.com.au</a>&gt; wrote:<br>
&gt;<br>
&gt; The role separation seems to give no benefit apart from sysadm_r/uncon=
fined_r given that we have seuser based constraints and MCS labels to separ=
ate users and that they all use the same types.</p>
<p dir=3D"ltr">I disagree. Roles allow for restricting the domains that use=
rs can transition into. I use them often for granting users &quot;limited r=
oot&quot;. For instance dbadm_r for DBAs versus webadm_r for web app server=
 admins.</p>
<p dir=3D"ltr">Wkr,<br>
=C2=A0 Sven Vermeulen</p>

--001a1137dd48375b8e0507087c63--
