Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4P61OA6001469
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 02:01:24 -0400
Received: from snt0-omc3-s34.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4P60dFk012433
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 06:00:39 GMT
Message-ID: <SNT139-w43C25DEB5952D5BB6F5452ABE80@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_94110355-4e9e-4a59-b8d4-c7ca48fc7166_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: How the native device nodes of /dev/* get relabeled?
Date: Tue, 25 May 2010 06:01:22 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_94110355-4e9e-4a59-b8d4-c7ca48fc7166_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi SELinux experts,

Thanks for reading my question. I know the whole file system could be relabeled if we touch /.autorelabel, then during system boots up rc.sysinit will go on to call relabel_selinux() function to fix the label for the whole file system, however, this happens after rc.sysinit has called start_udev, which will mount tmpfs onto /dev/ and take the responsibility to restorecon it properly. So how do we make sure those native device nodes under /dev/* such as /dev/console and /dev/null being properly labeled? They would be accessed by the hostname or mount program before rc.sysinit calls start_udev(when the tmpfs has not been mounted and labeled on /dev/).

Thanks and best regards,
Harry
 		 	   		  
_________________________________________________________________
一张照片的自白——Windows Live照片的可爱视频介绍
http://windowslivesky.spaces.live.com/blog/cns!5892B6048E2498BD!889.entry
--_94110355-4e9e-4a59-b8d4-c7ca48fc7166_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
Hi SELinux experts,<br><br>Thanks for reading my question. I know the whole file system could be relabeled if we touch /.autorelabel, then during system boots up rc.sysinit will go on to call relabel_selinux() function to fix the label for the whole file system, however, this happens after rc.sysinit has called start_udev, which will mount tmpfs onto /dev/ and take the responsibility to restorecon it properly. So how do we make sure those native device nodes under /dev/* such as /dev/console and /dev/null being properly labeled? They would be accessed by the hostname or mount program before rc.sysinit calls start_udev(when the tmpfs has not been mounted and labeled on /dev/).<br><br>Thanks and best regards,<br>Harry<br> 		 	   		  <br /><hr />使用Messenger保护盾2.0，支持多账号登录！ <a href='http://www.windowslive.cn/safe/' target='_new'>现在就下载！</a></body>
</html>
--_94110355-4e9e-4a59-b8d4-c7ca48fc7166_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
