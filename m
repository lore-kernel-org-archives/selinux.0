Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA22579
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 04:58:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA29193
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 09:56:29 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
        by jazzband.ncsc.mil  with ESMTP id JAA29189 for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 09:56:28 GMT
Message-Id: <200211070956.JAA29189@jazzband.ncsc.mil>
Date: Thu, 7 Nov 2002 4:55:13 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: Russell Coker <russell@coker.com.au>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Re: SELinux and security tools?
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for replying.  In the past I would login as root to use these tools.
My current practice is to use 'sudo' to use these security tools.  I will login
as a regular user but use 'sudo' to use nessus or tcpdump etc.

One basic question about policy,  is this some configuration file that you develop
based on your needs and then use it to compile a new kernel?

Subba Rao
sailorn@attglobal.net
2002-11-07


======= At 2002-11-07, 00:49:00 you wrote: =======

>On Wed, 6 Nov 2002 20:24, Wayne Salamon wrote:
>> On Wed, 6 Nov 2002, Subba Rao wrote:
>> > I am planning to install SELinux on one of my laptop.  The key tools I
>> > plan to use are security tools such as Nessus, nmap, Snort and
>> > tcpdump. Will these tools work well on on SELinux?  Has anyone
>> > experienced problems with these tools on SELinux?
>>
>>   There shouldn't be a problem running these utilities under SELinux, but
>> you will have to modify the policy for some of them. tcpdump is already
>> known to the example policy (in the netutils domain), as is snort (it has
>
>One thing to note is that network utility programs such as those have the 
>sample policy setup to allow them to be run from an administrative session 
>(sysadm_r).  If you want to run them from a laptop then you are probably 
>doing so not as an administrative task but to use a laptop as a workstation 
>or test machine for administering other machines on the network.  Therefore 
>you'll probably want to run them from user_r instead which will require some 
>minor adjustments to the policy.
>
>For a while I have been thinking of setting up the policy to make it easier to 
>allow separate domains for ping and netutils when run from different user 
>roles.  However I don't want to enable it for everyone (as is done for most 
>such domains) but to do it selectively for the particular roles that deserve 
>it.
>

= = = = = = = = = = = = = = = = = = = =
			





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
