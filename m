Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RJqKWt027801
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 14:52:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9RJqJIE027965
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 19:52:19 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h9RJqI1J027962 for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 19:52:19 GMT
Message-ID: <3F9D7770.90403@redhat.com>
Date: Mon, 27 Oct 2003 14:52:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: question about pam_selinux multiple option
References: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>	 <3F9D33EC.8060705@redhat.com> <1067282582.1077.16.camel@chris.pebenito.net>
In-Reply-To: <1067282582.1077.16.camel@chris.pebenito.net>
Content-Type: multipart/alternative;
 boundary="------------050607070201010802030000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050607070201010802030000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chris PeBenito wrote:

>On Mon, 2003-10-27 at 09:04, Daniel J Walsh wrote:
>  
>
>>The multiple option was added to allow the user to select the security 
>>context they would be allowed to login in as.  We have decided to pull 
>>this functionality from login programs and only allow the user to login 
>>with the default context.
>>    
>>
>
>I'm curious what prompted this change?  Prompting the user for the
>context they want to login with, for local logins, has been there for as
>long as I've used SELinux (though thats only since March).  That is, in
>the older /bin/login patches.
>  
>

The problem was that different login programs worked differently.  Login 
had this ability, sshd did not.  Some versions of [xg]dm had it but 
others didn't and it was very complicated code withing these login 
programs.  We just decided to simplify it and not expose this to the Users.

Dan

--------------050607070201010802030000
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Chris PeBenito wrote:<br>
<blockquote type="cite"
 cite="mid1067282582.1077.16.camel@chris.pebenito.net">
  <pre wrap="">On Mon, 2003-10-27 at 09:04, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">The multiple option was added to allow the user to select the security 
context they would be allowed to login in as.  We have decided to pull 
this functionality from login programs and only allow the user to login 
with the default context.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm curious what prompted this change?  Prompting the user for the
context they want to login with, for local logins, has been there for as
long as I've used SELinux (though thats only since March).  That is, in
the older /bin/login patches.
  </pre>
</blockquote>
<br>
The problem was that different login programs worked differently.&nbsp;
Login had this ability, sshd did not.&nbsp; Some versions of [xg]dm had it
but others didn't and it was very complicated code withing these login
programs.&nbsp; We just decided to simplify it and not expose this to the
Users.<br>
<br>
Dan<br>
</body>
</html>

--------------050607070201010802030000--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
