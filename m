Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1Jt8Rb009724
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:55:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1JsSp7003894
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:54:29 GMT
Message-ID: <3FCB8050.7060300@ipen.br>
Date: Mon, 01 Dec 2003 15:54:24 -0200
From: =?UTF-8?B?Q2FybG9zIEFuw61zaW8gTW9udGVpcm8=?= <monteiro@ipen.br>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Installation of packages
References: <3FC5E6EA.30409@ipen.br> <1070287593.12270.44.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------090207030900040904050606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------090207030900040904050606
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>If you are working from our last public release on nsa.gov, then the
>most important ones are:
>- util-linux (patched login program to set the user security context)
>- openssh (patched sshd to set the user security context)
>- vixie-cron (patched crond to set the user security context)
>
>If you are working from Dan's packages
>(ftp://people.redhat.com/dwalsh/SELinux), then the most important ones
>are:
>- SysVinit (patched init program to perform the initial policy load,
>obsoletes the need to modify your initrd)
>- pam (pam_selinux module and other SELinux modifications to pam)
>- util-linux (login pam configuration modified to use pam_selinux)
>- openssh (patched sshd)
>- vixie-cron (patched crond)
>
>The patched coreutils and procps are certainly useful, but they aren't
>essential to basic system operation.
>
>  
>
And over Debian/testing and Debian/unstable packages ?

Thanks.

-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil



--------------090207030900040904050606
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1070287593.12270.44.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap=""></pre>
  <pre wrap=""><!---->If you are working from our last public release on nsa.gov, then the
most important ones are:
- util-linux (patched login program to set the user security context)
- openssh (patched sshd to set the user security context)
- vixie-cron (patched crond to set the user security context)

If you are working from Dan's packages
(<a class="moz-txt-link-freetext" href="ftp://people.redhat.com/dwalsh/SELinux">ftp://people.redhat.com/dwalsh/SELinux</a>), then the most important ones
are:
- SysVinit (patched init program to perform the initial policy load,
obsoletes the need to modify your initrd)
- pam (pam_selinux module and other SELinux modifications to pam)
- util-linux (login pam configuration modified to use pam_selinux)
- openssh (patched sshd)
- vixie-cron (patched crond)

The patched coreutils and procps are certainly useful, but they aren't
essential to basic system operation.

  </pre>
</blockquote>
And over Debian/testing and Debian/unstable packages ?<br>
<br>
Thanks.<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Carlos Anisio Monteiro  <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a>
IPEN/CNEN-SP
Sao Paulo - Brasil
</pre>
<br>
</body>
</html>

--------------090207030900040904050606--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
