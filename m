Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAPLmoRb016547
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 16:48:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAPLmFp5003496
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 21:48:15 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
	by jazzswing.ncsc.mil  with ESMTP id hAPLmEt0003475
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 21:48:15 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id hAPLnHk2008230
	for selinux@tycho.nsa.gov; Tue, 25 Nov 2003 19:49:17 -0200
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id hAPLnBeE007855
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 19:49:11 -0200
Message-ID: <3FC3CE10.8020307@ipen.br>
Date: Tue, 25 Nov 2003 19:48:00 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: genfs_contexts file
Content-Type: multipart/alternative;
 boundary="------------000802040100090609040706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------000802040100090609040706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I have a doubt about *genfs_contexts* file. For example, the statement 
below:
          
*genfscon vfat /                system_u:object_r:dosfs_t*

I mounted the windows filesystem with: *mount -t vfat /dev/hda1 /mnt/win*
I access with: *cd /mnt/win* and run *ls --context*
The print out of the *ls --context* is:
*-rwxr--r--  root     root     (null)                           130700.htm
drwxr--r--  root     root     (null)                           aaa
-r-xr--r--  root     root     (null)                           admin.dll
-rwxr--r--  root     root     (null)                           ajapaedi
*
Is correct the (null) for security context?

If I note the line in the genfs_contexts file happen the same thing. The 
are not change.

Thanks.

-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil


--------------000802040100090609040706
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Hi.<br>
<br>
I have a doubt about <b>genfs_contexts</b> file. For example, the statement
below:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <br>
<b>genfscon vfat /&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; system_u:object_r:dosfs_t</b><br>
<br>
I mounted the windows filesystem with: <b>mount -t vfat /dev/hda1 /mnt/win</b><br>
I access with: <b>cd /mnt/win</b> and run <b>ls --context</b><br>
The print out of the <b>ls --context</b> is:<br>
<b>-rwxr--r--&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; (null)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 130700.htm<br>
drwxr--r--&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; (null)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aaa<br>
-r-xr--r--&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; (null)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; admin.dll<br>
-rwxr--r--&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; (null)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ajapaedi<br>
</b><br>
Is correct the (null) for security context?<br>
<br>
If I note the line in the genfs_contexts file happen the same thing. The
are not change.<br>
<br>
Thanks.<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Carlos Anisio Monteiro  <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a>
IPEN/CNEN-SP
Sao Paulo - Brasil
</pre>
</body>
</html>

--------------000802040100090609040706--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
