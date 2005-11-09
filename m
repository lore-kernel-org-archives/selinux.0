Subject: Re: Using SElinux on OS X tiger
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Walter Steenvoorden <walter.steenvoorden@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E9BEDFF7-8CC3-4EAA-A08E-D138498855F7@gmail.com>
References: <E9BEDFF7-8CC3-4EAA-A08E-D138498855F7@gmail.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 08:44:42 -0500
Message-Id: <1131543882.20591.471.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-11-06 at 13:28 +0100, Walter Steenvoorden wrote:
> Hi everyone,
> 
> I've been using SELinux on my redhat server for some time now, and i  
> wonder how are the expierences implementing it into a distribution of  
> the Mac OS X? I run 10.4.3 on a G4 iBook and i want to know if its  
> possible to use SEPOL on the following
> - SSL keychain managment
> - Apple filevault
> - system prefs
> 
> Any expierences shared would be greatly apprieciated

There is a port of SELinux to FreeBSD (SE-BSD) and ongoing work to port
it to Darwin and MacOS X, but it isn't included in the mainline Mac OS
X.  See
http://www.trustedbsd.org/sebsd.html
http://www.trustedbsd.org/sedarwin.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
