Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28HGWRb007111
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 12:16:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i28HEp6Q002089
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:14:51 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
	by jazzswing.ncsc.mil  with ESMTP id i28HEj5t002049
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:14:51 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id i28HIUNF013267
	for selinux@tycho.nsa.gov; Mon, 8 Mar 2004 14:18:30 -0300
Received: from net.ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id i28HIBiX013113
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 14:18:12 -0300
Message-ID: <404CAA11.2070909@net.ipen.br>
Date: Mon, 08 Mar 2004 14:14:57 -0300
From: =?UTF-8?B?Q2FybG9zIEFuw61zaW8gTW9udGVpcm8=?= <monteiro@baitaca.ipen.br>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: system_r and sysadm_r roles
References: <404C5B57.9020209@net.ipen.br> <1078757447.30181.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------070208050105080800030907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------070208050105080800030907
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Stephen Smalley wrote:

>>This would can induce the a problem of security ?
>>    
>>
>
>No, domain transitions are the key.
>
Sorry, but don´t understand this. If a fail (that it provide a shell 
root) to occur in a system process, can´t occur a transition to sysadm_r 
role ?

Many thanks.

-- 
Carlos Anísio Monteiro	<monteiro@ipen.br>
IPEN-CNEN/SP
São Paulo - Brasil



--------------070208050105080800030907
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1078757447.30181.82.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">This would can induce the a problem of security ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No, domain transitions are the key.</pre>
</blockquote>
Sorry, but don´t understand this. If a fail (that it provide a shell root)
to occur in a system process, can´t occur a transition to sysadm_r role ?<br>
<br>
Many thanks.<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Carlos Anísio Monteiro	<a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a>
IPEN-CNEN/SP
São Paulo - Brasil</pre>
<br>
</body>
</html>

--------------070208050105080800030907--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
