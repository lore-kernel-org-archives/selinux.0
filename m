Message-ID: <20040216175312.84847.qmail@web15205.mail.bjs.yahoo.com>
Date: Tue, 17 Feb 2004 01:53:12 +0800 (CST)
From: =?gb2312?q?Park=20Lee?= <parklee_2004@yahoo.com.cn>
Subject: Re: Something seems to be self-contradictory
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1113186611-1076953992=:81720"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1113186611-1076953992=:81720
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Dear sir,
Thank you for taking time to reply.
 
You say that:
>A domain is a special type.
>When you define types they can have attributes, one >attribute is "domain" which indicates that it's possible to >use that type for labelling processes.

 
Do you mean that program is assigned a domain?
Then what is the difference between a program and a common file?
There are some examples:
 
# sshd_exec_t is the type of the sshd executable.
# sshd_key_t is the type of the ssh private key files
type sshd_exec_t, file_type, exec_type, sysadmfile;
type sshd_key_t, file_type, sysadmfile;
(in selinux-usr\policy\domains\program\ssh.te)
 
In my opinion, the sshd executable is a program ,and the ssh private key files are common files. But, Why Doesn't the type of sshd executable have a domain attribute with it? 
 
Thanks 
 
Yours,
Park Lee
2004-02-17 





---------------------------------
Do You Yahoo!?
完全免费的雅虎电邮，马上注册获赠额外60兆网络存储空间
--0-1113186611-1076953992=:81720
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>
<DIV>Dear sir,</DIV>
<DIV>Thank you for taking time to reply.</DIV>
<DIV>&nbsp;</DIV>
<DIV>You say that:</DIV>
<DIV>&gt;A domain is a special type.<BR>&gt;When you define types they can have attributes, one &gt;attribute is "domain" which indicates that it's possible to &gt;use that type for labelling processes.<BR></DIV>
<DIV>&nbsp;</DIV>
<DIV>Do you mean that program is assigned a domain?</DIV>
<DIV>Then what is the difference between a program and a common file?</DIV>
<DIV>There are&nbsp;some examples:</DIV>
<DIV>&nbsp;</DIV>
<DIV># sshd_exec_t is the type of the sshd executable.<BR># sshd_key_t is the type of the ssh private key files<BR>type sshd_exec_t, file_type, exec_type, sysadmfile;<BR>type sshd_key_t, file_type, sysadmfile;<BR>(in selinux-usr\policy\domains\program\ssh.te)</DIV>
<DIV>&nbsp;</DIV>
<DIV>In my opinion, the sshd executable is a program ,and the ssh private key files are common files. But, Why Doesn't the type of sshd executable&nbsp;have a domain attribute with it?&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks </DIV>
<DIV>&nbsp;</DIV>
<DIV>Yours,</DIV>
<DIV>Park Lee</DIV>
<DIV>2004-02-17&nbsp;</DIV></DIV></DIV><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/?http://cn.mail.yahoo.com" target=blank>完全免费的雅虎电邮，马上注册获赠额外60兆网络存储空间</a>
--0-1113186611-1076953992=:81720--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
