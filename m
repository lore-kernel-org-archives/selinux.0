Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UFgUI4005109
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 11:42:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UFgS7R016330
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 15:42:28 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h3UFgLKP016327 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 15:42:24 GMT
Message-ID: <3EAFEECA.1090107@redhat.com>
Date: Wed, 30 Apr 2003 11:42:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: SUDO package
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>	 <3EA5A040.40107@redhat.com> <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------090903050101080405020808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------090903050101080405020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2003-04-22 at 16:04, Daniel J Walsh wrote:
>  
>
>>I don't think you define a separate attribute for every program that
>>can be executed, since by 
>>definition sudo can run every program on the system.
>>    
>>
>
>Not a separate attribute for every program, but a single new attribute
>that is associated with every program type that should be executable via
>sudo.  By using exec_type, you limit the freedom of other policy writers
>to create program types that they do not want to be executed via sudo. 
>It would be better to define a new attribute, add it to the attribute
>list for every type that should be executable by sudo, and use that
>attribute in your sudo.te file.
>  
>
>  
>
>>I have changed this to 
>>allow sudo_t file_type:dir search
>>It looks like sudo checks to see if the program exists before it
>>exec's it.
>>    
>>
>
>I would prefer that this rule be refined down to a specific list of
>directory types, or that a new attribute be defined and added to all
>desired directory types for this purpose.  Again, you want to allow
>other policy writers to be able to define directory types that cannot be
>searched by sudo in order to meet their policy goals.
>  
>
I have a hard time with the previous two.  Just seems to me SELinux 
needs some sort
of dontallow functionality to handle these situation.  Otherwise every 
time I add a policy
that has a somewhat global effect on files/dir, I need to change the all 
the file/directory attributes
in the policy.  Has this been discussed previously?

>  
>
>>I am not sure what to do here.  sudo is different then newrole in that
>>it does a fork/exec and the
>>parent exits.  So waiting around for the child to exit in order to set
>>the terminal ownership back is
>>changing the fundamental behavior of sudo.  What is the ramifications
>>of not changing the sid of the
>>controlling terminal?
>>    
>>
>
>If you don't relabel the terminal, then another process operating in the
>old domain (say user_t) can still access the terminal while the program
>in the new domain (say sysadm_t) is running.  Hence, a malicious user or
>program can interfere with a more privileged process being run via sudo.
>  
>
This is a problem since with Sudo you are sharing the same terminal 
between the process that rand sudo
and the sudo process.  So if you change the privs of the terminal one 
process or the other could have
more privs.  I would prefer to leave the terminal with the current privs 
(Usually lower) and make the
application run by sudo change the terminal privs if it has to. 
 (probably seldom).  Any other ideas?

>  
>
>># create run file 
>>type sudo_var_run_t, file_type, sysadmfile;
>>file_type_auto_trans(sudo_t,var_run_t,sudo_var_run_t);
>>allow sudo_t sudo_var_run_t:file create_file_perms;
>>allow sudo_t sudo_var_run_t:dir create_dir_perms;
>>    
>>
>
>The file_type_auto_trans macro includes the necessary allow rules for
>creating files and directories in the type, so you can drop the two
>allow rules above.
>  
>
Done

>  
>
>># sudo
>>/usr/bin/sudo			system_u:object_r:sudo_exec_t
>>/var/run/sudo			system_u:object_r:sudo_var_run_t
>>    
>>
>
>I think you want '/var/run/sudo(/.*)?' as your regular expression, so
>that this type will be applied to the directory and all files beneath
>it.
>
>  
>
Done.

--------------090903050101080405020808
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
 cite="mid1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">On Tue, 2003-04-22 at 16:04, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I don't think you define a separate attribute for every program that
can be executed, since by 
definition sudo can run every program on the system.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Not a separate attribute for every program, but a single new attribute
that is associated with every program type that should be executable via
sudo.  By using exec_type, you limit the freedom of other policy writers
to create program types that they do not want to be executed via sudo. 
It would be better to define a new attribute, add it to the attribute
list for every type that should be executable by sudo, and use that
attribute in your sudo.te file.
  </pre>
</blockquote>
<blockquote type="cite"
 cite="mid1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have changed this to 
allow sudo_t file_type:dir search
It looks like sudo checks to see if the program exists before it
exec's it.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I would prefer that this rule be refined down to a specific list of
directory types, or that a new attribute be defined and added to all
desired directory types for this purpose.  Again, you want to allow
other policy writers to be able to define directory types that cannot be
searched by sudo in order to meet their policy goals.
  </pre>
</blockquote>
I have a hard time with the previous two. &nbsp;Just seems to me SELinux
needs some sort<br>
of dontallow functionality to handle these situation. &nbsp;Otherwise every
time I add a policy <br>
that has a somewhat global effect on files/dir, I need to change the
all the file/directory attributes <br>
in the policy. &nbsp;Has this been discussed previously?<br>
<blockquote type="cite"
 cite="mid1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am not sure what to do here.  sudo is different then newrole in that
it does a fork/exec and the
parent exits.  So waiting around for the child to exit in order to set
the terminal ownership back is
changing the fundamental behavior of sudo.  What is the ramifications
of not changing the sid of the
controlling terminal?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If you don't relabel the terminal, then another process operating in the
old domain (say user_t) can still access the terminal while the program
in the new domain (say sysadm_t) is running.  Hence, a malicious user or
program can interfere with a more privileged process being run via sudo.
  </pre>
</blockquote>
This is a problem since with Sudo you are sharing the same terminal
between the process that rand sudo<br>
and the sudo process. &nbsp;So if you change the privs of the terminal one
process or the other could have <br>
more privs. &nbsp;I would prefer to leave the terminal with the current
privs (Usually lower) and make the <br>
application run by sudo change the terminal privs if it has to.
&nbsp;(probably seldom). &nbsp;Any other ideas?<br>
<br>
<blockquote type="cite"
 cite="mid1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap=""># create run file 
type sudo_var_run_t, file_type, sysadmfile;
file_type_auto_trans(sudo_t,var_run_t,sudo_var_run_t);
allow sudo_t sudo_var_run_t:file create_file_perms;
allow sudo_t sudo_var_run_t:dir create_dir_perms;
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The file_type_auto_trans macro includes the necessary allow rules for
creating files and directories in the type, so you can drop the two
allow rules above.
  </pre>
</blockquote>
Done<br>
<blockquote type="cite"
 cite="mid1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap=""># sudo
/usr/bin/sudo			system_u:object_r:sudo_exec_t
/var/run/sudo			system_u:object_r:sudo_var_run_t
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I think you want '/var/run/sudo(/.*)?' as your regular expression, so
that this type will be applied to the directory and all files beneath
it.

  </pre>
</blockquote>
Done.<br>
</body>
</html>

--------------090903050101080405020808--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
