Subject: Re: su and context
From: Ronan Waide <waider@amazon.com>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <200702151843.50749.russell@coker.com.au>
References: <45CDEDEE.4050205@gmail.com>
	 <1171301899.20328.29.camel@waider.desktop.amazon.com>
	 <1171303155.24318.12.camel@moss-spartans.epoch.ncsc.mil>
	 <200702151843.50749.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1171620393.23455.2.camel@waider.desktop.amazon.com>
Mime-Version: 1.0
Date: Fri, 16 Feb 2007 10:06:33 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 07:43, Russell Coker wrote:
> As a tangent to this, you should be able to just use chown and chmod to make 
> rndc usable by non-root.  rndc in recent versions of bind just seems to need 
> to read the key file - which could be made readable by non-root.

Oh yeah, that's what I've done - to the extent that I've an RPM trigger
that will fix the permissions on the file if I upgrade bind. The default
ISC installation doesn't lock the binary down in this way (and it makes
little sense; the binary's not setuid, and you could simply copy in a
binary from another machine if your target machine were in a non-selinux
environment) so I guess I should take it up with the Fedora packagers.
The key is actually in a different context, too, so you can block access
to it through SELinux.

Cheers,
Waider.
-- 
Ronan Waide / TechOps EU Systems Engineer / waider@amazon.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
