Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4GEsSj6019389
	for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 10:54:29 -0400
Received: from m15-52.126.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n4GEsNnA004252
	for <selinux@tycho.nsa.gov>; Sat, 16 May 2009 14:54:24 GMT
Date: Sat, 16 May 2009 22:54:10 +0800 (CST)
From: hechao55429 <hechao55429@126.com>
To: selinux <selinux@tycho.nsa.gov>
Message-ID: <17697801.901261242485650930.JavaMail.coremail@bj126app52.126.com>
Subject: write selinux policy
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_239305_32157965.1242485650929"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_239305_32157965.1242485650929
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

hello everyone:
   I'm now studying selinux policy on fedora 10  .  I wrote a policy module like this:
        myapp.if
## <summary>this si to constraint gedit</summary>
        myapp.te
policy_module(myapp,1.0.0) 
type myapp_t;
# Access to shared libraries
libs_use_ld_so(myapp_t)
libs_use_shared_libs(myapp_t)
miscfiles_read_localization(myapp_t)
type myapp_exec_t;
type myapp_rw_t;
files_type(myapp_exec_t)
files_type(myapp_rw_t)
init_domain(myapp_t,myapp_exec_t)  
allow myapp_t myapp_rw_t :file ~{write};
  myapp.fc
/usr/bin/gedit -- gen_context(system_u:object_r:myapp_exec_t,s0)  
/root/share/a/as -- gen_context(system_u:object_r:myapp_rw_t,s0)
Then i compiled it and it created myapp.pp with no error.
And then i used the command that semodule -i myapp.pp and it succeeded.
 Then i relabeled the files by using the restorecon command and reboot .
But after it reboot ,the  /usr/bin/gedit  still  ran on the unconfined_t domain. 
why?

------=_Part_239305_32157965.1242485650929
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>hello everyone:</DIV>
<DIV>&nbsp;&nbsp; I'm now studying selinux policy on fedora 10&nbsp; .&nbsp=
; I wrote a policy module like this:</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; myapp.if</DIV>
<DIV>## &lt;summary&gt;this si to constraint gedit&lt;/summary&gt;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; myapp.te<BR>policy_module(m=
yapp,1.0.0) </DIV>
<DIV>type myapp_t;<BR># Access to shared libraries<BR>libs_use_ld_so(myapp_=
t)<BR>libs_use_shared_libs(myapp_t)</DIV>
<DIV>miscfiles_read_localization(myapp_t)<BR>type myapp_exec_t;<BR>type mya=
pp_rw_t;<BR>files_type(myapp_exec_t)<BR>files_type(myapp_rw_t)<BR>init_doma=
in(myapp_t,myapp_exec_t)&nbsp;&nbsp;<BR>allow myapp_t myapp_rw_t :file ~{wr=
ite};</DIV>
<DIV>&nbsp; myapp.fc</DIV>
<DIV>/usr/bin/gedit&nbsp;--&nbsp;gen_context(system_u:object_r:myapp_exec_t=
,s0)&nbsp;&nbsp;<BR>/root/share/a/as -- gen_context(system_u:object_r:myapp=
_rw_t,s0)</DIV>
<DIV>Then i compiled it and it created myapp.pp with no error.</DIV>
<DIV>And then i used the command that semodule -i myapp.pp and it succeeded=
</DIV>
<DIV>&nbsp;Then&nbsp;i relabeled the files&nbsp;by using the restorecon com=
mand and reboot&nbsp;.</DIV>
<DIV>But after it reboot ,the&nbsp; /usr/bin/gedit&nbsp;&nbsp;still&nbsp; r=
an on the unconfined_t domain. </DIV>
<DIV>why?<BR></DIV><br><!-- footer --><br><span title=3D"neteasefooter"/><h=
r/>
<a href=3D"http://512.mail.163.com/mailstamp/stamp/dz/activity.do?from=3Dfo=
oter">=B4=A9=D4=BD=B5=D8=D5=F0=B4=F8 =BC=CD=C4=EE=E3=EB=B4=A8=B5=D8=D5=F0=
=D2=BB=D6=DC=C4=EA</a>
</span>
------=_Part_239305_32157965.1242485650929--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
