Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78EFK6l009375
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 10:15:20 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78EFJ5c015708
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 14:15:19 GMT
Received: by yx-out-1718.google.com with SMTP id 3so264589yxi.84
        for <selinux@tycho.nsa.gov>; Fri, 08 Aug 2008 07:15:04 -0700 (PDT)
Message-ID: <d74d42a50808080715k5cc752acy3bad72465baaa5c0@mail.gmail.com>
Date: Fri, 8 Aug 2008 19:45:02 +0530
From: "shaunak saha" <reach.shaunak@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Gconf application
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_69028_8544483.1218204903694"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_69028_8544483.1218204903694
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I m new to selinux.I am not sure I am posing this question correctly, so
please view it
from the perspective of where I am trying to get to.

I need to protect Gconf applications.I have two client applications running
in different domains.From the policy file one applcation should be allowed
to do operations in GConf while other should only be able to read from
Gconf.
For this i m planning to follow the NSA whitepaper i found from net(
http://www.nsa.gov/seLinux/papers/gconf07-abs.cfm) and creating a userspace
object manager.Is that the correct approach or there is any other way to
make selinux checks for gconf applications?
FYI:I m using gconf-dbus,not the orbit gconf.

Thanks in advance,


Thanks and Regards,
Shaunak

------=_Part_69028_8544483.1218204903694
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>Hi all,</div>
<div>&nbsp;</div>
<div>I m new to selinux.I am not sure I am posing this question correctly, so please view it<br>from the perspective of where I am trying to get to.</div>
<div>&nbsp;</div>
<div>I need to protect Gconf applications.I have two client applications running in different domains.From the policy file one applcation should be allowed to do operations in GConf while other should only be able to read from Gconf.</div>

<div>For this i m planning to follow the NSA whitepaper i found from net(<a href="http://www.nsa.gov/seLinux/papers/gconf07-abs.cfm">http://www.nsa.gov/seLinux/papers/gconf07-abs.cfm</a>) and creating a userspace<br>object manager.Is that the correct approach or there is any other way to make selinux checks for gconf applications?<br>
</div>
<div>FYI:I m using gconf-dbus,not the orbit gconf.</div>
<div>&nbsp;</div>
<div>Thanks in advance,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks and Regards,</div>
<div>Shaunak</div>
<div>&nbsp;</div></div>

------=_Part_69028_8544483.1218204903694--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
