Message-ID: <3FC4D43B.1020105@redhat.com>
Date: Wed, 26 Nov 2003 11:26:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: Re: Problems with /dev/tty on reboot.
References: <3FC4AF2B.3060301@redhat.com>	 <1069856081.30315.55.camel@moss-spartans.epoch.ncsc.mil>	 <3FC4BDD3.8090504@redhat.com> <1069860803.30315.78.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1069860803.30315.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------020002080109010604000307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020002080109010604000307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Wed, 2003-11-26 at 09:50, Daniel J Walsh wrote:
>  
>
>>Ok, moving the ifdef(`dpkg.te') rule allowed login to relabel the tty
>>and me to login, but should we still make the change to getty to
>>relabel the tty?  If yes, how should getty determine what context to
>>set the tty too?  Do we need to add something to default_contexts or
>>is there another way to determine this?
>>    
>>
>
>If getty already resets the ownership, then it makes sense to also patch
>it to reset the context.  It can pull a single context from a config
>file like run_init does, or this could be the time to create that
>libselinux function that returns the matching context from the file
>contexts configuration for a given pathname...
>  
>
Well we need this function anyways if rpm is going to set default 
contexts for files...
Dan

--------------020002080109010604000307
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
 cite="mid1069860803.30315.78.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Wed, 2003-11-26 at 09:50, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Ok, moving the ifdef(`dpkg.te') rule allowed login to relabel the tty
and me to login, but should we still make the change to getty to
relabel the tty?  If yes, how should getty determine what context to
set the tty too?  Do we need to add something to default_contexts or
is there another way to determine this?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If getty already resets the ownership, then it makes sense to also patch
it to reset the context.  It can pull a single context from a config
file like run_init does, or this could be the time to create that
libselinux function that returns the matching context from the file
contexts configuration for a given pathname...
  </pre>
</blockquote>
Well we need this function anyways if rpm is going to set default
contexts for files...<br>
Dan<br>
</body>
</html>

--------------020002080109010604000307--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
