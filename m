Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7U1BRLa000332
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 21:11:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7U1BNet006388
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 01:11:23 GMT
Received: from out002.verizon.net (out002pub.verizon.net [206.46.170.141])
        by jazzband.ncsc.mil  with ESMTP id h7U1BKlq006379 for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 01:11:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
Subject: Re: Type background of SELinux
Date: Fri, 29 Aug 2003 21:12:31 -0400
Cc: selinux@tycho.nsa.gov
References: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3563@etsuex1.etsu.edu> <1062188749.5432.223.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1062188749.5432.223.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200308292112.31652.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 August 2003 04:25 pm, Stephen Smalley wrote:
> On Fri, 2003-08-29 at 15:57, Jenkins, Steven wrote:
> > "... TE allows the relationship between a subject and its executable to
> > be tightly controlled, enabling protection based on the function and
> > trustworthiness of code and offering protection against the execution of
> > malicious code."
> >
> > It's not immediately clear to me how much of a role types really play in
> > achieving this protection (beyond a very simple static type check).
> > Also, it's not clear to me how rich of a type system is actually
> > necessary -- is there a more formal definition of the type system
> > somewhere?
>
> A "type" in TE is simply a security equivalence class for objects; all
> objects with the same security properties have the same type.  You could
> just as easily refer to it as a "security tag" or "security label".   TE
> is simply "the Lampson access matrix organized into equivalence classes
> for efficiency", as stated by Earl Boebert.  The security policy writer
> can define types to represent specific functional and integrity
> properties of executables, label the executables with these types, and
> define policies over the ability to execute from these types.
>

I've been asked this same question, especially by non-technical people, while 
trying to explain the advantages of a MAC approach as found in SELinux.  A 
useful metaphor I discovered goes as follows:  The resources of a typical OS 
are offered much like a "smorgasbord" from which the application is free to 
pick and choose.  Discretionary Access Controls (DACs), such as protection 
masks on files, etc., offer some limited protection but historically are no 
match against a determined attacker because they are either too 
coarsely-grained to be effective and/or were designed to keep out individuals 
who respect their boundaries, etc.  Furthermore, as applications and their 
usage become more sophisticated and intertwined, unforeseen "paths" can be 
discovered that allow an attacker to traverse from one path to another (like 
exploring a maze) until they finally achieve root access to the system.

SELinux approaches this problem by implementing a fine-grained MAC paradigm 
that allows the Security Administrator to exactingly "tailor" which system 
resources any given application is allowed to access in its -expected- 
execution.  To wit, instead of offering a nearly-unregulatable "smorgasbord" 
of system resources the application now operates within a security domain 
that can be custom-fitted to it like a hand in a glove.

In its expected execution the application will operate as it normally does.  
But should the application somehow be compromised, any attempt by a malicious 
entity to leverage further access into the system is blocked.  Furthermore, 
because the compromised application is now generating unexpected security 
audits, these very audits can serve as a "tripwire" to alert the Security 
Administrator that a potential breach has been committed that may warrant an 
investigation as to their source.

Let's consider a simple example:  Let's pretend that I'm authoring a bid 
proposal using StarOffice that a competitor wants a copy of.  I agressively 
program NetFilter to block all incoming TCP/UDP traffic, so there's no way 
the competitor could directly steal my proposal by accessing a listening 
daemon on my computer.  However, this competitor is resourceful enough to 
identify my ISP and ascertain what email client I'm using to get my email.  
The competitor then develops a buffer-overflow attack against my email client 
and then compromises my ISP's POP3 server in order to plant this attack.

When I run my email client to retrieve any email, the firewall dutifully opens 
a hole for the client to access the server, and through that open hole the  
compromised POP3 server launches its BO against my client.  My client is now 
penetrated, and before I know what has happened the BO's payload uploads 
through the hole a program which it then clones to begin searching for all 
StarOffice documents on my system.  It finally finds the target, and creates 
another out-going connection through the firewall to send it onto the 
Internet.  If the attacker is resourceful enough, it transmits the document 
as a series of UDP datagrams to nonsensical destination IP addresses that 
will route the packets over network segments that the competitor has 
packet-sniffers on.  The packets end up being rejected or dropped by the 
destination hosts, but they were intercepted by the sniffers who in turn 
encrypt the contents to make them unrelated to the pilfered data before 
forwarding them onto their final destination.  This is the cyber equivalent 
of the classic "dead-drop," and done properly is completely untraceable.

Where SELinux is useful is that I can configure the policy to give StarOffice 
exclusive ownership of its data files, or at least to block my email client 
from accessing them.  Thus, should a malicious POP3 server compromise my 
email client with a buffer overflow, when the BO payload tries to access 
anything outside of the email client's domain it is pre-emptively blocked, 
plus I am notified that an unauthorized access took place giving me an 
important "head's up" that someone has taken an "unhealthy interest" in my 
computer and its contents.


Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
