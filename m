Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6PJfj0F015763
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 15:41:45 -0400
Received: from mail-bw0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6PJfKXc018765
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 19:41:20 GMT
Received: by bwz7 with SMTP id 7so1924557bwz.18
        for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 12:41:44 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 25 Jul 2009 12:41:43 -0700
Message-ID: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
Subject: "Error! Unable to set executable context."
From: Larry Ross <selinux.larry@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016364267d91addf1046f8ce990
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364267d91addf1046f8ce990
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I am trying to create a custom selinux user for the strict policy on RHEL5.3
I want logins that are mapped to this user to be able to login via gdm, but
when they do I get an error "Error! Unable to set executable context."

What does this error message mean?

I am able to login via gdm with logins that are mapped to user_u.  I have
run the AVCs generated when I login in permissive mode (which succeeds)
through audit2allow and gotten to the point where it doesn't seem that I am
getting any killer AVCs.  What am I missing that is needed for a custom user
to use X-Windows?  Is there some place I can look to determine what is
causing the error?

   Thank you,
   Larry

/var/log/messages:
 Jul 25 11:51:21 newhost gdm[4673]: SELinux gdm login: unable to obtain
default security context for appuser.


 /var/log/audit/audit.log:
type=USER_AUTH msg=audit(1248550033.507:1432): user pid=3003 uid=0
auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
authentication acct="?" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
terminal=:0 res=failed)'
type=USER_LOGIN msg=audit(1248550033.507:1433): user pid=3003 uid=0
auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='acct=dbapp:
exe="/usr/sbin/gdm-binary" (hostname=newhost, addr=127.0.0.1, terminal=:0
res=failed)'
type=USER_AUTH msg=audit(1248550043.787:1434): user pid=3003 uid=0
auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM:
authentication acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?,
addr=?, terminal=:0 res=success)'
type=USER_ACCT msg=audit(1248550043.789:1435): user pid=3003 uid=0
auid=14022 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM: accounting
acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?, terminal=:0
res=success)'
type=CRED_ACQ msg=audit(1248550043.790:1436): user pid=3003 uid=0 auid=14022
subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM: setcred acct="appuser"
: exe="/usr/sbin/gdm-binary" (hostname=?, addr=?, terminal=:0 res=success)'
type=LOGIN msg=audit(1248550043.796:1437): login pid=3003 uid=0 old
auid=14022 new auid=14020 old ses=35 new ses=36
type=USER_START msg=audit(1248550043.804:1438): user pid=3003 uid=0
auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM: session
open acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
terminal=:0 res=success)'
type=USER_LOGIN msg=audit(1248550043.804:1439): user pid=3003 uid=0
auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='uid=14020:
exe="/usr/sbin/gdm-binary" (hostname=newhost, addr=127.0.0.1, terminal=:0
res=success)'
type=USER_END msg=audit(1248550092.461:1440): user pid=3003 uid=0 auid=14020
subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM: session close
acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?, terminal=:0
res=success)'
type=CRED_DISP msg=audit(1248550092.461:1441): user pid=3003 uid=0
auid=14020 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='PAM: setcred
acct="appuser" : exe="/usr/sbin/gdm-binary" (hostname=?, addr=?, terminal=:0
res=success)'

--0016364267d91addf1046f8ce990
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I am trying to create a custom selinux user for the strict policy on R=
HEL5.3</div>
<div>I want=A0logins that are mapped to this user to be able to login via g=
dm, but when they do I get an error &quot;Error! Unable to set executable c=
ontext.&quot;</div>
<div>=A0</div>
<div>What does this error message mean?</div>
<div>=A0</div>
<div>I am able to login via gdm with logins that are mapped to user_u.=A0 I=
 have run the AVCs generated when I login in permissive mode (which succeed=
s) through audit2allow and gotten to the point where it doesn&#39;t seem th=
at I am getting any killer AVCs.=A0 What am I missing that is needed for a =
custom user to use X-Windows?=A0 Is there some place I can look to determin=
e what is causing the error?</div>

<div>=A0</div>
<div>=A0=A0 Thank you,</div>
<div>=A0=A0 Larry</div>
<div>=A0</div>
<div>/var/log/messages:</div>
<div>=A0Jul 25 11:51:21=A0newhost gdm[4673]: SELinux gdm login: unable to o=
btain default security context for appuser.</div>
<div><br>=A0</div>
<div>=A0/var/log/audit/audit.log:</div>
<div>type=3DUSER_AUTH msg=3Daudit(1248550033.507:1432): user pid=3D3003 uid=
=3D0 auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;=
PAM: authentication acct=3D&quot;?&quot; : exe=3D&quot;/usr/sbin/gdm-binary=
&quot; (hostname=3D?, addr=3D?, terminal=3D:0 res=3Dfailed)&#39;<br>
type=3DUSER_LOGIN msg=3Daudit(1248550033.507:1433): user pid=3D3003 uid=3D0=
 auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;acct=
=3Ddbapp: exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostname=3Dnewhost, addr=
=3D127.0.0.1, terminal=3D:0 res=3Dfailed)&#39;<br>
type=3DUSER_AUTH msg=3Daudit(1248550043.787:1434): user pid=3D3003 uid=3D0 =
auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM: =
authentication acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binar=
y&quot; (hostname=3D?, addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>
type=3DUSER_ACCT msg=3Daudit(1248550043.789:1435): user pid=3D3003 uid=3D0 =
auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM: =
accounting acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&qu=
ot; (hostname=3D?, addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>
type=3DCRED_ACQ msg=3Daudit(1248550043.790:1436): user pid=3D3003 uid=3D0 a=
uid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM: s=
etcred acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&quot; =
(hostname=3D?, addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>
type=3DLOGIN msg=3Daudit(1248550043.796:1437): login pid=3D3003 uid=3D0 old=
 auid=3D14022 new auid=3D14020 old ses=3D35 new ses=3D36<br>type=3DUSER_STA=
RT msg=3Daudit(1248550043.804:1438): user pid=3D3003 uid=3D0 auid=3D14020 s=
ubj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM: session open a=
cct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostnam=
e=3D?, addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>
type=3DUSER_LOGIN msg=3Daudit(1248550043.804:1439): user pid=3D3003 uid=3D0=
 auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;uid=
=3D14020: exe=3D&quot;/usr/sbin/gdm-binary&quot; (hostname=3Dnewhost, addr=
=3D127.0.0.1, terminal=3D:0 res=3Dsuccess)&#39;<br>
type=3DUSER_END msg=3Daudit(1248550092.461:1440): user pid=3D3003 uid=3D0 a=
uid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM: s=
ession close acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&=
quot; (hostname=3D?, addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>
type=3DCRED_DISP msg=3Daudit(1248550092.461:1441): user pid=3D3003 uid=3D0 =
auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D&#39;PAM: =
setcred acct=3D&quot;appuser&quot; : exe=3D&quot;/usr/sbin/gdm-binary&quot;=
 (hostname=3D?, addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>
</div>

--0016364267d91addf1046f8ce990--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
