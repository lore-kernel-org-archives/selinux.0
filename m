Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBMCw6Rb021499
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 07:58:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBMCvEjx021201
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 12:57:14 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id hBMCvDSR021198
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 12:57:13 GMT
Message-ID: <3FE6EA56.7010708@redhat.com>
Date: Mon, 22 Dec 2003 07:57:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joerg Hoh <joerg@devone.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
References: <20031219195045.4425635f.ynakam@ori.hitachi-sk.co.jp> <2407.202.27.185.71.1072043647.squirrel@www.crypt.gen.nz> <20031221224916.GA3419@hydra.joerghoh.de>
In-Reply-To: <20031221224916.GA3419@hydra.joerghoh.de>
Content-Type: multipart/alternative;
 boundary="------------020203050203010107030909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020203050203010107030909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joerg Hoh wrote:

>On Mon, Dec 22, 2003 at 10:54:07AM +1300, Kerry Thompson wrote:
>  
>
>>PAM ( and others ) make calls to the kerberos library which will always
>>open /etc/krb5.conf in r/w mode, even though no apps should be writing to
>>it. I suggest allowing read from all, and dontaudit for write.
>>    
>>
>
>But the longterm solution would be to check why kerberos wants to have write
>access to that file (and change it to read-only, if it isn't necessary at
>all).
>
>Joerg
>

Kerberos has a sort of getstatusinfo call that it uses for all its 
configuration files.  It basically loads up a information structure that 
allows it to make decistions on a file.  Included in this information is 
whether the file is writable.  So the Kerberos library does an 
access(filename,W_OK) on the file it is investigating.  I believe all of 
kerberos should have a security policy written on it, since some of the 
config files are as important as /etc/passwd, shadow.  If I can somehow 
get the system to trust a different kerberos server then I can gain 
access to the machine and wreak havoc.

Dan

>
>  
>

--------------020203050203010107030909
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Joerg Hoh wrote:<br>
<blockquote type="cite"
 cite="mid20031221224916.GA3419@hydra.joerghoh.de">
  <pre wrap="">On Mon, Dec 22, 2003 at 10:54:07AM +1300, Kerry Thompson wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">PAM ( and others ) make calls to the kerberos library which will always
open /etc/krb5.conf in r/w mode, even though no apps should be writing to
it. I suggest allowing read from all, and dontaudit for write.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
But the longterm solution would be to check why kerberos wants to have write
access to that file (and change it to read-only, if it isn't necessary at
all).

Joerg</pre>
</blockquote>
<br>
Kerberos has a sort of getstatusinfo call that it uses for all its
configuration files.&nbsp; It basically loads up a information structure
that allows it to make decistions on a file.&nbsp; Included in this
information is whether the file is writable.&nbsp; So the Kerberos library
does an access(filename,W_OK) on the file it is investigating.&nbsp; I
believe all of kerberos should have a security policy written on it,
since some of the config files are as important as /etc/passwd,
shadow.&nbsp; If I can somehow get the system to trust a different kerberos
server then I can gain access to the machine and wreak havoc.<br>
<br>
Dan<br>
<blockquote type="cite"
 cite="mid20031221224916.GA3419@hydra.joerghoh.de">
  <pre wrap="">

  </pre>
</blockquote>
</body>
</html>

--------------020203050203010107030909--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
