Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KKA5Wt022621
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 16:10:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KKA2mT027996
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:10:04 GMT
Message-ID: <3F944118.80809@redhat.com>
Date: Mon, 20 Oct 2003 16:10:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
References: <200310200148.15852.russell@coker.com.au> <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------090308000301080708000409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090308000301080708000409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Sun, 2003-10-19 at 11:48, Russell Coker wrote:
>  
>
>>I've attached a patch for /sbin/init to load the policy and set enforcing 
>>mode.  
>>    
>>
>
>Would it be cleaner to just do this via a script run from
>/etc/rc.d/rc.sysinit?  It seems a bit ugly to patch this directly into
>/sbin/init.  The script could perform a 'telinit u' after loading the
>policy to trigger the domain transition for the init process, and would
>simply return immediately upon the second invocation when it detected
>that selinuxfs was already mounted.
>
>  
>
I don-t believe that would not re-start the rc.sysinit process in the 
correct context.

>>3)  Mount /proc, if error then go to FINISH (*).
>>4)  Check /proc/filesystems for selinuxfs entry, if it's not there then we 
>>aren't running an SE Linux kernel so go to FINISH.  If it's there then we 
>>have a serious error condition so go to ERR (I forgot to close a file handle, 
>>not that it matters much - I'll fix it later).
>>    
>>
>
>This should be indicated by the return code / error message when you try
>to mount selinuxfs.
>
>  
>
>>6)  Set enforcing mode, if error then go to ERR.
>>    
>>
>
>This will always fail on a kernel that was built with
>CONFIG_SECURITY_SELINUX_DEVELOP=n, as /selinux/enforce will not define a
>write operation in that case.  Also, it would require booting with an
>alternate init program in order to boot permissive.  There doesn't seem
>to be any reason to do this, as you can specify enforcing=1 on the
>kernel command line or enable it via rc.sysinit if desired.
>
>  
>

--------------090308000301080708000409
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
 cite="mid1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Sun, 2003-10-19 at 11:48, Russell Coker wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I've attached a patch for /sbin/init to load the policy and set enforcing 
mode.  
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Would it be cleaner to just do this via a script run from
/etc/rc.d/rc.sysinit?  It seems a bit ugly to patch this directly into
/sbin/init.  The script could perform a 'telinit u' after loading the
policy to trigger the domain transition for the init process, and would
simply return immediately upon the second invocation when it detected
that selinuxfs was already mounted.

  </pre>
</blockquote>
I don-t believe that would not re-start the rc.sysinit process in the
correct context.<br>
<br>
<blockquote type="cite"
 cite="mid1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">3)  Mount /proc, if error then go to FINISH (*).
4)  Check /proc/filesystems for selinuxfs entry, if it's not there then we 
aren't running an SE Linux kernel so go to FINISH.  If it's there then we 
have a serious error condition so go to ERR (I forgot to close a file handle, 
not that it matters much - I'll fix it later).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This should be indicated by the return code / error message when you try
to mount selinuxfs.

  </pre>
  <blockquote type="cite">
    <pre wrap="">6)  Set enforcing mode, if error then go to ERR.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This will always fail on a kernel that was built with
CONFIG_SECURITY_SELINUX_DEVELOP=n, as /selinux/enforce will not define a
write operation in that case.  Also, it would require booting with an
alternate init program in order to boot permissive.  There doesn't seem
to be any reason to do this, as you can specify enforcing=1 on the
kernel command line or enable it via rc.sysinit if desired.

  </pre>
</blockquote>
</body>
</html>

--------------090308000301080708000409--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
