Subject: Re: Questions about security object classes and access vectors.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040220154134.55405.qmail@web41305.mail.yahoo.com>
References: <20040220154134.55405.qmail@web41305.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1077293140.4417.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Feb 2004 11:05:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-20 at 10:41, Park Lee wrote:
> Dear sir,
> I want to learn more about security object classes and access vectors.
> Would you please tell me where I could get the detailed information
> about every security object class and every permission in access
> vectors.(e.g. their descriptions,their functions,etc). 

Unfortunately, none of the existing documentation is entirely up-to-date
(John just lamented that fact).  But you can still learn quite a bit
from the existing technical reports. 
http://www.nsa.gov/selinux/slinux-abs.html is the design and
implementation report for the original SELinux kernel patch; it includes
descriptions of the classes and permissions, describes the set of
permission checks for each system call, and describes where the
permission checks were originally implemented in the Linux kernel. 
http://www.nsa.gov/selinux/module-abs.html is the implementation report
for the old LSM-based SELinux; it describes changes in permissions from
the original SELinux and describes where the permission checks were
implemented in each of the LSM hook functions.  Further controls have
been added since the time of these reports, and the networking controls
have been overhauled.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
