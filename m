Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n615F2o2002966
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 01:15:02 -0400
Received: from mail-px0-f197.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n615Ei1Y000325
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 05:14:45 GMT
Received: by pxi35 with SMTP id 35so535665pxi.32
        for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 22:15:00 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Jul 2009 11:15:00 +0600
Message-ID: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
Subject: RBAC with SELinux MCS
From: Shaz <shazalive@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0016364c673f4976b8046d9e017a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364c673f4976b8046d9e017a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear list,

I was studying some earlier work on RBAC and came across Kuhn98 [1], which
says that RBAC can be implemented if some interface function is used to map
privilege sets of RBAC with MCS. James Moris blog article on MCS [2] states
that MCS is just dicretionary like DAC if hierarchies like of MLS levels are
not used. It might be because of the implementation of current LSPP on Linux
distros. So my question is that can RBAC be used with SELinux if the mapping
function is provided?

Some further literature or existing work being pointed out will be
appreciated.

Thank you.

[1]
http://csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf
[2] http://james-morris.livejournal.com/5583.html

-- 
Shaz

--0016364c673f4976b8046d9e017a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear list,<br><br>I was studying some earlier work on RBAC and came across =
Kuhn98 [1], which says that RBAC can be implemented if some interface funct=
ion is used to map privilege sets of RBAC with MCS. James Moris blog articl=
e on MCS [2] states that MCS is just dicretionary like DAC if hierarchies l=
ike of MLS levels are not used. It might be because of the implementation o=
f current LSPP on Linux distros. So my question is that can RBAC be used wi=
th SELinux if the mapping function is provided?<br>
<br>Some further literature or existing work being pointed out will be appr=
eciated.<br><br>Thank you.<br clear=3D"all"><br>[1] <a href=3D"http://csrc.=
nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf">http:=
//csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf=
</a><br>
[2] <a href=3D"http://james-morris.livejournal.com/5583.html">http://james-=
morris.livejournal.com/5583.html</a><br><br>-- <br>Shaz<br><br>

--0016364c673f4976b8046d9e017a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
