Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4EDJoPD012027
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 09:19:50 -0400
Received: from m14-19.126.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n4EDJqk4009230
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 13:19:53 GMT
Date: Thu, 14 May 2009 21:19:31 +0800 (CST)
From: hechao55429 <hechao55429@126.com>
To: selinux@tycho.nsa.gov
Message-ID: <27009633.1151091242307171349.JavaMail.coremail@bj126app104.126.com>
Subject: the problem about  install refpolicy
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_306239_16388515.1242307171348"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_306239_16388515.1242307171348
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit



hello everyone :
  In the  fedora 10,the selinux policy is  targeted .But I want to switch it to refpolicy,so I install the refpolicy  policy ,according to the approach as follows:

1.# tar -jxvf refpolicy-20071214.tar.bz2 -C /tmp
# cd /tmp/refpolicy
# make install-src
2. 

Edit the policy build.conf file (/etc/selinux/refpolicy/src/policy/build.conf). Near the top of the file, the policy has a few build options. The DISTRO option needs to be uncommented and set to redhat, and DIRECT_INITRC should be set to y. 

3.# make install
4. Modify the /etc/selinux/config file, and set SELINUXTYPE to refpolicy. 

5.# touch /.autorelabel
# shutdown -r now
The approach comes from http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy

But when I restart the computer,the problem comes forth as follows :

  Reading all physical volunmes,this may take a while...

Found volume group "VolGroup00" using Metadata type lvm2

2 logical volume(s) in volune group "VolGroup00" now active

init: rcS main process(515) terminated with status 1

init: rcS post-stop process(518) terminated with status 1

it stopped in here and can't restart. can anybody tell me why?



------=_Part_306239_16388515.1242307171348
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV><BR>
<DIV>hello everyone :</DIV>
<DIV>&nbsp;&nbsp;In the &nbsp;fedora 10,the selinux policy is &nbsp;targete=
d .But I want to switch it to refpolicy,so I install the refpolicy&nbsp; po=
licy ,according to the approach as follows:<BR><BR>1.# tar -jxvf refpolicy-=
20071214.tar.bz2 -C /tmp<BR># cd /tmp/refpolicy<BR># make install-src<BR>2.=
=20
<P>Edit the policy build.conf file (/etc/selinux/refpolicy/src/policy/build=
conf). Near the top of the file, the policy has a few build options. The D=
ISTRO option needs to be uncommented and set to redhat, and DIRECT_INITRC s=
hould be set to y. </P>
<P>3.# make install<BR>4. Modify the /etc/selinux/config file, and set SELI=
NUXTYPE to refpolicy. </P>
<P>5.# touch /.autorelabel<BR># shutdown -r now<BR>The approach comes from =
<A href=3D"http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy" targ=
et=3D"_blank">http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy</A=
></P>
<P>But when I restart the computer,the problem comes forth as follows&nbsp;=
:</P>
<P>&nbsp; Reading all physical volunmes,this may take a while...</P>
<P>Found volume group "VolGroup00" using Metadata type lvm2</P>
<P>2 logical volume(s) in volune group "VolGroup00" now active</P>
<P>init: rcS main process(515) terminated with status 1</P>
<P>init: rcS post-stop process(518) terminated with status 1</P>
<P>it&nbsp;stopped in&nbsp;here&nbsp;and can't restart.&nbsp;can anybody&nb=
sp;tell me why?</P><BR></DIV></DIV><br><!-- footer --><br><span title=3D"ne=
teasefooter"/><hr/>
<a href=3D"http://512.mail.163.com/mailstamp/stamp/dz/activity.do?from=3Dfo=
oter">=B4=A9=D4=BD=B5=D8=D5=F0=B4=F8 =BC=CD=C4=EE=E3=EB=B4=A8=B5=D8=D5=F0=
=D2=BB=D6=DC=C4=EA</a>
</span>
------=_Part_306239_16388515.1242307171348--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
