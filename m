Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Date: Wed, 30 Jul 2003 18:03:29 -0400
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
In-Reply-To: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200307301803.29302.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 11 July 2003 03:41 pm, Howard Holm wrote (in part):
>
> [...]
>
> A report, "Securing the X Window System with SELinux" was added to
> documentation discussing adding SELinux controls to the window system.
>

In addition to the other excellent items he mentioned, this line in Howard's 
announcement especially picqued my interest.  Recently I've been observing a 
cracker breaking into my honeypot by presumably compromising an email server 
I access in order to exploit a buffer overrun in KMail to then launch a 
buffer overrun in XFree86, so s/he can then insert spyware into the running 
kernel.  I qualify this statement because the cracker was leaving artifacts 
on my system but I didn't want to do anything that would let them know that I 
was onto their presence.

This leads me to the question:  While considerable work has been done to 
protect the system from server app compromises, what about protecting the 
system from server-based buffer overrun attacks on clients running under 
SELinux?

Also, is there a way to add types to each of the security services, so that 
compromised network clients can be blocked from becoming "security-aware?"  
For example, let's say I'm running KMail to retrieve my email from a 
latently-malicious email server.  It uses a buffer overrun to compromise my 
email client in order to then probe my security policy by attempting to 
invoke the various security system services and measure the results they 
return (whose summary results are then networked back out to a server 
somewhere on the 'Net).

For those network clients that have no reason to be security-aware, would it 
seem reasonable to audit and/or block their invocation of security system 
services as a possible probe by a compromised client?

Finally, it seems to me that filtching stored email would be a favorite target 
of industrial spies.  Accordingly, I was thinking that some sort of optional 
external abstraction (like, say, a PDA running an appropriate security app) 
might be useful for authorizing access to email files on a per-request basis.  
For example, if you wished to run your favorite email client you would first 
have to run an appropriate security app on your PDA, which then connects via 
the hotsync cradle to SELinux.  Then, as you access your email folders and/or 
Address Book, avc then asks the PDA app (as a trusted third party) whether or 
not to conditionally allow that access to occur.  In practice, the PDA would 
beep and then display a question concerning the access, which the user then 
taps the "allow" or "deny" buttons to resolve.  Should a malicious server 
then compromise the user's email client in order filtch his/her stored email, 
the user will immediately be alerted to this condition by the PDA beeping 
when no such email access should be occuring.  Appropriately, since the 
compromised email client will be patiently waiting for the fopen() service to 
complete, the security kernel would be able to preserve the client's stack 
for later analysis.

Would anyone care to comment on or critique these ideas?  Please pardon me in 
advance if some of the questions seemed obvious, as per my habit I was 
"thinking out loud" while typing them in.

Bill



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
