Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8SHMrsJ008709
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2003 13:22:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8SHL6Zt019988
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2003 17:21:06 GMT
Received: from out001.verizon.net (out001pub.verizon.net [206.46.170.140])
	by jazzswing.ncsc.mil  with ESMTP id h8SHL6M3019985
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2003 17:21:06 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: russell@coker.com.au
Subject: Re: Emacs major mode for policy editing
Date: Sun, 28 Sep 2003 13:25:17 -0400
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <1064504193.3885.14.camel@moss-tarheels.epoch.ncsc.mil> <200309271624.17976.wlsel@verizon.net> <200309281343.23332.russell@coker.com.au>
In-Reply-To: <200309281343.23332.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200309281325.17196.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 27 September 2003 11:43 pm, Russell Coker wrote:
> On Sun, 28 Sep 2003 06:24, Bill Laut wrote:
>
> > That's also why I threw in the reference to "extra homework" in my
> > previous post.  For example, this could be a good excuse to go through
> > XFree86 and insure that there aren't any unrecognized buffer-overflow
> > vulnerabilities. It would be embarassing to say the least to release
> > SE-X, only to have it contain exploitable BO vulnerabilities--the very
> > thing that SELinux is advertised as protecting against.
>
> Absolutely!  However it should be noted that SE Linux has a very expressive
> configuration language which allows detailed control over what is allowed.
> If an administrator desires Back-Orifice access to their network then the
> Security Enhanced X configuration will surely allow them to enable it.
>

This is to clarify the paragraph that you commented upon.  When I used the 
term "BO" I was abbreviating my earlier usage of "buffer-overflow."  I 
recognize that BO is the common abbreviation for "Back Orifice, and therefore 
I should have used a more discriminating abbreviation.  Therefore, in the 
future when I abbreviate "Buffer-Overflow" I will use "BuOv."  

I agree with what you said about an administrator -overtly- desiring to enable 
a Back Orifice; there's no way to prevent it, and in fact it's not our place 
to tell them they can't.  Given its size and complexity, what I'm pondering 
is the potential for as-yet undetected BuOv vulnerabilities in the existing 
XFree86 code.  Obviously, an appropriate policy will fence in a compromised 
Xserver, so long as it wasn't installed SUID.  eg, the Request passes policy 
enforcement, only to then be dispatched into a module with an unforeseen BuOv 
that allows a malicious Xclient to compromise the Xserver (or another Xclient 
with a BuOv in Xlib that was installed SUID).  That's why I was wondering if 
it would be appropriate to inspect XFree86 for boundary checking of all 
incoming client messages.

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
