Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3GAXXI4000680
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 06:33:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3GAXM7R006100
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 10:33:22 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h3GAXLKP006092 for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 10:33:21 GMT
Message-ID: <3E9D3163.9040807@redhat.com>
Date: Wed, 16 Apr 2003 06:33:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Russell Coker <russell@coker.com.au>
Subject: Re: SELinux version of sudo
References: <3E9C17E9.2060203@redhat.com> <1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil> <200304161408.06042.russell@coker.com.au>
In-Reply-To: <200304161408.06042.russell@coker.com.au>
Content-Type: multipart/alternative;
 boundary="------------030304060504080204090104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------030304060504080204090104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Russell Coker wrote:

>On Wed, 16 Apr 2003 03:33, Stephen Smalley wrote:
>  
>
>>The idea of merging su and newrole has been suggested on the list
>>previously; please be sure that you have read the earlier discussions
>>and are aware of the potential risks, e.g. see the thread starting at
>>http://marc.theaimsgroup.com/?l=selinux&m=102643997004008&w=2, so that
>>you can avoid common pitfalls.
>>    
>>
>
>That thread did not entirely convince me not to do it, but did convince me 
>that it would take much of consideration and testing, and that there were 
>more important things to spend time on.
>
>Another potential solution to this issue is to allow the administrators in 
>question to ssh into an account with UID=0 and then they only need to use 
>newrole to get all the privs they need.
>
>  
>
>>via allow rules.  It isn't clear that you should be using the existing
>>$1_su_t domain for this purpose, unless you are also patching su to
>>provide this functionality and to ensure that it does not allow
>>    
>>
>
>I agree.  The $1_su_t domain only makes sense when you are limiting the 
>transitions to a certain set of domains.  If you grant the su/sudo program 
>privrole access then there is no benefit in having more than one domain in 
>the way it is currently done.
>
>Maybe we should work from the other direction and consider adding setuid() 
>support to newrole?
>  
>
I like the idea of combining DAC with MAC using sudo rather than 
su/newrole.  This would allow
an administrator to allow other people run functions that require 
greater access to the system without them
having to have the root password.   IE.  You could allow someone to 
manage the printers database without
having to become root.  Doing all MAC becomes to combersome for this 
type of thing.

>  
>

--------------030304060504080204090104
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
<br>
<br>
Russell Coker wrote:<br>
<blockquote type="cite"
 cite="mid200304161408.06042.russell@coker.com.au">
  <pre wrap="">On Wed, 16 Apr 2003 03:33, Stephen Smalley wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">The idea of merging su and newrole has been suggested on the list
previously; please be sure that you have read the earlier discussions
and are aware of the potential risks, e.g. see the thread starting at
<a class="moz-txt-link-freetext" href="http://marc.theaimsgroup.com/?l=selinux&m=102643997004008&w=2">http://marc.theaimsgroup.com/?l=selinux&amp;m=102643997004008&amp;w=2</a>, so that
you can avoid common pitfalls.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That thread did not entirely convince me not to do it, but did convince me 
that it would take much of consideration and testing, and that there were 
more important things to spend time on.

Another potential solution to this issue is to allow the administrators in 
question to ssh into an account with UID=0 and then they only need to use 
newrole to get all the privs they need.

  </pre>
  <blockquote type="cite">
    <pre wrap="">via allow rules.  It isn't clear that you should be using the existing
$1_su_t domain for this purpose, unless you are also patching su to
provide this functionality and to ensure that it does not allow
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I agree.  The $1_su_t domain only makes sense when you are limiting the 
transitions to a certain set of domains.  If you grant the su/sudo program 
privrole access then there is no benefit in having more than one domain in 
the way it is currently done.

Maybe we should work from the other direction and consider adding setuid() 
support to newrole?
  </pre>
</blockquote>
I like the idea of combining DAC with MAC using sudo rather than
su/newrole. &nbsp;This would allow<br>
an administrator to allow other people run functions that require
greater access to the system without them <br>
having to have the root password. &nbsp; IE. &nbsp;You could allow someone to
manage the printers database without<br>
having to become root. &nbsp;Doing all MAC becomes to combersome for this
type of thing.<br>
<blockquote type="cite"
 cite="mid200304161408.06042.russell@coker.com.au">
  <pre wrap="">
  </pre>
</blockquote>
</body>
</html>

--------------030304060504080204090104--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
