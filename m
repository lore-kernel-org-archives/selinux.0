Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SHPpRb006401
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 12:25:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0SHPo1I028341
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 17:25:50 GMT
Received: from web15206.mail.bjs.yahoo.com (web15206.mail.cnb.yahoo.com [202.43.216.136])
        by jazzband.ncsc.mil  with SMTP id i0SHPmbs028338 for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 17:25:49 GMT
Message-ID: <20040128172544.52050.qmail@web15206.mail.bjs.yahoo.com>
Date: Thu, 29 Jan 2004 01:25:44 +0800 (CST)
From: =?gb2312?q?Park=20Lee?= <parklee_2004@yahoo.com.cn>
Subject: Thanks for Re: Must SELinux have a initrd image and...
To: sds@epoch.ncsc.mil
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-963249173-1075310744=:49080"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-963249173-1075310744=:49080
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Dear Sir,
 Thank you very much!
 As a beginner of Linux and SELinux,Perhaps some of my questions is ridiculous.But I'm really very interested in SELinux,and want to study it very much.
 
you say
>I'd use 2.6.2-rc2 from kernel.org.  Or the Fedora Core >development kernel

then,would you tell me where could I get the kernel.org and how to get 2.6.2-rc2. what is the meaning of Fedora Core development kernel? Isn't it Fedora Core 1 or Fedora Core 2 ?
 
>>  and Must SELinux have a two boot-up 
>>  phase using a initrd RAM disk?
>Not anymore.  The modified init program will load the >policy from the disk and then re-exec itself.

Does this means that When I configured the kernel,I can ignore the following options in the Block Devices :
  < > RAM disk support
  [ ] Initial RAM disk (initrd) support
and let them be ?
And on the other hand,If I choose the above options,will they do harm to SELinux?
>If you can't build a patched prelink, then you should >disable prelink on your system

 Do you mean that if I disable prelink on my system,I can use SELinux without 
any negative influence?
 
Thanks,
      Yours,
      Park Lee
      2004-01-28



---------------------------------
Do You Yahoo!?
繁华世界里，让我看清你
--0-963249173-1075310744=:49080
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Dear Sir,<BR>&nbsp;Thank you very much!<BR>&nbsp;As a beginner of Linux and SELinux,Perhaps some of my questions is ridiculous.But I'm really very interested in SELinux,and want to study it very much.</DIV>
<DIV>&nbsp;</DIV>
<DIV>you say<BR>&gt;I'd use 2.6.2-rc2 from kernel.org.&nbsp; Or the Fedora Core &gt;development kernel<BR></DIV>
<DIV>then,would you tell me where could I get the kernel.org and how to get 2.6.2-rc2. what is the meaning of Fedora Core development kernel? Isn't it Fedora Core 1 or Fedora Core 2 ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;&gt;&nbsp; and Must SELinux have a two boot-up <BR>&gt;&gt;&nbsp; phase using a initrd RAM disk?<BR>&gt;Not anymore.&nbsp; The modified init program will load the &gt;policy from the disk and then re-exec itself.<BR></DIV>
<DIV>Does this means that When I configured the kernel,I can ignore the following options in the Block Devices :<BR>&nbsp; &lt; &gt; RAM disk support<BR>&nbsp; [ ] Initial RAM disk (initrd) support<BR>and let them be ?<BR>And on the other hand,If I choose the above options,will they do harm to SELinux?</DIV>
<DIV>&gt;If you can't build a patched prelink, then you should &gt;disable prelink on your system<BR></DIV>
<DIV>&nbsp;Do you mean that if I disable prelink on my system,I can use SELinux without </DIV>
<DIV>any negative influence?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yours,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Park Lee<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2004-01-28</DIV><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/?http://cn.surveys.yahoo.com/cn_user_profile_study_dec2003" target=blank>繁华世界里，让我看清你</a>
--0-963249173-1075310744=:49080--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
