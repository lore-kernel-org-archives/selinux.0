Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r39KWQWq030499
	for <selinux@tycho.nsa.gov>; Tue, 9 Apr 2013 16:32:26 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so3171785qca.18
        for <selinux@tycho.nsa.gov>; Tue, 09 Apr 2013 13:32:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51422EB6.7000807@mthode.org>
References: <51422EB6.7000807@mthode.org>
Date: Tue, 9 Apr 2013 22:32:25 +0200
Message-ID: <CAPzO=NyXe5LyjS_xV68gAJ9oOXiotP0DmDhrqrRrNVgZrP4jvA@mail.gmail.com>
Subject: Re: semanage support for nsswitch
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=20cf306f76be86f35604d9f37308
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf306f76be86f35604d9f37308
Content-Type: text/plain; charset=ISO-8859-1

On Mar 14, 2013 9:18 PM, "Matthew Thode" <mthode@mthode.org> wrote:
>
> I've noticed that semanage does not support nsswitch, is there a reason
> for this or am I somehow blind?

As I'm about to move towards ldap authentication i'm interested in this as
well. Especially for group information this would be very interesting as I
can then assign users to their SELinux user counterpart based on the
primary group (if I read it all well).

--20cf306f76be86f35604d9f37308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Mar 14, 2013 9:18 PM, &quot;Matthew Thode&quot; &lt;<a href=3D"mailto:mt=
hode@mthode.org">mthode@mthode.org</a>&gt; wrote:<br>
&gt;<br>
&gt; I&#39;ve noticed that semanage does not support nsswitch, is there a r=
eason<br>
&gt; for this or am I somehow blind?</p>
<p dir=3D"ltr">As I&#39;m about to move towards ldap authentication i&#39;m=
 interested in this as well. Especially for group information this would be=
 very interesting as I can then assign users to their SELinux user counterp=
art based on the primary group (if I read it all well).</p>


--20cf306f76be86f35604d9f37308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
