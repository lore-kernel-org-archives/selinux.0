Message-ID: <20050318162144.32437.qmail@web50202.mail.yahoo.com>
Date: Fri, 18 Mar 2005 08:21:44 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Do you trust X server?
To: Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Tom <tom@lemuria.org> wrote:
> On Fri, Mar 18, 2005 at 12:26:04AM -0500,
> Valdis.Kletnieks@vt.edu wrote:
> > For a remote exploit of the X server itself, you'd
> have to find a way to
> > exploit the X protocol, 
> 
> Not true.

Let us be clear. The X consortium has always
made it plain the the X server provides mechanism,
not policy. You can trust the X server to the same
degree you can trust any part of the system that
does not implement or enforce policy. If you
chose to use the X server as a component of
your policy enforcement that is your affair,
but the appropriate use of that code is your
responsibility, not that of the X server.

> This was 2002, and it was a DoS, but it shows that
> the X server can be
> attacked through remote applications:
> 
> http://web.lemuria.org/security/mozilla-dos.html
> 
> The short: A font-rendering bug in X can cause a
> system freeze if mozilla
> is instructed to render a huge (like 1666666 pixels)
> font.

There are bugs in code that provides mechanism.
The security consequences of these problems are
one reason why systems are evalauted as a whole,
not by their individual components.

> Don't trust X.

The case mentioned above requires breakdowns
in the browser, font manager, and system admin.
None of these are X server problems. Further,
the "system" is not damaged at all. The DoS
"attack" is a programming flaw, or "bug" in
the jargon.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
