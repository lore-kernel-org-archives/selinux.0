Message-ID: <72222DC86846D411ABD300A0C9EB08A10152433C@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Howard Holm
	 <hdholm@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Tom <tom@lemuria.org>,
        SELinux@tycho.nsa.gov
Subject: RE: db conflict ?
Date: Fri, 12 Apr 2002 12:26:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since you must create ...security why on the top
of every file system why not put it in there ?



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tislabs.com]
> Sent: Friday, April 12, 2002 12:13 PM
> To: Howard Holm
> Cc: Russell Coker; Tom; SELinux@tycho.nsa.gov
> Subject: Re: db conflict ?
> 
> 
> 
> On Fri, 12 Apr 2002, Howard Holm wrote:
> 
> > I think adding a magic number to the policy file is 
> probably a good idea.
> > I'm not quite as sure about the file name containing a 
> version number, but
> > it's probably a good idea as well.  My reading of the FHS 
> (v2.2) is that
> > it prohibits /selinux/.  My suggestion would be 
> /etc/security/policy/ or
> > /etc/security/policies/ with the thought that there might 
> be at least
> > multiple versions in the directory so plural might be appropriate.
> 
> I primarily want to keep it separate from the policy sources 
> (/etc/selinux
> in Russell's Debian package), yet clearly identified as being
> selinux-specific.  It also needs to stay within the root filesystem,
> although that isn't a problem regardless of whether we go 
> with /selinux or
> /etc/security/selinux or /etc/selinux/policy as the subdirectory name.
> The name for the file itself can be reduced to policy.VERSION 
> once it is
> in a selinux-specific directory (the ss_ prefix was just to avoid
> conflicts with other potential non-SELinux policy files, ss 
> == security
> server).
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 
> 
> --
> You have received this message because you are subscribed to 
> the selinux list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
