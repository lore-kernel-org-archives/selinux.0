Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14878
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 10:49:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h14FnDI24286
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 15:49:13 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h14FnAf24278 for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 15:49:11 GMT
Message-ID: <3E3FE0EF.8030105@redhat.com>
Date: Tue, 04 Feb 2003 10:49:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Tom <tom@lemuria.org>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux question?
References: <200301271320.IAA05862@moss-shockers.ncsc.mil> <200302012351.48969.russell@coker.com.au> <3E3F72AE.1070503@redhat.com> <20030204154613.A7115@lemuria.org>
In-Reply-To: <20030204154613.A7115@lemuria.org>
Content-Type: multipart/alternative;
 boundary="------------070003000607060305040602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------070003000607060305040602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tom wrote:

>On Tue, Feb 04, 2003 at 02:58:38AM -0500, Daniel J Walsh wrote:
>  
>
>>Why are certain applications (ls, cp, cd) ported to use SELinux with the 
>>standard names, while others
>>(spasswd, schfn) have a prefix added?  
>>    
>>
>
>ls, ps and others are modified versions of the originals.
>
>spasswd, and the other s* programs are wrappers around the original
>tools. For various reasons, this was the only or better way of making
>them SE-aware in those cases.
>
>
>
>  
>
So they did it because it was easier to wrap the application then to 
change the code, correct?
In the other cases they could not wrap the apps so they went in and 
changed the code.  
I would like to know if there was any other reason to use the s* syntax, 
or all things being equil
you would replace the passwd command with a SELinux aware passwd command?

Dan

Dan

--------------070003000607060305040602
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Tom wrote:<br>
<blockquote type="cite" cite="mid20030204154613.A7115@lemuria.org">
  <pre wrap="">On Tue, Feb 04, 2003 at 02:58:38AM -0500, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Why are certain applications (ls, cp, cd) ported to use SELinux with the 
standard names, while others
(spasswd, schfn) have a prefix added?  
    </pre>
  </blockquote>
  <pre wrap=""><!---->
ls, ps and others are modified versions of the originals.

spasswd, and the other s* programs are wrappers around the original
tools. For various reasons, this was the only or better way of making
them SE-aware in those cases.



  </pre>
</blockquote>
So they did it because it was easier to wrap the application then to
change the code, correct?<br>
In the other cases they could not wrap the apps so they went in and
changed the code. &nbsp;<br>
I would like to know if there was any other reason to use the s*
syntax, or all things being equil<br>
you would replace the passwd command with a SELinux aware passwd
command?<br>
<br>
Dan<br>
<br>
Dan<br>
</body>
</html>

--------------070003000607060305040602--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
