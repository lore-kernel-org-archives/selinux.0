Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA17759
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 22:39:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA19329
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 02:39:07 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id CAA19325
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 02:39:05 GMT
Date: Thu, 1 Aug 2002 12:39:43 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd mods
Message-ID: <20020801023943.GA23655@snoopy.apana.org.au>
References: <20020731165519.087D01FC@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020731165519.087D01FC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 31, 2002 at 06:55:18PM +0200, Russell Coker wrote:
> I think that we could probably benefit from a wrapper program that ssh would 
> run.  This wrapper would perhaps have a configuration method somewhat similar 
> to sudo to determine what programs ssh could run and what parameters can be 
> passed to them.  Then we could deny sshd access to change domain/role and 
> only allow this wrapper to do that, then sshd would only be able to execute 
> the wrapper (and hopefully the vast majority of ssh exploits would then be 
> unable to affect us).

It sounds very much like a compromise between useability and security
here.

For instance, I might really want to login to a remote box and
run rm.

I might even want to do this as a non-interactive command.

In fact, my scripts I use to download BSTMP (batched SMTP) from
the Debian server do just this:

ssh -l$USER $HOST bin/downloadmail
rsync -essh -avz --progress $USER@$HOST:download/  $HOME/download
shopt -s nullglob
for i in *
do
        /usr/sbin/rbsmtp < $i
        rm $i
        ssh -l$USER $HOST rm -f download/$i
done

A better long term solution might be to somehow require the remote
host has a SPKI key or something (a public key can already be used to
limit what commands the remote host can execute, but that doesn't work
if sshd has been compromised) that somehow can be used to limit what
domains sshd can run. However, I have not put any thought into if this
is possible, practical or feasible.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
