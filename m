Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u12HmmCr015956
 for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2016 12:48:48 -0500
Received: by mail-wm0-f53.google.com with SMTP id p63so129575894wmp.1
 for <selinux@tycho.nsa.gov>; Tue, 02 Feb 2016 09:48:42 -0800 (PST)
MIME-Version: 1.0
From: Mark Steele <mark@control-alt-del.org>
Date: Tue, 2 Feb 2016 12:48:01 -0500
Message-ID: <CAB5=j_qPtHM-D0X6qZf151es_erjfBWYMohLx+PF6toFaKaJgg@mail.gmail.com>
Subject: SELinux file context matching
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013d1456a186ae052acd1c1b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e013d1456a186ae052acd1c1b
Content-Type: text/plain; charset=UTF-8

Hi list,

I've got some file contexts setup for an application, and can't get the
file context matching to work as I would expect.

[root@dev1 policy]# cat /etc/selinux/targeted/contexts/files/file_contexts
| grep cinched
/etc/cinched(/.*)?      system_u:object_r:ts_etc_t:s0
/var/log/cinched(/.*)?  system_u:object_r:ts_log_t:s0
/var/lib/cinched(/.*)?  system_u:object_r:ts_t:s0
*/usr/lib64/cinched(/.*)?        system_u:object_r:ts_lib_t:s0*
/etc/bash_completion.d/cinched_bash_completions
system_u:object_r:ts_etc_t:s0
/var/log/cinched/audit(/.*)?    system_u:object_r:ts_audit_log_t:s0
/usr/sbin/cinched       system_u:object_r:ts_exec_t:s0

[root@dev1 policy]# matchpathcon /usr/lib64/cinched/
*/usr/lib64/cinched      system_u:object_r:lib_t:s0*

[root@dev1 policy]# findcon
/etc/selinux/targeted/contexts/files/file_contexts -p /usr/lib64/cinched
/.*             system_u:object_r:default_t:s0
/usr/.*         system_u:object_r:usr_t:s0
*/usr/lib64/cinched(/.*)?                system_u:object_r:ts_lib_t:s0*


This is running on CentOS 7. I was assuming that since my rule has the
longest stem, it would be applied.

Any suggestions?

--089e013d1456a186ae052acd1c1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi list,<div><br></div><div>I&#39;ve got some file context=
s setup for an application, and can&#39;t get the file context matching to =
work as I would expect.</div><div><br></div><div><div>[root@dev1 policy]# c=
at /etc/selinux/targeted/contexts/files/file_contexts | grep cinched</div><=
div>/etc/cinched(/.*)? =C2=A0 =C2=A0 =C2=A0system_u:object_r:ts_etc_t:s0</d=
iv><div>/var/log/cinched(/.*)? =C2=A0system_u:object_r:ts_log_t:s0</div><di=
v>/var/lib/cinched(/.*)? =C2=A0system_u:object_r:ts_t:s0</div><div><b>/usr/=
lib64/cinched(/.*)? =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:ts_lib_t:s=
0</b></div><div>/etc/bash_completion.d/cinched_bash_completions system_u:ob=
ject_r:ts_etc_t:s0</div><div>/var/log/cinched/audit(/.*)? =C2=A0 =C2=A0syst=
em_u:object_r:ts_audit_log_t:s0</div><div>/usr/sbin/cinched =C2=A0 =C2=A0 =
=C2=A0 system_u:object_r:ts_exec_t:s0</div><div><br></div><div>[root@dev1 p=
olicy]# matchpathcon /usr/lib64/cinched/</div><div><b>/usr/lib64/cinched =
=C2=A0 =C2=A0 =C2=A0system_u:object_r:lib_t:s0</b></div><div><br></div></di=
v><div><div>[root@dev1 policy]# findcon /etc/selinux/targeted/contexts/file=
s/file_contexts -p /usr/lib64/cinched</div><div>/.* =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 system_u:object_r:default_t:s0</div><div>/usr/.* =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 system_u:object_r:usr_t:s0</div><div><b>/usr/lib64=
/cinched(/.*)? =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
m_u:object_r:ts_lib_t:s0</b></div></div><div><br></div><div><br></div><div>=
This is running on CentOS 7. I was assuming that since my rule has the long=
est stem, it would be applied.<br></div><div><br></div><div>Any suggestions=
?<br clear=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-size:small"><br></div><di=
v style=3D"font-size:small"></div></div></div></div></div></div>
</div></div>

--089e013d1456a186ae052acd1c1b--
