Message-ID: <3F465113.3010207@redhat.com>
Date: Fri, 22 Aug 2003 13:21:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: general security lib (was: 2.6.0-test3)
References: <1061468940.1665.16.camel@kusturica>	 <1061487623.22355.27.camel@columbia> <1061555921.1648.142.camel@kusturica>	 <200308230009.19552.russell@coker.com.au> <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------030603040400040709000909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------030603040400040709000909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Also how would you allow the user to select the context they will login 
as if there are more then one?  Unless we remove this capability and 
always force users to use newrole.

Dan

Stephen Smalley wrote:

>On Fri, 2003-08-22 at 10:09, Russell Coker wrote:
>  
>
>>A modification to PAM could allow the sshd, login, and cron patches to go 
>>away.
>>
>>Theodore Ts'o suggested to me that a new PAM call be added to run the shell 
>>which takes appropriate parameters about user-name etc.  Then a SE Linux 
>>version of this module could change the security context appropriately, thus 
>>requiring only one copy of the code to determine the context to use, and not 
>>requiring any on-going modification to applications.
>>
>>This design concept sounds really good, and as it's Ted's suggestion I don't 
>>expect any great resistance to accepting the patch upstream once it's been 
>>tested and proven to work.
>>
>>I've been meaning to work on this for almost a year, I might start work next 
>>week.
>>    
>>
>
>If you investigate this idea, be sure to work from the new SELinux
>patches that use the new SELinux API, not the old one.  Note that the
>new SELinux API is better suited to encapsulation within PAM, since the
>exec context is now an attribute of the process that can be set prior to
>the execve call.  PAM could call setexeccon() when it ordinarily sets
>the user's credentials.  This avoids the need to create a new PAM call,
>or to alter the execve call itself.
>
>While you may be able to move the setup of the user execution context
>into PAM, there are other elements of the SELinux patches as well, such
>as the labeling of the tty/pty and the entrypoint check for cron jobs. 
>Hence, I suspect that we will still need some kind of patch for
>login/sshd/crond, albeit a smaller one. 
>
>  
>

--------------030603040400040709000909
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Also how would you allow the user to select the context they will login
as if there are more then one? &nbsp;Unless we remove this capability and
always force users to use newrole.<br>
<br>
Dan<br>
<br>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Fri, 2003-08-22 at 10:09, Russell Coker wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">A modification to PAM could allow the sshd, login, and cron patches to go 
away.

Theodore Ts'o suggested to me that a new PAM call be added to run the shell 
which takes appropriate parameters about user-name etc.  Then a SE Linux 
version of this module could change the security context appropriately, thus 
requiring only one copy of the code to determine the context to use, and not 
requiring any on-going modification to applications.

This design concept sounds really good, and as it's Ted's suggestion I don't 
expect any great resistance to accepting the patch upstream once it's been 
tested and proven to work.

I've been meaning to work on this for almost a year, I might start work next 
week.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If you investigate this idea, be sure to work from the new SELinux
patches that use the new SELinux API, not the old one.  Note that the
new SELinux API is better suited to encapsulation within PAM, since the
exec context is now an attribute of the process that can be set prior to
the execve call.  PAM could call setexeccon() when it ordinarily sets
the user's credentials.  This avoids the need to create a new PAM call,
or to alter the execve call itself.

While you may be able to move the setup of the user execution context
into PAM, there are other elements of the SELinux patches as well, such
as the labeling of the tty/pty and the entrypoint check for cron jobs. 
Hence, I suspect that we will still need some kind of patch for
login/sshd/crond, albeit a smaller one. 

  </pre>
</blockquote>
</body>
</html>

--------------030603040400040709000909--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
