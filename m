Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q27FFNn7001068
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2012 10:15:23 -0500
Date: Wed, 7 Mar 2012 23:15:16 +0800 (CST)
From: Yao <yffbrave@163.com>
To: SELinux@tycho.nsa.gov
Message-ID: <14357406.17003.135edba7f47.Coremail.yffbrave@163.com>
Subject: A few questions
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_255394_94725199.1331133316935"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_255394_94725199.1331133316935
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

Hi,
Lately I'm studying SELinux and got some questions  which I want to be clear.


(1)I know SELinux is based on Flask architecture and I know where the SS is, but I'm not sure
where the OM locates, I guess the variable "security_ops" which belongs to LSM represents the OM, am I right?


(2)the struct "selinux_ops" in file hooks.c is declared as "static", why not add "const" qualifier so that 
the it will be put in read-only data section in the kernel?


(3)Is there any way to hack the SELinux, I mean, to disable it on the fly? For example, replace the policy db with a 
blank file so that any permission is allowed. Is it feasible?


Regards,
Yao
------=_Part_255394_94725199.1331133316935
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial">Hi,<div>Lately I'm studying SELinux and got some questions &nbsp;which I want to be clear.</div><div><br></div><div>(1)I know SELinux is based on Flask architecture and I know where the SS is, but I'm not sure</div><div>where the OM locates, I guess the variable "security_ops" which belongs to LSM represents the OM, am I right?</div><div><br></div><div>(2)the struct "selinux_ops" in file hooks.c is declared as "static", why not add "const" qualifier so that&nbsp;</div><div>the it will be put in read-only data section in the kernel?</div><div><br></div><div>(3)Is there any way to hack the SELinux, I mean, to disable it on the fly? For example, replace the policy db with a&nbsp;</div><div>blank file so that any permission is allowed. Is it feasible?</div><div><br></div><div>Regards,</div><div>Yao</div></div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_255394_94725199.1331133316935--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
