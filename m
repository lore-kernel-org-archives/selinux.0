Message-ID: <3FC4BDD3.8090504@redhat.com>
Date: Wed, 26 Nov 2003 09:50:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: Re: Problems with /dev/tty on reboot.
References: <3FC4AF2B.3060301@redhat.com> <1069856081.30315.55.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1069856081.30315.55.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------050007020109030909000603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050007020109030909000603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Wed, 2003-11-26 at 08:48, Daniel J Walsh wrote:
>  
>
>>How should we handle the situation where contexts end up in the wrong 
>>contexts because of crashes or reboots.
>>
>>Currently if you login to a box as user_t, and then the system crashes 
>>or you reboot the /dev/tty has the wrong context on it, so if the next 
>>user that attempts to login has staff_t he will not be able to gain 
>>access to the device.  I have put a
>>setfiles file_context /dev/tty in my rc scripts as a stop gap, but that 
>>is not a clean solution.  Also this can probably happen to other files 
>>that have their contexts changed by running processes.  Ideas on how to 
>>solve this problem??
>>    
>>
>
>The same issue should exist for the uid/gid on the tty; I would expect
>that getty resets the owner on the tty to avoid this problem, so you
>could likewise have getty reset the label.  In the past, we worked
>around the problem by providing broader type_change rules in the policy,
>e.g.
>	type_change staff_t ttyfile:chr_file staff_tty_device_t;
>
>I'm not sure why these were removed.  In fact, I see the general form of
>this rule in policy/macros/user_macros.te, as:
>	type_change $1_t ttyfile:chr_file $1_tty_device_t;
>but it is within an ifdef(`dpkg.te') block for some reason.
>
>Note:  type_change rules just indicate what new type to use when
>relabeling an existing file with a given type for a process with a given
>domain.  Programs like login use the security_compute_relabel()
>interface to obtain the new context for the tty, and this new context is
>computed based on the type_change rules.
>  
>

Ok, moving the ifdef(`dpkg.te') rule allowed login to relabel the tty 
and me to login, but should we still make the change to getty to relabel 
the tty?  If yes, how should getty determine what context to set the tty 
too?  Do we need to add something to default_contexts or is there 
another way to determine this?

Dan

--------------050007020109030909000603
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
 cite="mid1069856081.30315.55.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Wed, 2003-11-26 at 08:48, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">How should we handle the situation where contexts end up in the wrong 
contexts because of crashes or reboots.

Currently if you login to a box as user_t, and then the system crashes 
or you reboot the /dev/tty has the wrong context on it, so if the next 
user that attempts to login has staff_t he will not be able to gain 
access to the device.  I have put a
setfiles file_context /dev/tty in my rc scripts as a stop gap, but that 
is not a clean solution.  Also this can probably happen to other files 
that have their contexts changed by running processes.  Ideas on how to 
solve this problem??
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The same issue should exist for the uid/gid on the tty; I would expect
that getty resets the owner on the tty to avoid this problem, so you
could likewise have getty reset the label.  In the past, we worked
around the problem by providing broader type_change rules in the policy,
e.g.
	type_change staff_t ttyfile:chr_file staff_tty_device_t;

I'm not sure why these were removed.  In fact, I see the general form of
this rule in policy/macros/user_macros.te, as:
	type_change $1_t ttyfile:chr_file $1_tty_device_t;
but it is within an ifdef(`dpkg.te') block for some reason.

Note:  type_change rules just indicate what new type to use when
relabeling an existing file with a given type for a process with a given
domain.  Programs like login use the security_compute_relabel()
interface to obtain the new context for the tty, and this new context is
computed based on the type_change rules.
  </pre>
</blockquote>
<br>
Ok, moving the ifdef(`dpkg.te') rule allowed login to relabel the tty
and me to login, but should we still make the change to getty to
relabel the tty?&nbsp; If yes, how should getty determine what context to
set the tty too?&nbsp; Do we need to add something to default_contexts or is
there another way to determine this?<br>
<br>
Dan<br>
</body>
</html>

--------------050007020109030909000603--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
