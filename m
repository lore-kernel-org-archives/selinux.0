Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA02131
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 10:56:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA05732
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 14:55:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA05728
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 14:55:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: oops
Date: Tue, 18 Jun 2002 16:55:56 +0200
References: <45F949D73F69D41198B00004AC2513FB03D5B6CD@mad00mp3.dot.state.wi.us>
In-Reply-To: <45F949D73F69D41198B00004AC2513FB03D5B6CD@mad00mp3.dot.state.wi.us>
MIME-Version: 1.0
Message-Id: <20020618145556.D02161581@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 Jun 2002 16:32, you wrote:
> Isn't the below somewhat of an invite to unauthorized activity on this
> machine ?
> ===========================================================================
>= ==
> Anyway the machine is available now.  Ssh to port 222 on adsl.coker.com.au,
> root password is "1".
> ===========================================================================

Anything on that machine is authorised.  I would prefer that people report 
any security issues to me rather than exploiting them, and so far that's been 
done.

James Bromberger reported to me that he could read /etc/shadow.  I have 
changed that file to type shadow_t and changed the passwd.te policy file to 
preserve the permissions across change of password (and of course changed 
every .te file for a login type program).

The next thing to do is to address the issue of vipw, chage, etc as sysadm_t, 
which I will work on later tonight.


Below is the new motd on my SE play box:

This machine is running NSA Security Enhanced Linux.  You are free to try and
break the security of this machine as long as you do the following:

1)  Do not use it to attack any machine without the permission of the 
machine's
    owner.  If you want to use it to probe your own machines that's OK.

2A) Report to me any security holes you find.

2B) Destroying this machine is OK if it's the only way to determine that there
    is a hole in the security policy, if you do so please tell me what you 
did!

3)  Don't do DOS attacks against this machine.  I expect that some combination
    of using large numbers of open files, memory, etc can cause the machine to
    become unusable.  Doing that proves nothing, we already know that the
    Linux kernel won't handle all problems of lack of resources in a graceful
    fashion.  The point of this exercise is to test the SE Linux 
functionality.

russell@coker.com.au



PS  I've BCC'd this message to the person that asked the question.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
