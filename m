Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAOMj0Rb011262
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 17:45:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAOMiwqa023656
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 22:44:59 GMT
Message-ID: <3FC289E7.30602@redhat.com>
Date: Mon, 24 Nov 2003 17:44:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: How to handle lots of executables  buried in /usr
References: <3FC21D65.5070803@redhat.com> <1069700405.8635.137.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1069700405.8635.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------040506070807020809090804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040506070807020809090804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Mon, 2003-11-24 at 10:01, Daniel J Walsh wrote:
>  
>
>>I am seeing lots of errors in policy because of shell scripts and exes 
>>that are installed in subdirectories of /usr being marked as  usr_t 
>>instead of bin_t .  What do you guys think of adding a script to be 
>>executed after make relabel that would find these files and change their 
>>context to bin_t.
>>
>>find /usr -perm +111 --context system_u:object_r:usr_t -type f -exec 
>>chcon \
>>system_u:object_r:bin_t {} ; -print
>>
>>
>>Is this a bad idea?  I do notice that their are a lot of files marked 
>>executables by their install that are really not executable, but this 
>>would clean up several failures untill the package installs are cleaned up.
>>    
>>
>
>It might be better to define multiple types for different groups of
>binaries, and only grant execute access as appropriate.
>
>As a side note, be careful about symlinks.  The above find construct
>will get the context of the symlink, but the chcon will set the context
>of the referenced file unless you specify -h.
>  
>
The -type f on the command line will ensure that it only gets files, not 
sym links.

Dan

--------------040506070807020809090804
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
 cite="mid1069700405.8635.137.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Mon, 2003-11-24 at 10:01, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am seeing lots of errors in policy because of shell scripts and exes 
that are installed in subdirectories of /usr being marked as  usr_t 
instead of bin_t .  What do you guys think of adding a script to be 
executed after make relabel that would find these files and change their 
context to bin_t.

find /usr -perm +111 --context system_u:object_r:usr_t -type f -exec 
chcon \
system_u:object_r:bin_t {} ; -print


Is this a bad idea?  I do notice that their are a lot of files marked 
executables by their install that are really not executable, but this 
would clean up several failures untill the package installs are cleaned up.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It might be better to define multiple types for different groups of
binaries, and only grant execute access as appropriate.

As a side note, be careful about symlinks.  The above find construct
will get the context of the symlink, but the chcon will set the context
of the referenced file unless you specify -h.
  </pre>
</blockquote>
The -type f on the command line will ensure that it only gets files,
not sym links.<br>
<br>
Dan<br>
</body>
</html>

--------------040506070807020809090804--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
