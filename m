Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k840fW4o020090
	for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2006 20:41:32 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k840ejN9012436
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 00:40:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
Subject: Re: Limitation of damages
Date: Mon, 4 Sep 2006 10:41:08 +1000
Cc: selinux@tycho.nsa.gov
References: <BAY114-F8E865C1A9A150F1B9063BAF320@phx.gbl>
In-Reply-To: <BAY114-F8E865C1A9A150F1B9063BAF320@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609041041.10348.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 04 September 2006 05:09, "Salvo Giuffrida" <giuffsalvo@hotmail.it> 
wrote:
> Hello, I have a doubt about the limitation of damanges in the event of a
> buffer overflow (or some kind of similar attack): If I have a program which
> runs as "root" (because it has the setuid flag), and it is compromised, the
> damage is still contained to the domain of the running program, right?

Correct.

> But, 
> if for example I execute a shellcode which opens a shell, could I do a
> 'newrole -t unconfined_t' or to wathever domain I want to inflict damage
> to?

In some unlikely situations yes (only if the daemon domain can transition to 
newrole_t and if the further domain transition that is requested is 
permitted).  I don't think that any released policy permits a daemon domain 
to run newrole in such a manner.  But even if that is permitted the attacker 
would still need to meet the PAM requirements for running newrole, which by 
default means entering the password of the identity in question.  If the 
attacker knows that password then they will probably be able to just login to 
the system.

> Can I limit this changes of domain? 

That is already limited by policy.

> I have another question: I have a SELinux machine, which has only the
> binary policy file, so there's no way an intruder can modify the policy
> sources to weaken the security of the system,

Wrong.  An attacker can edit the binary policy file, change the kernel binary, 
or change the filesystem image on disk.  Domains that are permitted to change 
the policy binary are permitted to do most things.  Generally if the attacker 
has write access to the policy binary then you have already lost.

> recompile them and reload 
> them...But what if the intruder create a very lazy security policy on
> his/her computer, recompile it, and then upload the binary policy file to
> the compromised system, so that this gets a weakened security policy?

Sure.  But if they are permitted to write to the policy binary then they are 
also permitted to put SE Linux in permissive mode which is a lot more 
convenient for the attacker.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
