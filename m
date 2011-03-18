Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2I0hL27010520
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2011 20:43:21 -0400
Received: from m13-11.163.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2I0hItT029556
	for <selinux@tycho.nsa.gov>; Fri, 18 Mar 2011 00:43:19 GMT
Date: Fri, 18 Mar 2011 08:43:16 +0800 (CST)
From: Yao <yffbrave@163.com>
To: SELinux@tycho.nsa.gov
Message-ID: <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
Subject: about ss
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_196605_2041220262.1300408996792"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_196605_2041220262.1300408996792
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

Hi, all
I looked at linux-2.6.36/security/selinux/ss/*.c and found most source files include <linux/***.h>
I know security server need to use some of kernel data structures.
But does ss use kernel fuctions?
Is it possible to modify security server and make it self-contained if ss used kernel function?


Regards,
Yao



------=_Part_196605_2041220262.1300408996792
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

Hi, all<div>I looked at linux-2.6.36/security/selinux/ss/*.c and found most source files include &lt;linux/***.h&gt;</div><div>I know security server need to use some of kernel data structures.</div><div>But does ss use kernel fuctions?</div><div>Is it possible to modify security server and make it self-contained if ss used kernel function?</div><div><br></div><div>Regards,</div><div>Yao</div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_196605_2041220262.1300408996792--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
