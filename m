Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m040eGkM021341
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 19:40:16 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m040eFPW002190
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2008 00:40:15 GMT
Received: by nz-out-0506.google.com with SMTP id i1so1377387nzh.39
        for <selinux@tycho.nsa.gov>; Thu, 03 Jan 2008 16:40:15 -0800 (PST)
Message-ID: <dd18b0c30801031640uef51a15yef23cb5a33133e04@mail.gmail.com>
Date: Thu, 3 Jan 2008 16:40:14 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: dhcpc_exec_t
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2599_14063584.1199407214962"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_2599_14063584.1199407214962
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello I seem to be a bit confused at what role I need to be in for
selinux-policy-default mls to run dhclient, or any executables; the context
is labeled
/sbin/dhclient3 system_u:object_r:dhcpc_exec_t:s0 . audit gives me an
unknown avc error, when I chcon system_u:object_r:dhcpc_t:s0 /sbin/dhclient3

audit will see the context. Where in compiling the policy gives me the
option for having sysadm_r run executables or do I need to newrole -r into
system_r to run dhclient? when also issueing newrole in mls I seem to keep
reciving this error as well =Couldn't get default type.
any info would be helpful.
regards;
                --Justin P. Mattock

------=_Part_2599_14063584.1199407214962
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello I seem to be a bit confused at what role I need to be in for selinux-policy-default mls to run dhclient, or any executables; the context is labeled <br>/sbin/dhclient3 system_u:object_r:dhcpc_exec_t:s0 . audit gives me an unknown avc error, when I chcon system_u:object_r:dhcpc_t:s0 /sbin/dhclient3 
<br>audit will see the context. Where in compiling the policy gives me the option for having sysadm_r run executables or do I need to newrole -r into <br>system_r to run dhclient? when also issueing newrole in mls I seem to keep reciving this error as well =Couldn&#39;t get default type. 
<br>any info would be helpful.<br>regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_2599_14063584.1199407214962--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
