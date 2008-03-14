Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2EFGXgO026251
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2008 11:16:33 -0400
Received: from rn-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2EFGWsT009552
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2008 15:16:32 GMT
Received: by rn-out-0910.google.com with SMTP id e24so2881708rng.8
        for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2008 08:16:31 -0700 (PDT)
Message-ID: <dd18b0c30803140816n68edaf2fg82f3b551f728b28@mail.gmail.com>
Date: Fri, 14 Mar 2008 15:16:30 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: 2.6.25-rc5
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1022_18885612.1205507790977"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_1022_18885612.1205507790977
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi;

Thanks for the response.  I think the policy and the kernel is running
smoothly, of course there's quirks here and there, in the meantime,
I've been side tracked from power consumption, to capability.h. In doing so
Its been interesting reading that file. I've been  trying to compile a
driver(fglrx) thats been complaining about KCLPosixSecurityCap, cap_t. With
reading capability.h cap_t is being moved to libcap, so having cap_t put in
libcap, and having fglrx read libcap, for cap_t
 seems to be interesting. with capability2 will it reside in the same file
as capability.h, or somewhere else.
Overall I think capability's are a very good idea.

-- 
Justin P. Mattock

------=_Part_1022_18885612.1205507790977
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi; <br><br>Thanks for the response.&nbsp; I think the policy and the kernel is running smoothly, of course there&#39;s quirks here and there, in the meantime,<br>I&#39;ve been side tracked from power consumption, to capability.h. In doing so Its been interesting reading that file. I&#39;ve been&nbsp; trying to compile a driver(fglrx) thats been complaining about KCLPosixSecurityCap, cap_t. With reading capability.h cap_t is being moved to libcap, so having cap_t put in libcap, and having fglrx read libcap, for cap_t<br>
&nbsp;seems to be interesting. with capability2 will it reside in the same file as capability.h, or somewhere else.<br>Overall I think capability&#39;s are a very good idea.<br clear="all"><br>-- <br>Justin P. Mattock

------=_Part_1022_18885612.1205507790977--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
