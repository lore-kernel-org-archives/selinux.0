Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA15835
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 06:46:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA18536
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 11:45:16 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA18532 for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 11:45:10 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A2C2892749
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 22:45:47 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 258399C1
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 12:45:34 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: starting daemons under Debian
Date: Sun, 20 Jan 2002 12:45:27 +0100
References: <20020118230436.2772532FA2C@lyta.coker.com.au> <87665xpldy.fsf@glaurung.green-gryphon.com>
In-Reply-To: <87665xpldy.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Message-Id: <20020120114535.258399C1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Jan 2002 07:49, Manoj Srivastava wrote:
> >>"Russell" == Russell Coker <russell@coker.com.au> writes:
>
>  Russell> One thing I have played with is setting the security
>  Russell> contexts so that the daemon automatically changes to the
>  Russell> correct domain on startup from the sysadm_t domain such as
>  Russell> the following (and also a minor matching change to rbac to
>  Russell> make it allow root:sysadm_r:sshd_t):
>
>  Russell> domain_auto_trans(sysadm_t , sshd_exec_t, sshd_t)
>
>  Russell> This is minorly ugly, involves more rules than I'd like, but
>  Russell> has the benefit that running "sshd" at the command line gets
>  Russell> the same result as "/etc/init.d/ssh start".
>
>  Russell> The other option is to divert /sbin/start-stop-daemon which
>  Russell> is used by Debian for starting most (should be all) daemons.
>  Russell> Then my replacement script would call run_init to run the
>  Russell> real start-stop-daemon.
>
> 	But you lose the option to start sshd on the command line,
>  don't you?

You lose the option to type "sshd" to start it, but you don't lose the option 
to type "/etc/init.d/ssh start".

>  Russell> Any comments on the relative merits of these two schemes?
>
> 	Putting on my Debian hat, I'd prefer the former, all else
>  being the same. I'd also like to investigate the possibility of
>  packages providing the recommended additions to policy, which can be
>  used by the policy admin as a guide to what rules may be needed to
>  utilize a package to the fullest capacity (I would not, of course,
>  skip the human oversight step and automate the process).

Good point.

I think that we need a program to modify devfs_contexts and file_contexts and 
run chsid (for devfs_contexts) and give the option of either relabeling or 
running chsid for changes to file_contexts.  Also we need some sort of 
program that operates in a similar fashion to useradd for the rbac file.

All of this needs to ask sane questions of the user.


PS  We'll have to use chsid not chcon because chcon isn't in the base package.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
