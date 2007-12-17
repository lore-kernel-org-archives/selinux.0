Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBHGRiRg006613
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 11:27:44 -0500
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBHGRhcR021764
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 16:27:43 GMT
Received: by el-out-1112.google.com with SMTP id j27so380628elf.0
        for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 08:27:43 -0800 (PST)
Message-ID: <dd18b0c30712170827t67aa7760m879573601e56ad9f@mail.gmail.com>
Date: Mon, 17 Dec 2007 08:27:42 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: load_policy
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12095_23815604.1197908862401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_12095_23815604.1197908862401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello I am new to selinux and seem to be at a road block. If anybody has any
info on  my situation it would be appreciative.
The problem I have is the policy isn't loading at boot time.  putting
load_policy in /etc/rc.local gives me a please choose a security context;
when choosing sysadm_r sysadm_t response is invalid security context. Then
looking into init I see this
ldd /sbin/init
     linux-gate.so.1 => (oxffffe000)
     libc.so.6 => /lib/libc.so.6 (0xb7e73000)         <----no
/lib/libselinux.so.1 (how to add libselinux to init?)
     /lib/ld-linux.so.2 (0xb7fca000)

could this be why selinux_init_load_policy doesnt work?
any info would be helpful.
regards;
             --Justin P. Mattock

------=_Part_12095_23815604.1197908862401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello I am new to selinux and seem to be at a road block. If anybody has any info on&nbsp; my situation it would be appreciative.<br>The problem I have is the policy isn&#39;t loading at boot time.&nbsp; putting load_policy in /etc/rc.local gives me a please choose a security context; when choosing sysadm_r sysadm_t response is invalid security context. Then looking into init I see this 
<br>ldd /sbin/init<br>&nbsp;&nbsp;&nbsp;&nbsp; linux-gate.so.1 =&gt; (oxffffe000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; libc.so.6 =&gt; /lib/libc.so.6 (0xb7e73000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;----no /lib/libselinux.so.1 (how to add libselinux to init?)<br>&nbsp;&nbsp;&nbsp;&nbsp; /lib/ld-
linux.so.2 (0xb7fca000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br>could this be why selinux_init_load_policy doesnt work?&nbsp; <br>any info would be helpful.<br>regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br><br><br><br><br><br><br><br><br>
<br><br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br>

------=_Part_12095_23815604.1197908862401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
