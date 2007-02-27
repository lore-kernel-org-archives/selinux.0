Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1R6Yt3A005822
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 01:34:55 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1R6aGIU007157
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 06:36:17 GMT
Received: by nf-out-0910.google.com with SMTP id n15so73973nfc
        for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 22:36:14 -0800 (PST)
Message-ID: <9d1b82480702262236r6cab8167qcf73a68f0fcd7c1@mail.gmail.com>
Date: Tue, 27 Feb 2007 12:06:13 +0530
From: Pravin <shindepravin@gmail.com>
To: selinux@tycho.nsa.gov
Subject: CKRM and SELinux
In-Reply-To: <9d1b82480702262223o37921e5cubc8506efaa225e2d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_513_17308306.1172558173328"
References: <9d1b82480702262223o37921e5cubc8506efaa225e2d@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_513_17308306.1172558173328
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I was working on possibility resource management using SELinux, but I feel
that using SELinux hooks only, it won't be possible to do resource
management effectively.

After studying CKRM from resource management point of view, possibility of
integrating SELinux framework with CKRM came over.
We can use SELinux contexts and domains to be used as classes in CKRM.
Enforcing the division of resources will be done by CKRM only.
In this way, we can reuse the context's of SELinux in CKRM.

There was a mail dating back to 2005 regarding this possibility
http://www.nsa.gov/selinux/list-archive/0506/12047.cfm
But it seems the idea was not followed afterwards.

May I know if such integration of SELinux and CKRM is feasible or not, and
how useful will it be?
Please let me know your views and comments on this possibility.

Thank you.
-- 
Pravin Shinde

------=_Part_513_17308306.1172558173328
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I was working on possibility resource management using SELinux, but I feel that using SELinux hooks only, it won&#39;t be possible to do resource management effectively. <br><br>After studying CKRM from resource management point of view, possibility of integrating SELinux framework with CKRM came over.
<br>We can use SELinux contexts and domains to be used as classes in CKRM. Enforcing the division of resources will be done by CKRM only.<br>In this way, we can reuse the context&#39;s of SELinux in CKRM.<br><br>There was a mail dating back to 2005 regarding this possibility
<br><a href="http://www.nsa.gov/selinux/list-archive/0506/12047.cfm" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.nsa.gov/selinux/list-archive/0506/12047.cfm
</a><br>But it seems the idea was not followed afterwards.<br><br>May I know if such integration of SELinux and CKRM is feasible or not, and how useful will it be?<br>Please let me know your views and comments on this possibility.
<br><br>Thank you.<br><span class="sg">-- <br>   Pravin Shinde<br>
</span><br>

------=_Part_513_17308306.1172558173328--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
