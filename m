Message-Id: <200509021632.j82GWrss022126@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "SELinux List" <SELinux@tycho.nsa.gov>
Subject: 
Date: Fri, 2 Sep 2005 12:32:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Under what conditions is quotaon checked for files? After some looking I
found that you can mount a file on another file using bind mount - which I
was not previously aware of - which would trigger the mounton check. It is
not clear to me, though, when quotaon would be checked and whether it is
related to the bind mount of a file on another file.

Thanks,

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
