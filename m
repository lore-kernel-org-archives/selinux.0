Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LIdiWt029075
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:39:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LIdUIU019660
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:39:32 GMT
Message-ID: <3F957D6A.7060807@redhat.com>
Date: Tue, 21 Oct 2003 14:39:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chcon
References: <200310212327.05821.russell@coker.com.au> <1066743378.27065.81.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066743378.27065.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------030400080509050204080002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030400080509050204080002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2003-10-21 at 09:27, Russell Coker wrote:
>  
>
>>Steve, chcon needs access to /selinux/context, is there any problem in putting 
>>in a macro such as the following and using it for all user domains?
>>
>>define(`can_check_context', `
>>allow $1 security_t:dir search;
>>allow $1 security_t:file { read write };
>>allow $1 security_t:security { check_context };
>>')
>>    
>>
>
>This is a recent change to chcon in Dan's SRPM; doesn't exist in the
>coreutil-selinux patch from the last release. It isn't truly necessary,
>as the context will be checked when it is passed to the kernel via
>setfilecon and that call will fail if the context is invalid, so it is
>only useful if there is some benefit to catching such errors earlier.
>
>Even if it is worth retaining in chcon, I would suggest distinguishing
>between an errno of ENOENT and an errno of EINVAL, as the former may
>just indicate that selinuxfs wasn't mounted or the kernel was a
>non-SELinux kernel (but could still have the xattr handlers), and
>letting the chcon proceed in the former case.  Otherwise, you won't be
>able to use chcon if selinuxfs is unmounted or using a non-SELinux
>kernel that has the xattr handlers.  I should likely make the same
>change to setfiles.
>
>  
>
I have put out a new patch that does not do this anymore.  It has a 
simpler error mechanism.

Dan

--------------030400080509050204080002
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
 cite="mid1066743378.27065.81.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Tue, 2003-10-21 at 09:27, Russell Coker wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Steve, chcon needs access to /selinux/context, is there any problem in putting 
in a macro such as the following and using it for all user domains?

define(`can_check_context', `
allow $1 security_t:dir search;
allow $1 security_t:file { read write };
allow $1 security_t:security { check_context };
')
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is a recent change to chcon in Dan's SRPM; doesn't exist in the
coreutil-selinux patch from the last release. It isn't truly necessary,
as the context will be checked when it is passed to the kernel via
setfilecon and that call will fail if the context is invalid, so it is
only useful if there is some benefit to catching such errors earlier.

Even if it is worth retaining in chcon, I would suggest distinguishing
between an errno of ENOENT and an errno of EINVAL, as the former may
just indicate that selinuxfs wasn't mounted or the kernel was a
non-SELinux kernel (but could still have the xattr handlers), and
letting the chcon proceed in the former case.  Otherwise, you won't be
able to use chcon if selinuxfs is unmounted or using a non-SELinux
kernel that has the xattr handlers.  I should likely make the same
change to setfiles.

  </pre>
</blockquote>
I have put out a new patch that does not do this anymore.&nbsp; It has a
simpler error mechanism.<br>
<br>
Dan<br>
</body>
</html>

--------------030400080509050204080002--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
