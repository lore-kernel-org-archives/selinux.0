Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA17662
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 05:48:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA25642
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 09:46:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA25638
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 09:46:42 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Debian & NSA SELinux
Date: Fri, 26 Apr 2002 11:48:19 +0200
References: <CBEIKNHFNAAFENJHIPFPAEMOCCAA.shindle@toocool.com>
In-Reply-To: <CBEIKNHFNAAFENJHIPFPAEMOCCAA.shindle@toocool.com>
MIME-Version: 1.0
Message-Id: <20020426094819.AA64D428F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Firstly, I decided that your message is more suitable for a response on the 
SE Linux mailing list.  So I am sending this message to the list and BCCing 
you just in case you don't want to be identified.

On Fri, 26 Apr 2002 10:06, you wrote:
>   I noticed you seem to be doing a lot of work on SELinux for Debian.  I
> have been puttering around a bit and had a question: Did you stick with an
> initrc_t domain for all files in /etc/init.d like the example RH stuff ?  I

Firstly, if you install my Debian packages then you'll see exactly what I'm 
doing...

> found that because of the way debian init scripts are written, a single
> initrc_t domain ended up needing access to lots of different stuff: bin_t,
> sbin_t, var_log_t, etc.  I was thinking of putting each init script in its
> own domain (ie smoothwall_initrc_t) and adding a
> 'can_exec(smoothwall_initrc_t)' to the initrc_t stuff.  What do you think
> of this approach ?  It does require that initrc_t get updated each time a
> new package is installed (the debian script tools could ease this
> burden...) but seems like it would provide a more secure environment...

The initrc_t domain is not supposed to have full access.  You are correct 
that in Debian is requires more access than you may desire due to /etc/init.d 
scripts checking configuration files etc.

The idea is that the daemon runs in it's own domain with a 
domain_auto_trans(initrc_t, daemon_exec_t, daemon_t) rule.

I have considered putting some of the /etc/init.d files in appropriate 
daemon_exec_t types for the shell code that they call, however this requires 
a change to run_init to be able to call such scripts correctly.  I would need 
to change run_init to execute "sh -c command" instead of executing the 
command directly.  What currently happens is that run_init uses exec_secure() 
to execute the program in the initrc_t domain.  When the initrc_t domain then 
executes the daemon a domain transition can happen.  An exec_secure() of the 
daemon directly will not result in such a transition.

> btw - Is the mailing list archive at
> http://www.nsa.gov/selinux/list-archive dead ?  The last message I show for
> it is dated March,2002 - has the list moved ??

I believe that any material that appears on that site has to go through an 
approval process, therefore there is a delay.

There's an archive which is (IMHO) better in every way at 
http://marc.theaimsgroup.com/?l=selinux , I just checked and most of my 
postings from last night are there.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
