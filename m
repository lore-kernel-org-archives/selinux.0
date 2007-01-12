Message-ID: <45A6D0A1.6020301@us.ibm.com>
Date: Thu, 11 Jan 2007 18:04:49 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Klaus Weidner <klaus@atsec.com>
Subject: Re: [RFC] clarifications for -l to newrole.1
References: <45A6A064.2040707@us.ibm.com> <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-01-11 at 14:39 -0600, Michael C Thompson wrote:
>> Based on some discussion from irc and some complaints I have received,
>> I'm proposing this addition (comments or other suggestions welcome) to
>> the newrole manage. This example section would slot in right after the
>> DESCRIPTION section. Patch below.
>>
>> EXAMPLE
>>         Changing sensitivity only:
>>            # id -Z
>>            user:role:type:SystemLow-SystemHigh
>>            # newrole -l Unclassified
>>            # id -Z
>>            user:role:type:Unclassified-SystemHigh
> 
> How does SystemLow differ from Unclassified here (in meaning, not just
> value)?  If SystemLow is supposed to be a special label for system
> objects, then why have users login at that level at all?
> 
>>         Changing sensitivity and clearance:
>>            # id -Z
>>            user:role:type:SystemLow-SystemHigh
>>            # newrole -l Unclassified-Unclassified
>>            # id -Z
>>            user:role:type:Unclassified-Unclassified
> 
> When would you envision a user doing the above?  Trying to ensure that
> any process he subsequently starts cannot escalate to higher levels?
> 
> If you are going to provide an example, use real output (i.e. not just
> user:role:type).  Please include an example of changing roles too since
> that is more common.  Also, fix the SEE ALSO list please (runas ->
> runcon, and drop su as it is no longer relevant).
> 
> AUTHORS list is also badly out of date there.  Let's see...you, Dan
> Walsh, Steve Grubb, and Darrel Goeddel should likely be added, and while
> the earlier authors should be retained, their email addresses are
> obsolete and should be dropped.

Based on the above comments, this is the patch, rehashed.

Thanks,
Mike

---

--- newrole.1.orig      2007-01-11 14:24:51.000000000 -0600
+++ newrole.1   2007-01-11 17:57:06.000000000 -0600
@@ -57,16 +57,45 @@
  .B --version
  shows the current version of newrole
  .PP
+.SH EXAMPLE
+.br
+Changing role:
+   # id -Z
+   staff_u:staff_r:staff_t:SystemLow-SystemHigh
+   # newrole -r sysadm_r
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:SystemLow-SystemHigh
+
+Changing sensitivity only:
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
+   # newrole -l Secret
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Secret-SystemHigh
+
+.PP
+Changing sensitivity and clearance:
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
+   # newrole -l Secret-Secret
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Secret
+
  .SH FILES
  /etc/passwd - user account information
  .br
  /etc/shadow - encrypted passwords and age information
+.br
+/etc/selinux/<policy>/contexts/default_type - default types for roles
+.br
  .SH SEE ALSO
-.B su
-(1),
-.B runas
+.B runcon
  (1)
  .SH AUTHORS
  .nf
-Tim Fraser (tfraser@tislabs.com)
-Anthony Colatrella (amcolat@epoch.ncsc.mil)
+Dan Walsh <dwalsh@redhat.com>
+Steve Grubb <sgrubb@redhat.com>
+Darrel Goeddel <DGoeddel@trustedcs.com>
+Michael Thompson <mcthomps@us.ibm.com>
+Tim Fraser
+Anthony Colatrella


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
