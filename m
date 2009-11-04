Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA4Nvg6g018143
	for <selinux@tycho.nsa.gov>; Wed, 4 Nov 2009 18:57:42 -0500
Received: from mail-vw0-f184.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nA4NxcqO028367
	for <selinux@tycho.nsa.gov>; Wed, 4 Nov 2009 23:59:38 GMT
Received: by vws14 with SMTP id 14so1861250vws.32
        for <selinux@tycho.nsa.gov>; Wed, 04 Nov 2009 15:57:42 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 4 Nov 2009 15:57:41 -0800
Message-ID: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
Subject: "security_compute_sid: invalid context" error when starting/stopping
	mysqld daemon
From: Larry Ross <selinux.larry@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e68f9c21574582047794601b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e68f9c21574582047794601b
Content-Type: text/plain; charset=ISO-8859-1

I have two selinux users that need to be able to stop and start the mysql
daemon, which is started by the initialization scripts.  When the daemon is
stopped and started by the secadm_u user, it ends up in the context
secadm_u:secadm_r:mysqld_t.  When it is stopped and started by the dbadm_u
user, it ends up in the dbadm_u:dbadm_r:mysqld_t context.  When it is
started by the init scripts it ends up in the system_u:system_r:mysqld_t
domain.

I would like it to alway end up in the system_r:mysqld_t domain, but can't
seem to find any documentation that describes how to get that to work.

If I add a role_transition rule to transition the role to system_r when the
executable is run:
role_transition sysadm_r mysqld_safe_exec_t system_r;
role_transition dbadm_r  mysqld_safe_exec_t system_r;
I end up getting these errors:

Nov  4 15:41:36 localhost kernel: type=1401 audit(1257378096.775:46):
security_compute_sid:  invalid context dbadm_u:system_r:mysqld_safe_t:s0 for
scontext=dbadm_u:dbadm_r:initrc_t:s0
tcontext=system_u:object_r:mysqld_safe_exec_t:s0 tclass=process

I believe I have the rules that should allow this, but obviously I am
missing something.
role dbadm_r types mysqld_safe_t;
role sysadm_r types mysqld_safe_t;
role system_r types mysqld_safe_t;
and this:
allow initrc_t mysqld_safe_t : process transition ;
which is what the "security_compute_sid" message looks like it is missing.

Does anyone know where I can find a good description of how to get a service
to transistion back into system_r when started by a user or have any idea
what I am missing?

  Thank you,
  Larry

--0016e68f9c21574582047794601b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I have two selinux users that need to be able to stop and start the my=
sql daemon, which is started by the initialization scripts.=A0 When the dae=
mon is stopped and started by the secadm_u user, it ends up in the context =
secadm_u:secadm_r:mysqld_t.=A0 When it is stopped and started by the dbadm_=
u user, it ends up in=A0the dbadm_u:dbadm_r:mysqld_t context.=A0 When it is=
 started by the init scripts it ends up in the system_u:system_r:mysqld_t d=
omain.</div>

<div>=A0</div>
<div>I would like it to alway end up in the system_r:mysqld_t domain, but c=
an&#39;t seem to find any documentation that describes how to get that to w=
ork.</div>
<div>=A0</div>
<div>If I add a role_transition rule to transition the role to system_r whe=
n the executable is run:</div>
<div>role_transition sysadm_r mysqld_safe_exec_t system_r;<br>role_transiti=
on dbadm_r=A0 mysqld_safe_exec_t system_r;<br></div>
<div>I end up getting these errors:</div>
<div>=A0</div>
<div>Nov=A0 4 15:41:36 localhost kernel: type=3D1401 audit(1257378096.775:4=
6): security_compute_sid:=A0 invalid context dbadm_u:system_r:mysqld_safe_t=
:s0 for scontext=3Ddbadm_u:dbadm_r:initrc_t:s0 tcontext=3Dsystem_u:object_r=
:mysqld_safe_exec_t:s0 tclass=3Dprocess<br>
</div>
<div>=A0</div>
<div>I believe I have the rules that should allow this, but obviously I am =
missing something.</div>
<div>role dbadm_r types mysqld_safe_t;<br>role sysadm_r types mysqld_safe_t=
;<br>role system_r types mysqld_safe_t;<br></div>
<div>and this:</div>
<div>allow initrc_t mysqld_safe_t : process transition ;</div>
<div>which is what the &quot;security_compute_sid&quot; message looks like =
it is missing.</div>
<div>=A0</div>
<div>Does anyone know where I can find a good description of how to get a s=
ervice to transistion back into system_r when started by a user or have any=
 idea what I am missing?</div>
<div>=A0</div>
<div>=A0 Thank you,</div>
<div>=A0=A0Larry</div>
<div>=A0</div>

--0016e68f9c21574582047794601b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
