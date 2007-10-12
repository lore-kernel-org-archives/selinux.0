Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9C068JV023421
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2007 20:06:08 -0400
Received: from mail.cse.psu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9C061mb005878
	for <selinux@tycho.nsa.gov>; Fri, 12 Oct 2007 00:06:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.cse.psu.edu (CSE Mail Server) with ESMTP id ECBF0E626
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2007 20:05:02 -0400 (EDT)
Received: from mail.cse.psu.edu ([127.0.0.1])
 by localhost (psuvax1 [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 21056-01-84 for <selinux@tycho.nsa.gov>;
 Thu, 11 Oct 2007 20:04:59 -0400 (EDT)
Received: from [130.203.65.61] (bacata.cse.psu.edu [130.203.65.61])
	by mail.cse.psu.edu (CSE Mail Server) with ESMTP id E62C9E65F
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2007 20:04:59 -0400 (EDT)
Mime-Version: 1.0 (Apple Message framework v752.3)
To: SELinux <selinux@tycho.nsa.gov>
Message-Id: <6CC980AA-A0E9-41E5-AC2F-6CC1C1802A6A@cse.psu.edu>
Content-Type: multipart/alternative; boundary=Apple-Mail-6--908069129
From: Sandra Rueda <ruedarod@cse.psu.edu>
Subject: About the Policy Server
Date: Thu, 11 Oct 2007 20:04:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-6--908069129
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hello,

I am trying to install the policy server. I followed the instructions  
at http://oss.tresys.com/projects/policy-server/wiki/PolicyServerHowTo

I had a couple of problems when I tried to install with yum because  
apparently the targeted policy depends on permissions that were not  
defined in my initial policy, the error message indicated that  
"Module apcupsd depends on permission dccp_recv in class node). Thus,  
afterwards I downloaded the refpolicy from Tresys website (selinux- 
policy-2.4.6-99.src.rpm), I built my new targeted policy and it  
looked ok. So I started pms and I loaded this new policy.

But now I have another problem:
I am building the test module that is showed as an example in the  
PolicyServerHowTo page. Initially I got the following error:

libsepol.print_missing_requirements: allow_test's global requirements  
were not met: type/attribute policy_t
libsemanage.semanage_link_sandbox: Link packages failed
Commit failed

So, I created a file with the missing type, but then I got another  
error:
libsepol.print_missing_requirements: allow_test's global requirements  
were not met: common l
libsemanage.semanage_link_sandbox: Link packages failed
Commit failed

It looks like my system is missing some file ..
Any comment about these errors is much appreciated,
Thanks,
Sandra




--Apple-Mail-6--908069129
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV>Hello,</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I am trying to install the =
policy server.=A0I followed the instructions at=A0<A =
href=3D"http://oss.tresys.com/projects/policy-server/wiki/PolicyServerHowT=
o">http://oss.tresys.com/projects/policy-server/wiki/PolicyServerHowTo</A>=
</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>I had a =
couple of problems when I tried to install with yum because apparently =
the targeted policy depends on permissions that were not defined in my =
initial policy, the error message indicated that "Module apcupsd depends =
on permission dccp_recv in class node). Thus, afterwards I downloaded =
the refpolicy from Tresys website (selinux-policy-2.4.6-99.src.rpm), I =
built my new targeted policy and it looked ok. So I started pms and I =
loaded this new policy.=A0=A0</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>But now I have another =
problem:=A0</DIV><DIV>I am building the test module that is showed as an =
example in the PolicyServerHowTo page.=A0Initially I got the following =
error:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>libsepol.print_missing_requir=
ements: allow_test's global requirements were not met: type/attribute =
policy_t</DIV><DIV>libsemanage.semanage_link_sandbox: Link packages =
failed</DIV><DIV>Commit failed</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>So, I created a file with =
the missing type, but then I got another =
error:</DIV><DIV>libsepol.print_missing_requirements:=A0allow_test's =
global requirements were not met: common =
l=A0</DIV><DIV>libsemanage.semanage_link_sandbox: Link packages =
failed</DIV><DIV>Commit failed</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>It looks like my system is =
missing some file ..=A0</DIV><DIV>Any comment about these errors is much =
appreciated,</DIV><DIV>Thanks,=A0</DIV><DIV>Sandra</DIV><BR><DIV> <SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN> =
</DIV><BR></BODY></HTML>=

--Apple-Mail-6--908069129--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
