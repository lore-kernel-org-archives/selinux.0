Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KKuNWt022965
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 16:56:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KKuA0r006825
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:56:11 GMT
Message-ID: <3F944BF1.50606@redhat.com>
Date: Mon, 20 Oct 2003 16:56:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
References: <200310200148.15852.russell@coker.com.au>	 <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>	 <3F944118.80809@redhat.com> <1066682781.22196.398.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066682781.22196.398.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------000902010903020308030009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000902010903020308030009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Mon, 2003-10-20 at 16:10, Daniel J Walsh wrote:
>  
>
>>I don-t believe that would not re-start the rc.sysinit process in the
>>correct context.
>>    
>>
>
>What if we were to replace the sysinit entry in /etc/inittab with one
>that ran a new script that mounts selinuxfs, loads the policy, and runs
>'telinit u' to restart init in the correct domain, and add a bootwait
>entry to /etc/inittab that runs the ordinary rc.sysinit script?  In that
>case, init should run the new script that loads the policy, re-exec
>itself into the right domain due to the telinit -u command, and then
>proceed to run the rc.sysinit script.  Or this might even work with two
>sysinit entries, as long as they are executed in the right order.
>
>  
>

I don't believe there is anyway to get init to re-run the initscripts 
which means that no scripts will get started from the 'correct ' init,  
unless you change run-level. 

Dan

--------------000902010903020308030009
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1066682781.22196.398.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Mon, 2003-10-20 at 16:10, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I don-t believe that would not re-start the rc.sysinit process in the
correct context.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
What if we were to replace the sysinit entry in /etc/inittab with one
that ran a new script that mounts selinuxfs, loads the policy, and runs
'telinit u' to restart init in the correct domain, and add a bootwait
entry to /etc/inittab that runs the ordinary rc.sysinit script?  In that
case, init should run the new script that loads the policy, re-exec
itself into the right domain due to the telinit -u command, and then
proceed to run the rc.sysinit script.  Or this might even work with two
sysinit entries, as long as they are executed in the right order.

  </pre>
</blockquote>
<br>
I don't believe there is anyway to get init to re-run the initscripts
which means that no scripts will get started from the 'correct ' init,&nbsp;
unless you change run-level.&nbsp; <br>
<br>
Dan<br>
</body>
</html>

--------------000902010903020308030009--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
