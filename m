Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LHp2Wt028388
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:51:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LHokIU014642
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 17:50:48 GMT
Message-ID: <3F957200.9040201@redhat.com>
Date: Tue, 21 Oct 2003 13:50:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
References: <200310200148.15852.russell@coker.com.au>	 <200310211052.28494.russell@coker.com.au>	 <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>	 <200310220043.09925.russell@coker.com.au> <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------000408060407030401030503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000408060407030401030503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2003-10-21 at 10:43, Russell Coker wrote: 
>  
>
>>The results I have so far indicate that this approach has significant 
>>problems.
>>
>>Diverting /sbin/init with a shell script works better than this.
>>    
>>
>
>Ok, thanks for looking into it.  So what exactly is the problem with
>diverting /sbin/init again?  
>
>  
>
I still believe that the patch to /sbin/init is simple enough that all 
the rest of this stuff is complicating matters.  It allows too many ways 
for someone to make a modification that breaks security.  I have updated 
the files on people.redhat.com/dwalsh to use the modified init.  I have 
passed this by Bill Nottingham (Red Hat maintainer) and he is ok with it.

Of course if someone comes up with a simpler solution we would look at it.

Dan



--------------000408060407030401030503
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
 cite="mid1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Tue, 2003-10-21 at 10:43, Russell Coker wrote: 
  </pre>
  <blockquote type="cite">
    <pre wrap="">The results I have so far indicate that this approach has significant 
problems.

Diverting /sbin/init with a shell script works better than this.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ok, thanks for looking into it.  So what exactly is the problem with
diverting /sbin/init again?  

  </pre>
</blockquote>
I still believe that the patch to /sbin/init is simple enough that all
the rest of this stuff is complicating matters.&nbsp; It allows too many
ways for someone to make a modification that breaks security.&nbsp; I have
updated the files on people.redhat.com/dwalsh to use the modified
init.&nbsp; I have passed this by Bill Nottingham (Red Hat maintainer) and
he is ok with it.<br>
<br>
Of course if someone comes up with a simpler solution we would look at
it.<br>
<br>
Dan<br>
<br>
<br>
</body>
</html>

--------------000408060407030401030503--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
