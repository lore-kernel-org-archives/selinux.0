Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBR8tQXe000843
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 03:55:26 -0500
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBR8tQZd003846
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 08:55:26 GMT
Received: by rv-out-0708.google.com with SMTP id f25so5393682rvb.54
        for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 00:55:25 -0800 (PST)
Message-ID: <707f057d0812270055r153efe73nd5649d3bc0c4fe0c@mail.gmail.com>
Date: Sat, 27 Dec 2008 16:55:25 +0800
From: "xing li" <lixing.1006@gmail.com>
To: selinux@tycho.nsa.gov
Subject: when and how the selinux label all file system according to "file_contexts"?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_112953_8709557.1230368125724"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_112953_8709557.1230368125724
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have confused by the question:
when and how the selinux label all file system according to "file_contexts"?
and i found the clue that when we "touch /.autorelabel",the system would
invoke
"fixfiles relabel" to relabel the file system. but i could't find the
relevant source code.
Maybt somebody has investigated that and could share infomation?

------=_Part_112953_8709557.1230368125724
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&nbsp;have confused by the question:<br>when and how the selinux label all file system according to &quot;file_contexts&quot;?<br>and i found the clue that when we &quot;touch /.autorelabel&quot;,the system would invoke <br>&quot;fixfiles relabel&quot; to relabel the file system. but i could&#39;t find the relevant source code.<br>
Maybt somebody has investigated that and could share infomation?

------=_Part_112953_8709557.1230368125724--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
