Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UKDwI4006828
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 16:13:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3UKDmVf006679
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 20:13:48 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h3UKDm4D006676
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 20:13:48 GMT
Message-ID: <3EB02E78.3000905@redhat.com>
Date: Wed, 30 Apr 2003 16:13:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: SUDO package
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>	 <3EA5A040.40107@redhat.com>	 <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>	 <3EAFEECA.1090107@redhat.com>	 <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil>	 <3EB01EC8.7070602@redhat.com> <1051730417.1028.78.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1051730417.1028.78.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------050108060305060202060001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------050108060305060202060001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Wed, 2003-04-30 at 15:06, Daniel J Walsh wrote:
>  
>
>>I am still not sure I can do this.  Are you are stating that I would
>>have to have an allow rule for
>>each *exec_t?
>>    
>>
>
>No, I'm talking about your allow rule for directory access.  An *exec_t
>type should never be applied to a directory; it is supposed to be the
>type of an entrypoint executable for a domain.  For allowing sudo to
>search directories containing binaries, you should just be able to
>enumerate the set of directory types, e.g. bin_t, sbin_t, lib_t, etc_t,
>etc.  There is no valid reason to use file_type.  Just define a macro in
>global macros that enumerates the list of system directories with
>authorized programs, and use that macro in your rule.
>  
>
Ok now I understand.  I can just go with the directory commands from  
can_exec_any rule.
    allow $1 { bin_t sbin_t lib_t etc_t }:dir r_dir_perms;
    allow $1 { bin_t sbin_t }:lnk_file read;

in sudo.te which would satisfy my needs.  Probably do not need lib_t or 
etc_t.
Is that what you had in mind?

>  
>
>>So sudo needs all the rights that su/newrole has for a particular
>>    
>>
>role.  
>
>Right, but we would ultimately like to see the roles pruned down to
>least privilege, e.g. you don't really want sysadm_t running arbitrary
>executables directly, as that can easily lead to a compromise.
>
>  
>
>>Ok I just went back and read the code again and it looks like I can
>>implement the terminal stuff.
>>There is a -b option on the sudo command that allows sudo to run in
>>background.  Or using job
>>control you could run the command in background.
>>
>>sudo -r sysadm_r /usr/bin/PROGRAM &
>>
>>So what happens to control over the terminal in this situation?
>>    
>>
>
>In that case, the program shouldn't be accessing the terminal, and you
>should redirect input and/or output to a file if the program wants to
>read any input or write any output.
>
>  
>
Not exactly an ideal behaviour.  

Consider
sudo -r sysadm_r /bin/sh
would be broken by this.

This is an interesting problem in that two processes want to use the 
terminal at the same time, each with a different security context.  So 
if one is running and is suspended, do we change the security context of 
the terminal to the now running terminal?  Could we do that?

Dan

--------------050108060305060202060001
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
 cite="mid1051730417.1028.78.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">On Wed, 2003-04-30 at 15:06, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am still not sure I can do this.  Are you are stating that I would
have to have an allow rule for
each *exec_t?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No, I'm talking about your allow rule for directory access.  An *exec_t
type should never be applied to a directory; it is supposed to be the
type of an entrypoint executable for a domain.  For allowing sudo to
search directories containing binaries, you should just be able to
enumerate the set of directory types, e.g. bin_t, sbin_t, lib_t, etc_t,
etc.  There is no valid reason to use file_type.  Just define a macro in
global macros that enumerates the list of system directories with
authorized programs, and use that macro in your rule.
  </pre>
</blockquote>
Ok now I understand. &nbsp;I can just go with the directory commands from&nbsp;
can_exec_any rule.<br>
&nbsp;&nbsp;&nbsp; allow $1 { bin_t sbin_t lib_t etc_t }:dir r_dir_perms;<br>
&nbsp;&nbsp;&nbsp; allow $1 { bin_t sbin_t }:lnk_file read;<br>
<br>
in sudo.te which would satisfy my needs. &nbsp;Probably do not need lib_t or
etc_t.<br>
Is that what you had in mind?<br>
<br>
<blockquote type="cite"
 cite="mid1051730417.1028.78.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">So sudo needs all the rights that su/newrole has for a particular
    </pre>
  </blockquote>
  <pre wrap=""><!---->role.  

Right, but we would ultimately like to see the roles pruned down to
least privilege, e.g. you don't really want sysadm_t running arbitrary
executables directly, as that can easily lead to a compromise.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Ok I just went back and read the code again and it looks like I can
implement the terminal stuff.
There is a -b option on the sudo command that allows sudo to run in
background.  Or using job
control you could run the command in background.

sudo -r sysadm_r /usr/bin/PROGRAM &amp;

So what happens to control over the terminal in this situation?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
In that case, the program shouldn't be accessing the terminal, and you
should redirect input and/or output to a file if the program wants to
read any input or write any output.

  </pre>
</blockquote>
Not exactly an ideal behaviour. &nbsp;<br>
<br>
Consider <br>
sudo -r sysadm_r /bin/sh <br>
would be broken by this.<br>
<br>
This is an interesting problem in that two processes want to use the
terminal at the same time, each with a different security context. &nbsp;So
if one is running and is suspended, do we change the security context
of the terminal to the now running terminal? &nbsp;Could we do that?<br>
<br>
Dan<br>
</body>
</html>

--------------050108060305060202060001--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
