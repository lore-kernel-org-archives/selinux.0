Message-Id: <200212022037.PAA25379@moss-shockers.ncsc.mil>
Date: Mon, 2 Dec 2002 15:37:11 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Errors in SELinux compile
To: SELinux@tycho.nsa.gov, Alexander.Michael@HILL.af.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> While trying to build the SELinux kernel (2.4.19) I have a couple of errors
> pop up.  Here were the steps I used to install the kernel:

>From what source?  Are you using the last public release (2002102211) from 
www.nsa.gov/selinux?  Or the CVS tree from sourceforge [and if so,
when did you last update/checkout]?  Did you successfully apply the 
SELinux-specific patch (cd selinux/module && make insert)?

> namei.c: In function 'getname':
> namei.c: 142: (Each undeclared identifier is reported only once
> namei.c: 142: for each function is appears in.)
> namei.c: 142: warning: passing arg 2 of pointer to function from
> incompatible pointer type
> make[2]: *** [namei.o] Error1

Can you show the actual offending line from namei.c?  And it looks like
you are missing some of the error message.

> Are these errors critical to the install?  I just wanted to make sure before
> I finished the install and found out I needed to change some other option in
> one of my files.

Yes, that would be a fatal error above.  You have to successfully build
the new kernel to install SELinux.

> Also, as I am installing on RedHat 8.0, what option do I need to set my
> LOGROTATE_VAR definition to?

If you just want to try it out, you can use the RH7.2 base version
(3.5.9).  We don't presently provide patched utilities/daemons based on the 
RH8.0 base sources, and updating the utility/daemon patches is not a high 
priority for us, as explained on the NSA web site.  If you want newer
base versions, you might try Russell Coker's patches from 
www.coker.com.au/selinux, but be aware that they are for his Debian selinux 
package and might require a little tweaking for RH.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
