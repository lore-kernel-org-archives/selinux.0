Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEGvHSf025745
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 11:57:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAEGunBb029155
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 16:56:49 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id hAEGun4o029152
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 16:56:49 GMT
Message-ID: <3FB50965.4030207@redhat.com>
Date: Fri, 14 Nov 2003 11:57:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: unix_chkpwd
References: <Xine.LNX.4.44.0311140823320.21499-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0311140823320.21499-100000@thoron.boston.redhat.com>
Content-Type: multipart/alternative;
 boundary="------------070001060600010807040501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070001060600010807040501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Morris wrote:

>On Fri, 14 Nov 2003, Russell Coker wrote:
>
>  
>
>>We can do one of three things:
>>1)  dontaudit system_chkpwd_t inetd_t:fd use;
>>2)  Change sshd to use fcntl() before doing any PAM stuff.
>>3)  Put code in pam_unix.so to close all file handles after the fork().
>>
>>Which do you think is best?  2 seems most correct to me, but may be most 
>>difficult to get accepted upstream.
>>    
>>
>
>Yes, 2 seems correct to me as well, what objections would they have 
>upstream?
>
>
>- James
>  
>

I still think the safest thing is to manual close all sockets, since 
this prevents the case where someone has opened a socket accidently 
since you don't know where pam is going to be used.  The time it takes 
to run 0-max open file descriptors is tiny.

Dan

--------------070001060600010807040501
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
James Morris wrote:<br>
<blockquote type="cite"
 cite="midXine.LNX.4.44.0311140823320.21499-100000@thoron.boston.redhat.com">
  <pre wrap="">On Fri, 14 Nov 2003, Russell Coker wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">We can do one of three things:
1)  dontaudit system_chkpwd_t inetd_t:fd use;
2)  Change sshd to use fcntl() before doing any PAM stuff.
3)  Put code in pam_unix.so to close all file handles after the fork().

Which do you think is best?  2 seems most correct to me, but may be most 
difficult to get accepted upstream.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, 2 seems correct to me as well, what objections would they have 
upstream?


- James
  </pre>
</blockquote>
<br>
I still think the safest thing is to manual close all sockets, since
this prevents the case where someone has opened a socket accidently
since you don't know where pam is going to be used.&nbsp; The time it takes
to run 0-max open file descriptors is tiny.<br>
<br>
Dan<br>
</body>
</html>

--------------070001060600010807040501--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
