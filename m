Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9DBM6Wt013535
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 07:22:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9DBM5Ub021895
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 11:22:05 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id h9DBM3hX021892 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 11:22:04 GMT
Message-ID: <3F8A6068.5040209@ipen.br>
Date: Mon, 13 Oct 2003 06:20:56 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov,
   =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?=
 <monteiro@ipen.br>
Subject: login process
Content-Type: multipart/mixed;
 boundary="------------040505030809050209000404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040505030809050209000404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040505030809050209000404
Content-Type: message/rfc822;
 name="login process"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="login process"

X-Mozilla-Status2: 00000000
Return-Path: <owner-selinux@tycho.ncsc.mil>
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id h9ALYiLI032409
	for monteiro@ipen.br; Fri, 10 Oct 2003 18:34:44 -0300
Received: from tycho.ncsc.mil (tarius.tycho.ncsc.mil [144.51.3.1])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id h9ALYbWX031888
	for <monteiro@ipen.br>; Fri, 10 Oct 2003 18:34:38 -0300
Received: from tycho.ncsc.mil (localhost [127.0.0.1])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AKQbWt006730;
	Fri, 10 Oct 2003 16:26:37 -0400 (EDT)
Received: by tycho.ncsc.mil (8.12.8/8.12.8/Submit) id h9AKQbUY006729;
	Fri, 10 Oct 2003 16:26:37 -0400 (EDT)
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
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: login process
Content-Type: multipart/alternative;
 boundary="------------040803050403010803070403"
Sender: owner-selinux@tycho.nsa.gov
Precedence: bulk
X-Mailing-List: selinux-tycho.nsa.gov
X-Virus-Scanned: by AMaViS 0.3.12
X-Spam-Status: No, hits=3.4 required=5.0
	tests=AWL,HTML_10_20,HTML_MESSAGE,RCVD_IN_OSIRUSOFT_COM,
	      USER_AGENT_MOZILLA_UA,X_ACCEPT_LANG,X_MAILING_LIST,
	      X_OSIRU_OPEN_RELAY
	version=2.55
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)


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


--------------040505030809050209000404--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
