Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFEV9Rb019873
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 09:31:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBFEV8pn022300
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 14:31:08 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id hBFEV7ab022297 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 14:31:08 GMT
Message-ID: <3FDDC599.2060108@redhat.com>
Date: Mon, 15 Dec 2003 09:30:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: Information
References: <3FDD9A28.9070406@ipen.br> <200312152313.59234.russell@coker.com.au>
In-Reply-To: <200312152313.59234.russell@coker.com.au>
Content-Type: multipart/alternative;
 boundary="------------050803080206020705080700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050803080206020705080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Russell Coker wrote:

>On Mon, 15 Dec 2003 22:25, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
>  
>
>>I have seen that the binary policy file (policy.15) have "15" as version
>>of the checkpolicy utility, right ?
>>The change done in the sysvinit package load the policy as:
>>/sbin/load_policy /etc/security/selinux/policy.15, right?
>>If yes, a change in the version of the checkpolicy, I have that change
>>the sysvinit too ?
>>    
>>
>
>The file /selinux/policyvers has the version.  A future version of sysvinit 
>will examine that file to determine which (of possibly many) policy databases 
>should be loaded.
>
>Maybe Dan's rpm has this already, I haven't checked.
>

Yes the current patch used security_policyvers from libselinux to 
determine the policy version.

Dan

>
>  
>

--------------050803080206020705080700
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Russell Coker wrote:<br>
<blockquote type="cite"
 cite="mid200312152313.59234.russell@coker.com.au">
  <pre wrap="">On Mon, 15 Dec 2003 22:25, Carlos An&iacute;sio Monteiro <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have seen that the binary policy file (policy.15) have "15" as version
of the checkpolicy utility, right ?
The change done in the sysvinit package load the policy as:
/sbin/load_policy /etc/security/selinux/policy.15, right?
If yes, a change in the version of the checkpolicy, I have that change
the sysvinit too ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The file /selinux/policyvers has the version.  A future version of sysvinit 
will examine that file to determine which (of possibly many) policy databases 
should be loaded.

Maybe Dan's rpm has this already, I haven't checked.</pre>
</blockquote>
<br>
Yes the current patch used security_policyvers from libselinux to
determine the policy version.<br>
<br>
Dan<br>
<blockquote type="cite"
 cite="mid200312152313.59234.russell@coker.com.au">
  <pre wrap="">

  </pre>
</blockquote>
</body>
</html>

--------------050803080206020705080700--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
