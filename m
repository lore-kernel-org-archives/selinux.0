Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UJ76I4006377
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 15:07:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UJ757R000197
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 19:07:05 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h3UJ74KP000193 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 19:07:04 GMT
Message-ID: <3EB01EC8.7070602@redhat.com>
Date: Wed, 30 Apr 2003 15:06:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: SUDO package
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>	 <3EA5A040.40107@redhat.com>	 <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>	 <3EAFEECA.1090107@redhat.com> <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------010702050508010309050708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------010702050508010309050708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Wed, 2003-04-30 at 11:42, Daniel J Walsh wrote:
>  
>
>>I have a hard time with the previous two.  Just seems to me SELinux
>>needs some sort
>>of dontallow functionality to handle these situation.  Otherwise every
>>time I add a policy 
>>that has a somewhat global effect on files/dir, I need to change the
>>all the file/directory attributes 
>>in the policy.  Has this been discussed previously?
>>    
>>
>
>True.  The problem is more severe for exec_type than for the directory
>access; IMHO, it isn't too much to ask you to enumerate the major
>directory types in which binaries to be executed by sudo might live, and
>most (all?) of those types should be part of the basic policy
>definition, not package-specific, e.g. bin_t, sbin_t, etc.  You don't
>even need to define an attribute for that purpose; you can just list
>them in your allow rule, or pull them from a macro definition added to
>the global macros.
>  
>
I am still not sure I can do this.  Are you are stating that I would 
have to have an allow rule for
each *exec_t?  Just searching domains/programs I found  > 100 of these 
in the default policy.  
Maybe we are at odds with what sudo can do.  I consider sudo to be a 
shortcut from doing
su,newrole,COMMAND.  So sudo needs all the rights that su/newrole has 
for a particular role.  
Now you might be against this because of the security ramifications, 
which is ok.  But if users
are going to use a SELinux system they are going to expect this behaviour.

>  
>
>>This is a problem since with Sudo you are sharing the same terminal
>>between the process that rand sudo
>>and the sudo process.  So if you change the privs of the terminal one
>>process or the other could have 
>>more privs.  I would prefer to leave the terminal with the current
>>privs (Usually lower) and make the 
>>application run by sudo change the terminal privs if it has to. 
>>(probably seldom).  Any other ideas?
>>    
>>
>
>I'm not clear as to why you can't implement something akin to what
>newrole does.  Otherwise, what prevents another process of lower
>privilege from arbitrarily accessing the privileged process' terminal?
>You can't rely on the DAC protections.
>
>  
>
Ok I just went back and read the code again and it looks like I can 
implement the terminal stuff.
There is a -b option on the sudo command that allows sudo to run in 
background.  Or using job
control you could run the command in background.

sudo -r sysadm_r /usr/bin/PROGRAM &

So what happens to control over the terminal in this situation?

Dan


--------------010702050508010309050708
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">On Wed, 2003-04-30 at 11:42, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have a hard time with the previous two.  Just seems to me SELinux
needs some sort
of dontallow functionality to handle these situation.  Otherwise every
time I add a policy 
that has a somewhat global effect on files/dir, I need to change the
all the file/directory attributes 
in the policy.  Has this been discussed previously?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
True.  The problem is more severe for exec_type than for the directory
access; IMHO, it isn't too much to ask you to enumerate the major
directory types in which binaries to be executed by sudo might live, and
most (all?) of those types should be part of the basic policy
definition, not package-specific, e.g. bin_t, sbin_t, etc.  You don't
even need to define an attribute for that purpose; you can just list
them in your allow rule, or pull them from a macro definition added to
the global macros.
  </pre>
</blockquote>
I am still not sure I can do this. &nbsp;Are you are stating that I would
have to have an allow rule for<br>
each *exec_t? &nbsp;Just searching domains/programs I found&nbsp; &gt; 100 of
these in the default policy. &nbsp;<br>
Maybe we are at odds with what sudo can do. &nbsp;I consider sudo to be a
shortcut from doing <br>
su,newrole,COMMAND. &nbsp;So sudo needs all the rights that su/newrole has
for a particular role. &nbsp;<br>
Now you might be against this because of the security ramifications,
which is ok. &nbsp;But if users <br>
are going to use a SELinux system they are going to expect this
behaviour.<br>
<blockquote type="cite"
 cite="mid1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">This is a problem since with Sudo you are sharing the same terminal
between the process that rand sudo
and the sudo process.  So if you change the privs of the terminal one
process or the other could have 
more privs.  I would prefer to leave the terminal with the current
privs (Usually lower) and make the 
application run by sudo change the terminal privs if it has to. 
(probably seldom).  Any other ideas?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm not clear as to why you can't implement something akin to what
newrole does.  Otherwise, what prevents another process of lower
privilege from arbitrarily accessing the privileged process' terminal?
You can't rely on the DAC protections.

  </pre>
</blockquote>
Ok I just went back and read the code again and it looks like I can
implement the terminal stuff.<br>
There is a -b option on the sudo command that allows sudo to run in
background. &nbsp;Or using job<br>
control you could run the command in background.<br>
<br>
sudo -r sysadm_r /usr/bin/PROGRAM &amp;<br>
<br>
So what happens to control over the terminal in this situation?<br>
<br>
Dan<br>
<br>
</body>
</html>

--------------010702050508010309050708--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
