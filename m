Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k05EbHXf017260
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 09:37:17 -0500 (EST)
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k05EbFWJ017054
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 14:37:15 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k05EbFbV021435
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 09:37:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k05EbEbC103430
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 09:37:14 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k05EbEb6018714
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 09:37:14 -0500
Date: Thu, 5 Jan 2006 08:37:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Crispin Cowan <crispin@novell.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
   linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
Message-ID: <20060105143713.GA23146@sergelap.austin.ibm.com>
References: <43B6C9E3.8020406@kaigai.gr.jp> <20060101192707.GA19487@sergelap.austin.ibm.com> <43BC6E97.4000209@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43BC6E97.4000209@novell.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Crispin Cowan (crispin@novell.com):
> Serge E. Hallyn wrote:
> > Hmm, a question on behavior.
> >
> > Let's say hallyn_t is allowed to write /var (var_t), but not to do
> > getattr on /var/secret_process_is_running (secret_t).  If hallyn_t
> > does ls /var/secret_process_is_running, he gets -ENOENT, but what
> > should he get if he does 'touch /var/secret_process_is_running'?
> > -EPERM obviously leaks information...
> >   
> If you create a file whose existence is supposed to be secret, and you
> put it in a public directory, then you have made a mistake, because the
> file's existence is always detectable.
> 
> Suppose we create file in /var/nothingtoseehere. The adversary can
> create any file they want, *except* for /var/nothingtoseehere, which
> will return some kind of error message (doesn't matter which error).
> From this, the attacker can infer the existence of the file, and its name.

Right.  Of course we could solve this with a custom polyinstantiated
filesystem, which might even be pretty simple to do as either a
stackable fs around a real one, or a userspace filesystem.  It would
simply create a new entry for /var/nothingtoseehere with the creator's
context, so that when a process in that context did ls /var, it would
see the new file.  I was wondering whether there are any other tricks
we could play.

Sounds like no  :)

And as you point out, if we don't solve this, there's no point returning
-ENOENT on ls /var.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
