Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AKQWWt006724
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 16:26:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9AKQS0p023779
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 20:26:28 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
	by jazzswing.ncsc.mil  with ESMTP id h9AKQRr7023770
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 20:26:27 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id h9AKQdSp013130
	for selinux@tycho.nsa.gov; Fri, 10 Oct 2003 17:26:39 -0300
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id h9AKQIWX012039
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 17:26:19 -0300
Message-ID: <3F8716E3.4020005@ipen.br>
Date: Fri, 10 Oct 2003 17:30:27 -0300
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: login process
Content-Type: multipart/alternative;
 boundary="------------040803050403010803070403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------040803050403010803070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

1) Always that login at system, it request the role and the type. (it is 
not very clearly, excuse).

The message is the one that follows:

boot process ...

login:   root
password: *******
*Login: unable to obtain context for root
Would you like to enter a security context? [y] *

I answer y.

Enter role   *sysadm_r*
Enter type   *sysadm_t*

messages AVC: denied. *The login process is OK*.

I have always that  to provide this role and type?
I think that login process not is recognize the files of context 
(/etc/security/default_type or /etc/security/default_context).

Thanks.

--------------040803050403010803070403
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Hi. <br>
<br>
1) Always that login at system, it request the role and the type. (it is
not very clearly, excuse).<br>
<br>
The message is the one that follows:<br>
<br>
boot process ... <br>
<br>
login:&nbsp;&nbsp; root <br>
password: ******* <br>
<b>Login: unable to obtain context for root <br>
Would you like to enter a security context? [y] </b><br>
<br>
I answer y.<br>
<br>
Enter role &nbsp; <b>sysadm_r</b><br>
Enter type &nbsp; <b>sysadm_t</b><br>
<br>
messages AVC: denied. <b>The login process is OK</b>.<br>
<br>
I have always that &nbsp;to provide this role and type? <br>
I think that login process not is recognize the files of context (/etc/security/default_type
or /etc/security/default_context).<br>
<br>
Thanks.<br>
 
</body>
</html>

--------------040803050403010803070403--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
