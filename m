Content-Type: text/plain;
  charset="us-ascii"
From: Bill Laut <wlsel@verizon.net>
To: SELinux@tycho.nsa.gov
Subject: Q on the Constrain verb
Date: Tue, 19 Aug 2003 01:27:27 -0400
MIME-Version: 1.0
Message-Id: <200308190127.27853.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I'm writing up a .te file for the Tripwire suite.  I'd like the policy to 
distinguish between staff_r and sysadm_r, in that sysadm_r is given 
unrestricted access to create/modify the Tripwire policy, database, and 
local/site keys.  Staff_r (and initrc_t) are given read-only access to these 
files, so that automated nightly and/or staff security checks are not allowed 
to potentially alter the Tripwire database/policy.

I would like to use the constrain verb in my .te file to distinguish sysadm_r 
from all others, but when I do a "make reload" I get a syntax error on the 
constrain statement.  I've even gone so far as to quote the third example 
constrain statement (pg. 20, Sec. 4.5 of "Configuring the SELinux Policy") 
verbatim in my .te file, but it, too, generates a syntax error.

So, if I have (for example) an allow statement of the form:

   allow tripwire_t tripwire_cfg_t:file { create write read getattr };

How do I correctly syntax a constrain statement that will restrict the write & 
create permissions when the role is not sysadm_r?  And how do you connect a 
given constraint statement with a given target context?  For example, 
supposing that I have:

   allow tripwire_t tripwire_cfg_t:file { create write read getattr };
   allow tripwire_t tripwire_key_t:file { create write read getattr };
   allow tripwire_t tripwire_report_t:file { create write read getattr };

How do I syntax the constraint so that it constrains the cfg and key types but 
not the report type?  That linkage is not apparent in the documentation.

Thanks in advance.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
