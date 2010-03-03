Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o236bQPN020615
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 01:37:26 -0500
Received: from bay0-omc1-s28.bay0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o236bmPe014446
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 06:37:48 GMT
Message-ID: <BAY111-W68D4C9E39582E71A1BA31AB3A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c0543d12-a5cb-4ecb-83d3-4fd6f5b6611a_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: refpolicy-mailing-list <refpolicy@oss1.tresys.com>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>
Subject: How to implement the "if-then-else" logic in refpolicy interface?
Date: Wed, 3 Mar 2010 06:37:24 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_c0543d12-a5cb-4ecb-83d3-4fd6f5b6611a_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi SELinux experts,

Thanks a lot for taking a look at my question, how could I implement the bash "if-then-else" and "test" grammar in current refpolicy interface? For example, if I don't want the user_t to have the privilege to execute any kind of shell, what proper grammar should I use to implement something with the same logic as 'if ! test "X$1" = "Xuser_t"' in the corecomd_exec_shell interface:

interface(`corecmd_exec_shell',`
        gen_require(`
                type bin_t, shell_exec_t;
        ')

if ! test "X$1" = "Xuser_t"; then
        list_dirs_pattern($1, bin_t, bin_t)
        read_lnk_files_pattern($1, bin_t, bin_t)
        can_exec($1, shell_exec_t)
fi
')

Thank you very much!

Best regards,
Harry
 		 	   		  
_________________________________________________________________
想知道明天天气如何？必应告诉你！
http://cn.bing.com/search?q=%E5%A4%A9%E6%B0%94%E9%A2%84%E6%8A%A5&form=MICHJ2
--_c0543d12-a5cb-4ecb-83d3-4fd6f5b6611a_
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
Hi SELinux experts,<br><br>Thanks a lot for taking a look at my question, how could I implement the bash "if-then-else" and "test" grammar in current refpolicy interface? For example, if I don't want the user_t to have the privilege to execute any kind of shell, what proper grammar should I use to implement something with the same logic as 'if ! test "X$1" = "Xuser_t"' in the corecomd_exec_shell interface:<br><br>interface(`corecmd_exec_shell',`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gen_require(`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type bin_t, shell_exec_t;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ')<br><br>if ! test "X$1" = "Xuser_t"; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_dirs_pattern($1, bin_t, bin_t)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_lnk_files_pattern($1, bin_t, bin_t)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_exec($1, shell_exec_t)<br>fi<br>')<br><br>Thank yo!
 u very much!<br><br>Best regards,<br>Harry<br> 		 	   		  <br /><hr />搜索本应是彩色的,快来体验新一代搜索引擎-必应,精美图片每天换哦! <a href='http://cn.bing.com/?form=CRMADS ' target='_new'>立即试用！</a></body>
</html>
--_c0543d12-a5cb-4ecb-83d3-4fd6f5b6611a_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
