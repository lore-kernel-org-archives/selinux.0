Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6PKxt9n021596
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 16:59:55 -0400
Received: from mail-fx0-f215.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6PL0k83016584
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 21:00:47 GMT
Received: by fxm11 with SMTP id 11so2062844fxm.18
        for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 13:59:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1248553007.13970.3.camel@notebook2.grift.internal>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
	 <1248553007.13970.3.camel@notebook2.grift.internal>
Date: Sat, 25 Jul 2009 13:59:53 -0700
Message-ID: <81092d890907251359x4eb2914v3247c752d326e612@mail.gmail.com>
Subject: Re: "Error! Unable to set executable context."
From: Larry Ross <selinux.larry@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636b4313da0958d046f8e00a8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636b4313da0958d046f8e00a8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Jul 25, 2009 at 1:16 PM, Dominick Grift <domg472@gmail.com> wrote:
On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:
> I am trying to create a custom selinux user for the strict policy on
> RHEL5.3
> I want logins that are mapped to this user to be able to login via
> gdm, but when they do I get an error "Error! Unable to set executable
> context."
>
> What does this error message mean?
>
> I am able to login via gdm with logins that are mapped to user_u.  I
> have run the AVCs generated when I login in permissive mode (which
> succeeds) through audit2allow and gotten to the point where it doesn't
> seem that I am getting any killer AVCs.  What am I missing that is
> needed for a custom user to use X-Windows?  Is there some place I can
> look to determine what is causing the error?
>
>    Thank you,
>    Larry
>
> /var/log/messages:
>  Jul 25 11:51:21 newhost gdm[4673]: SELinux gdm login: unable to
> obtain default security context for appuser.
>
>
>  /var/log/audit/audit.log:
> type=USER_AUTH msg=audit(1248550033.507:1432): user pid=3003 uid=0
> auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> authentication acct="?" : exe="/usr/sbin/gdm-binary" (hostname=?,
> addr=?, terminal=:0 res=failed)'
> type=USER_LOGIN msg=audit(1248550033.507:1433): user pid=3003 uid=0
> auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> msg='acct=dbapp: exe="/usr/sbin/gdm-binary" (hostname=newhost,
> addr=127.0.0.1, terminal=:0 res=failed)'
> type=USER_AUTH msg=audit(1248550043.787:1434): user pid=3003 uid=0
> auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> authentication acct="appuser" :
> exe="/usr/sbin/gdm-binary" (hostname=?, addr=?, terminal=:0
> res=success)'
> type=USER_ACCT msg=audit(1248550043.789:1435): user pid=3003 uid=0
> auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> accounting acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?,
> addr=?, terminal=:0 res=success)'
> type=CRED_ACQ msg=audit(1248550043.790:1436): user pid=3003 uid=0
> auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> setcred acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?,
> addr=?, terminal=:0 res=success)'
> type=LOGIN msg=audit(1248550043.796:1437): login pid=3003 uid=0 old
> auid=14022 new auid=14020 old ses=35 new ses=36
> type=USER_START msg=audit(1248550043.804:1438): user pid=3003 uid=0
> auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> session open acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?,
> addr=?, terminal=:0 res=success)'
> type=USER_LOGIN msg=audit(1248550043.804:1439): user pid=3003 uid=0
> auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='uid=14020:
> exe="/usr/sbin/gdm-binary" (hostname=newhost, addr=127.0.0.1,
> terminal=:0 res=success)'
> type=USER_END msg=audit(1248550092.461:1440): user pid=3003 uid=0
> auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> session close acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?,
> addr=?, terminal=:0 res=success)'
> type=CRED_DISP msg=audit(1248550092.461:1441): user pid=3003 uid=0
> auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
> setcred acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?,
> addr=?, terminal=:0 res=success)'
>
 Dominick,
  Thank you for your reply.

> probably means you have no default contexts defined for "appuser"


How do I define a default context for an selinux user?


>
> can you show us the output of 'semanage user -l | grep appuser'?


 [root@newhost ~]# semanage user -l | grep appuser
returns no results, as I would expect, appuser is a linux login id, not an
selinux user.

[root@newhost ~]# semanage login -l | grep appuser
appuser                   app_user_u                 s0


> If this user is based of off user_u you could simply:
>
> cp /etc/selinux/contexts/users/user_u /etc/selinux/contexts/users/appuser
>
> but it depends on how your appuser selinux-user is configured ( whats
> his default domain )


The only thing in /etc/selinux/strict/contexts/users/
is "root", there is no file there for user_u.

  -- Larry

--001636b4313da0958d046f8e00a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>On Sat, Jul 25, 2009 at 1:16 PM, Dominick Grift <span dir=3D"ltr">&lt;=
<a href=3D"mailto:domg472@gmail.com">domg472@gmail.com</a>&gt;</span> wrote=
:<br>On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:<br>&gt; I am tryi=
ng to create a custom selinux user for the strict policy on<br>
&gt; RHEL5.3<br>&gt; I want logins that are mapped to this user to be able =
to login via<br>&gt; gdm, but when they do I get an error &quot;Error! Unab=
le to set executable<br>&gt; context.&quot;<br>&gt;<br>&gt; What does this =
error message mean?<br>
&gt;<br>&gt; I am able to login via gdm with logins that are mapped to user=
_u. =A0I<br>&gt; have run the AVCs generated when I login in permissive mod=
e (which<br>&gt; succeeds) through audit2allow and gotten to the point wher=
e it doesn&#39;t<br>
&gt; seem that I am getting any killer AVCs. =A0What am I missing that is<b=
r>&gt; needed for a custom user to use X-Windows? =A0Is there some place I =
can<br>&gt; look to determine what is causing the error?<br>&gt;<br>&gt; =
=A0 =A0Thank you,<br>
&gt; =A0 =A0Larry<br>&gt;<br>&gt; /var/log/messages:<br>&gt; =A0Jul 25 11:5=
1:21 newhost gdm[4673]: SELinux gdm login: unable to<br>&gt; obtain default=
 security context for appuser.<br>&gt;<br>&gt;<br>&gt; =A0/var/log/audit/au=
dit.log:<br>
&gt; type=3DUSER_AUTH msg=3Daudit(1248550033.507:1432): user pid=3D3003 uid=
=3D0<br>&gt; auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=
=3D&#39;PAM:<br>&gt; authentication acct=3D&quot;?&quot; : exe=3D&quot;/usr=
/sbin/gdm-binary&quot; (hostname=3D?,<br>
&gt; addr=3D?, terminal=3D:0 res=3Dfailed)&#39;<br>&gt; type=3DUSER_LOGIN m=
sg=3Daudit(1248550033.507:1433): user pid=3D3003 uid=3D0<br>&gt; auid=3D140=
22 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023<br>&gt; msg=3D&#39;acct=3D=
dbapp: exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostname=3Dnewhost,<br>
&gt; addr=3D127.0.0.1, terminal=3D:0 res=3Dfailed)&#39;<br>&gt; type=3DUSER=
_AUTH msg=3Daudit(1248550043.787:1434): user pid=3D3003 uid=3D0<br>&gt; aui=
d=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM:<br>=
&gt; authentication acct=3D&quot;appuser&quot; :<br>
&gt; exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostname=3D?, addr=3D?, termin=
al=3D:0<br>&gt; res=3Dsuccess)&#39;<br>&gt; type=3DUSER_ACCT msg=3Daudit(12=
48550043.789:1435): user pid=3D3003 uid=3D0<br>&gt; auid=3D14022 subj=3Dsys=
tem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM:<br>
&gt; accounting acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-bina=
ry&quot; (hostname=3D?,<br>&gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;=
<br>&gt; type=3DCRED_ACQ msg=3Daudit(1248550043.790:1436): user pid=3D3003 =
uid=3D0<br>&gt; auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 =
msg=3D&#39;PAM:<br>
&gt; setcred acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&=
quot; (hostname=3D?,<br>&gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br=
>&gt; type=3DLOGIN msg=3Daudit(1248550043.796:1437): login pid=3D3003 uid=
=3D0 old<br>&gt; auid=3D14022 new auid=3D14020 old ses=3D35 new ses=3D36<br=
>
&gt; type=3DUSER_START msg=3Daudit(1248550043.804:1438): user pid=3D3003 ui=
d=3D0<br>&gt; auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 ms=
g=3D&#39;PAM:<br>&gt; session open acct=3D&quot;appuser&quot; : exe=3D&quot=
;/usr/sbin/gdm-binary&quot; (hostname=3D?,<br>
&gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; type=3DUSER_LOGIN =
msg=3Daudit(1248550043.804:1439): user pid=3D3003 uid=3D0<br>&gt; auid=3D14=
020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;uid=3D14020:<b=
r>&gt; exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostname=3Dnewhost, addr=3D1=
27.0.0.1,<br>
&gt; terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; type=3DUSER_END msg=3Daudit(=
1248550092.461:1440): user pid=3D3003 uid=3D0<br>&gt; auid=3D14020 subj=3Ds=
ystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM:<br>&gt; session close=
 acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostn=
ame=3D?,<br>
&gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; type=3DCRED_DISP m=
sg=3Daudit(1248550092.461:1441): user pid=3D3003 uid=3D0<br>&gt; auid=3D140=
20 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM:<br>&gt; se=
tcred acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&quot; (=
hostname=3D?,<br>
&gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt;<br></div>
<div>
<div>Dominick,</div>
<div>=A0 Thank you for your reply.<br></div></div>
<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">probably means you have no defau=
lt contexts defined for &quot;appuser&quot;</blockquote>
<div>=A0</div>
<div>How do I define a default context for an selinux user?</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>can you show us the output o=
f &#39;semanage user -l | grep appuser&#39;?</blockquote>
<div>=A0</div>
<div>
<div>[root@newhost ~]# semanage user -l | grep appuser<br></div>
<div>returns no results, as I would expect, appuser is a linux login id, no=
t an selinux user.</div>
<div><br>[root@newhost ~]# semanage login -l | grep appuser<br>appuser=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 app_user_u=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s0<br><br></div></div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>If this user is based of off=
 user_u you could simply:<br><br>cp /etc/selinux/contexts/users/user_u /etc=
/selinux/contexts/users/appuser<br>
<br>but it depends on how your appuser selinux-user is configured ( whats<b=
r>his default domain )</blockquote>
<div>=A0</div>
<div>The only thing in /etc/selinux/strict/contexts/users/</div>
<div>is &quot;root&quot;, there is no file there for user_u.</div>
<div>=A0</div>
<div>=A0 -- Larry</div></div><br>

--001636b4313da0958d046f8e00a8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
