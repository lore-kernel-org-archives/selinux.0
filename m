Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03175
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 16:31:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA17158
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 21:30:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA17154 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 21:30:06 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: invalid contaxt
Date: Wed, 6 Mar 2002 22:30:50 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203061422310.15401-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203061422310.15401-100000@raven>
MIME-Version: 1.0
Message-Id: <20020306213051.1239F1EEA2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Mar 2002 20:34, Stephen Smalley wrote:
> > What am I doing wrong?
>
> Look for a message in the log of the form:
> 	security_compute_sid:  invalid context %s for scontext=%s tcontext=%s
> tclass=%s
>
> When in permissive mode, the kernel will log such a message but permit the
> SID to be created anyway.  Then, on subsequent policy reloads, you'll get
> another warning about the context (as in your message) being invalid.
>
> sysadm_ssh_t is a domain entered when a sysadm_t process runs the ssh
> program.  The example policy only authorizes the sysadm_r role for this
> domain, since ssh is typically run from a user session whose user identity
> and role have been set by login (or sshd).  If you ran ssh from a
> single-user shell or you aren't using a modified login/sshd, then you'll
> still have the system_u:system_r user identity and role, so you'll get
> this error.

Thanks for that.  The log messages made it clear what was going wrong.

I have inetd binding some ports to localhost and running ssh to forward 
connections to my server.

I'll change my sysadm_r appropriately.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
