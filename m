Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6JvISf019895
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 14:57:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA6Jup1W028784
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 19:56:51 GMT
Received: from out008.verizon.net (out008pub.verizon.net [206.46.170.108])
	by jazzswing.ncsc.mil  with ESMTP id hA6Juo5e028781
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 19:56:50 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Subject: Re: XWindows, trust, EROS
Date: Thu, 6 Nov 2003 14:56:13 -0500
References: <20031106065548.GA6956@snoopy.apana.org.au>
In-Reply-To: <20031106065548.GA6956@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200311061456.13441.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thank you for mentioning EROS.  Speaking for myself, unfortunately I don't see 
a connection between EROS and SE-X.  The problem we face is how to 
communicate the Xclient's security context to the Xserver in a trustworthy 
manner, so that the Xserver can determine what access, if any, to grant the 
Xclient.  Based on the reference you cited, it appears that EROS actively 
integrates the client in the security process.  This is anathema to the 
classic compartmentalized, "need to know" paradigm SELinux embraces (the 
obvious exception, of course, being security-aware apps).

Additionally, because of its design EROS appears to require more "baggage" 
than the straightforward, minimally-intrusive X security extension that Eamon 
correctly advocated for SELinux.

When dealing with local Xclients (eg, the client and server are running in the 
same box), the problem for SELinux is trivial because everything can be done 
without the Xclient's knowledge nor involvement.  Ergo, because there's no 
client involvement, there is nothing exposed that a malicious (whether 
explicitly or via an exploited buffer-overflow vulnerability) client could 
exploit to leverage further access into the OS.

Remote Xclients introduce a problem in that to enforce the existing  
compartmentalized model a secure channel is needed for the client SELinux 
kernel to convey the Xclient's security context to the Xserver's SELinux 
kernel or equivalent (and from whom the XServer obtains it), and in such a 
way that the Xclient has no exploitable facility by which to spoof the 
Xserver. 

The definition of a "secure channel" here is pretty open-ended, and could 
range from a default policy setting, to a separate encrypted TCP stream, 
labeled networking, IP encapsulation / tunneling, and/or to a separate 
physical network.  It could also combine one or more of these elements, along 
with others not yet envisioned.  It's still very much a moving target, and is 
something I'm working to identify so that I can post the results here and ask 
for a consensus on which approach should be adopted.

Furthermore, the solution is not necessarily limited to only X, and so I'm 
resisting the temptation to make it X-centric.

Bill

On Thursday 06 November 2003 01:55 am, Brian May wrote:
> Hello,
>
> For some reason I thought EROS was dead, but the mailing lists
> seem to be strong...
>
> Anyway, here is a discussion on X-Windows, trusted windows,
> untrusted windows, etc, which may/may not have implications here for
> people interested in using SE-Linux to limit access to "dangerous"
> X-Windows operations.
>
> http://www.eros-os.org/pipermail/eros-arch/2003-November/003849.html
>
> (Note: I haven't read this thread in detail myself yet).
>
> (Note2: I apologize if this is already common knowledge or totally
> irrelevant...)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
