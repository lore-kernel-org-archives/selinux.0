Date: Fri, 18 Mar 2005 09:35:12 +0100
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: Do you trust X server?
Message-ID: <20050318093512.E5491@lemuria.org>
References: <200503172228.AA00008@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200503180526.j2I5Q5OP012774@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503180526.j2I5Q5OP012774@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Mar 18, 2005 at 12:26:04AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 18, 2005 at 12:26:04AM -0500, Valdis.Kletnieks@vt.edu wrote:
> For a remote exploit of the X server itself, you'd have to find a way to
> exploit the X protocol, 

Not true.

This was 2002, and it was a DoS, but it shows that the X server can be
attacked through remote applications:

http://web.lemuria.org/security/mozilla-dos.html

The short: A font-rendering bug in X can cause a system freeze if mozilla
is instructed to render a huge (like 1666666 pixels) font.


Don't trust X. Microsoft made the mistake of trusting the GUI system,
and we all know what shatter attacks are, don't we?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
