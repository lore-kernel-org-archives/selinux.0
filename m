Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FIScI4027878
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:28:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3FISb7R001082
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 18:28:37 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h3FISZKP001075 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 18:28:36 GMT
Message-ID: <3E9C4F46.7070207@redhat.com>
Date: Tue, 15 Apr 2003 14:28:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux version of sudo
References: <3E9C17E9.2060203@redhat.com> <1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------010808030204020704060002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------010808030204020704060002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2003-04-15 at 10:32, Daniel J Walsh wrote:
>  
>
>>I have been playing around with SELinux a little and was getting 
>>agravated in always changing roles and
>>then having to su to root.  What I really needed was the functionality 
>>of sudo and newrole combined together.
>>    
>>
>
>The idea of merging su and newrole has been suggested on the list
>previously; please be sure that you have read the earlier discussions
>and are aware of the potential risks, e.g. see the thread starting at
>http://marc.theaimsgroup.com/?l=selinux&m=102643997004008&w=2, so that
>you can avoid common pitfalls.
>  
>
I will change the version of sudo to require a password when changing 
context always (including
if root runs sudo).  I think that is the only thing I broke in my 
version of sudo.  I will attempt to make
the changes you suggest in policy and see if it works.  Thanks.  

>  
>
>>Apr 15 09:13:40 pxe kernel: avc:  denied  { setattr } for  pid=2377 
>>exe=/usr/bin/sudo path=/var/run/sudo/dwalsh/1 dev=03:02 ino=962189 
>>scontext=dwalsh:user_r:user_su_t tcontext=dwalsh:object_r:var_run_t 
>>tclass=file
>>    
>>
>
>You need to define a type for the /var/run files created by sudo (e.g.
>type var_run_sudo_t, sysadmfile, file_type;) and grant permissions to it
>via allow rules.  It isn't clear that you should be using the existing
>$1_su_t domain for this purpose, unless you are also patching su to
>provide this functionality and to ensure that it does not allow
>processes with uid 0 to transition to arbitrary SELinux security
>contexts.  I'm also not sure whether it will end up being beneficial to
>keep this as a derived domain ($1_sudo_t) from the user domain or if you
>should just make it a basic domain (sudo_t in a domains/program/sudo.te
>file) like newrole.  You will naturally need to use many of the same
>attributes and rules as newrole_t for your desired functionality, so
>extending newrole_t may be the better choice (or at least duplicating
>newrole_t's rules for a new domain).
>
>  
>
>>Apr 15 09:13:50 pxe kernel:
>>Apr 15 09:13:50 pxe kernel: avc:  denied  { transition } for  pid=2378 
>>exe=/usr/bin/sudo path=/usr/local/selinux/bin/id dev=03:02 ino=2316548 
>>scontext=dwalsh:user_r:user_su_t tcontext=dwalsh:sysadm_r:sysadm_t 
>>tclass=process
>>    
>>
>
>The domain must have the privrole attribute to transition to a different
>role, and $1_su_t does not possess this attribute at present (whereas
>newrole_t does).  You also need a domain_trans rule to authorize this
>domain transition.  As above, I don't think that you should add these
>attributes and rules to $1_su_t unless you are also patching the su
>program, and you can copy much of what you need from the newrole_t
>domain.  Starting with the newrole_t domain may be a better choice.
>
>  
>
>>Also modified policy/domains/program/newrole.te
>>
>>--- newrole.te~    2003-03-06 18:13:25.000000000 -0500
>>+++ newrole.te    2003-04-14 16:26:10.000000000 -0400
>>@@ -27,7 +27,8 @@
>> can_exec(newrole_t, chkpwd_exec_t)
>> 
>> # Allow newrole_t to transition to user domains.
>>-domain_trans(newrole_t, shell_exec_t, userdomain)
>>+# domain_trans(newrole_t, shell_exec_t, userdomain)
>>+domain_trans(newrole_t,{ bin_t sbin_t exec_type }, userdomain)
>> domain_trans(newrole_t, ls_exec_t, userdomain)
>>
>> # Use capabilities.
>>    
>>
>
>This is only useful if you are modifying newrole or putting sudo into
>the newrole_t domain.  It serves no purpose if you are using $1_su_t or
>a completely new domain.
>
>  
>


--------------010808030204020704060002
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
 cite="mid1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">On Tue, 2003-04-15 at 10:32, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have been playing around with SELinux a little and was getting 
agravated in always changing roles and
then having to su to root.  What I really needed was the functionality 
of sudo and newrole combined together.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The idea of merging su and newrole has been suggested on the list
previously; please be sure that you have read the earlier discussions
and are aware of the potential risks, e.g. see the thread starting at
<a class="moz-txt-link-freetext" href="http://marc.theaimsgroup.com/?l=selinux&m=102643997004008&w=2">http://marc.theaimsgroup.com/?l=selinux&amp;m=102643997004008&amp;w=2</a>, so that
you can avoid common pitfalls.
  </pre>
</blockquote>
I will change the version of sudo to require a password when changing
context always (including<br>
if root runs sudo). &nbsp;I think that is the only thing I broke in my
version of sudo. &nbsp;I will attempt to make<br>
the changes you suggest in policy and see if it works. &nbsp;Thanks. &nbsp;<br>
<br>
<pre wrap="">
</pre>
<blockquote type="cite"
 cite="mid1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">Apr 15 09:13:40 pxe kernel: avc:  denied  { setattr } for  pid=2377 
exe=/usr/bin/sudo path=/var/run/sudo/dwalsh/1 dev=03:02 ino=962189 
scontext=dwalsh:user_r:user_su_t tcontext=dwalsh:object_r:var_run_t 
tclass=file
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You need to define a type for the /var/run files created by sudo (e.g.
type var_run_sudo_t, sysadmfile, file_type;) and grant permissions to it
via allow rules.  It isn't clear that you should be using the existing
$1_su_t domain for this purpose, unless you are also patching su to
provide this functionality and to ensure that it does not allow
processes with uid 0 to transition to arbitrary SELinux security
contexts.  I'm also not sure whether it will end up being beneficial to
keep this as a derived domain ($1_sudo_t) from the user domain or if you
should just make it a basic domain (sudo_t in a domains/program/sudo.te
file) like newrole.  You will naturally need to use many of the same
attributes and rules as newrole_t for your desired functionality, so
extending newrole_t may be the better choice (or at least duplicating
newrole_t's rules for a new domain).

  </pre>
  <blockquote type="cite">
    <pre wrap="">Apr 15 09:13:50 pxe kernel:
Apr 15 09:13:50 pxe kernel: avc:  denied  { transition } for  pid=2378 
exe=/usr/bin/sudo path=/usr/local/selinux/bin/id dev=03:02 ino=2316548 
scontext=dwalsh:user_r:user_su_t tcontext=dwalsh:sysadm_r:sysadm_t 
tclass=process
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The domain must have the privrole attribute to transition to a different
role, and $1_su_t does not possess this attribute at present (whereas
newrole_t does).  You also need a domain_trans rule to authorize this
domain transition.  As above, I don't think that you should add these
attributes and rules to $1_su_t unless you are also patching the su
program, and you can copy much of what you need from the newrole_t
domain.  Starting with the newrole_t domain may be a better choice.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Also modified policy/domains/program/newrole.te

--- newrole.te~    2003-03-06 18:13:25.000000000 -0500
+++ newrole.te    2003-04-14 16:26:10.000000000 -0400
@@ -27,7 +27,8 @@
 can_exec(newrole_t, chkpwd_exec_t)
 
 # Allow newrole_t to transition to user domains.
-domain_trans(newrole_t, shell_exec_t, userdomain)
+# domain_trans(newrole_t, shell_exec_t, userdomain)
+domain_trans(newrole_t,{ bin_t sbin_t exec_type }, userdomain)
 domain_trans(newrole_t, ls_exec_t, userdomain)

 # Use capabilities.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is only useful if you are modifying newrole or putting sudo into
the newrole_t domain.  It serves no purpose if you are using $1_su_t or
a completely new domain.

  </pre>
</blockquote>
<br>
</body>
</html>

--------------010808030204020704060002--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
