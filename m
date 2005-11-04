Subject: Re: [ SEMANAGE 4 ] Copyright
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <436B0D46.9050102@cornell.edu>
References: <436B0D46.9050102@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 10:14:15 -0500
Message-Id: <1131117255.23420.259.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 02:27 -0500, Ivan Gyurdiev wrote:
> Changes:
> 
> - Add Red Hat's copyright notice to all code that I've changed... (is 
> this done properly?)

You likely want to note the license as well; see the other files.  You
can also refer to the COPYING file that is included with the library,
which contains the full text of the license.  I'm not sure it serves any
purpose to put the copyright and/or license on the public headers of the
library, as it is really only applicable to the implementation IIUC, but
I'm not a lawyer ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
