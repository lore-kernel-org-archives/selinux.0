In-Reply-To: <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "'James Morris'" <jmorris@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>, linux-audit@redhat.com,
   owner-selinux@tycho.nsa.gov, selinux@tycho.nsa.gov, selinux-dev@tresys.com,
   serue@us.ibm.com
MIME-Version: 1.0
Subject: RE: dcache_lock deadlock due to auditing
Message-ID: <OFDF15CCA8.BAE5D77A-ON87256FE3.00665060-86256FE3.006909E9@us.ibm.com>
From: Daniel H Jones <danjones@us.ibm.com>
Date: Thu, 14 Apr 2005 14:09:16 -0500
Content-Type: multipart/alternative; boundary="=_alternative 006909E786256FE3_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 006909E786256FE3_=
Content-Type: text/plain; charset="US-ASCII"

"SELinux
already provides hook functions for copying the contexts of processes
and files to buffers to support the /proc/pid/attr and xattr APIs, so
that audit framework can call those hooks and save that information for
"processing by audit_log_exit upon DAC denials as well.

I'm guessing the security context obtained from the SELinux hooks are  is 
represented by a sid.
Is this true? If that's the case, can it be readily converted to the 
string representation for display
at audit_log_exit time? 

Thanks,
Dan Jones
IBM Linux Technology Center, Security
danjones@us.ibm.com



Stephen Smalley <sds@tycho.nsa.gov> 
Sent by: owner-selinux@tycho.nsa.gov
04/14/2005 11:15 AM

To
Karl MacMillan <kmacmillan@tresys.com>
cc
serue@us.ltcfwd.linux.ibm.com, selinux@tycho.nsa.gov, "'James Morris'" 
<jmorris@redhat.com>, selinux-dev@tresys.com, linux-audit@redhat.com
Subject
RE: dcache_lock deadlock due to auditing






On Thu, 2005-04-14 at 12:06 -0400, Karl MacMillan wrote:
> Just to be clear, this decision is really to continue the movement away 
from avc
> messages being a complete source for audit message related to SELinux to 
both
> avc and syscall auditing being required to get a full picture. My sense 
is that
> this is the direction that things must go in for technical and political
> reasons, though I have to say that my preference would be (for what it's 
worth)
> for SELinux avc audit messages to be complete, self-contained, and be 
triggered
> even with DAC permissions deny access.

The SELinux avc audit messages will remain complete as far as having all
the information you need to tie it back to policy or generate policy
rules, i.e. the security contexts and class information.  The auxiliary
audit information (pid, exe, path, port, ipaddr, etc) has always just
been to help track down the causes of denials.  As far as being
triggered for DAC denials, that just isn't an option, as the LSM hooks
are placed after the DAC checks in most cases and won't be reached for
DAC denials.  That avoids filling the logs with MAC denials that would
have been denied due to DAC anyway (which is quite common due to
application and library probing of the environment) and doesn't leak
information (since both the DAC denial and the MAC denial yield the same
error code).  But if your real concern is capturing the relevant
security contexts upon a DAC denial, we can support that; SELinux
already provides hook functions for copying the contexts of processes
and files to buffers to support the /proc/pid/attr and xattr APIs, so
that audit framework can call those hooks and save that information for
processing by audit_log_exit upon DAC denials as well.

> At this point, my only real concern is that it be easier for users to 
get this
> information and I simply don't know enough about the audit 
infrastructure to
> know whether this will be the case or not. What kind of configuration 
will be
> required to get the additional syscall audit messages?

Boot your kernel with audit=1 or run auditctl -e 1 at any time.  That
enables syscall auditing.  Then, every time SELinux generates an audit
message via avc_audit, a syscall audit record will also be written at
syscall exit, and they can be tied together based on the
timestamp/serial number in the prefix.
 
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
with
the words "unsubscribe selinux" without quotes as the message.


--=_alternative 006909E786256FE3_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>&quot;SELinux<br>
already provides hook functions for copying the contexts of processes<br>
and files to buffers to support the /proc/pid/attr and xattr APIs, so<br>
that audit framework can call those hooks and save that information for<br>
&quot;processing by audit_log_exit upon DAC denials as well.</tt></font>
<br>
<br><font size=2 face="sans-serif">I'm guessing the security context obtained
from the SELinux hooks are &nbsp;is represented by a sid.</font>
<br><font size=2 face="sans-serif">Is this true? If that's the case, can
it be readily converted to the string representation for display</font>
<br><font size=2 face="sans-serif">at audit_log_exit time? </font>
<br>
<br><font size=2 face="sans-serif">Thanks,<br>
Dan Jones<br>
IBM Linux Technology Center, Security<br>
danjones@us.ibm.com</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Stephen Smalley &lt;sds@tycho.nsa.gov&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: owner-selinux@tycho.nsa.gov</font>
<p><font size=1 face="sans-serif">04/14/2005 11:15 AM</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td valign=top><font size=1 face="sans-serif">Karl MacMillan &lt;kmacmillan@tresys.com&gt;</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td valign=top><font size=1 face="sans-serif">serue@us.ltcfwd.linux.ibm.com,
selinux@tycho.nsa.gov, &quot;'James Morris'&quot; &lt;jmorris@redhat.com&gt;,
selinux-dev@tresys.com, linux-audit@redhat.com</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td valign=top><font size=1 face="sans-serif">RE: dcache_lock deadlock
due to auditing</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>On Thu, 2005-04-14 at 12:06 -0400, Karl MacMillan
wrote:<br>
&gt; Just to be clear, this decision is really to continue the movement
away from avc<br>
&gt; messages being a complete source for audit message related to SELinux
to both<br>
&gt; avc and syscall auditing being required to get a full picture. My
sense is that<br>
&gt; this is the direction that things must go in for technical and political<br>
&gt; reasons, though I have to say that my preference would be (for what
it's worth)<br>
&gt; for SELinux avc audit messages to be complete, self-contained, and
be triggered<br>
&gt; even with DAC permissions deny access.<br>
<br>
The SELinux avc audit messages will remain complete as far as having all<br>
the information you need to tie it back to policy or generate policy<br>
rules, i.e. the security contexts and class information. &nbsp;The auxiliary<br>
audit information (pid, exe, path, port, ipaddr, etc) has always just<br>
been to help track down the causes of denials. &nbsp;As far as being<br>
triggered for DAC denials, that just isn't an option, as the LSM hooks<br>
are placed after the DAC checks in most cases and won't be reached for<br>
DAC denials. &nbsp;That avoids filling the logs with MAC denials that would<br>
have been denied due to DAC anyway (which is quite common due to<br>
application and library probing of the environment) and doesn't leak<br>
information (since both the DAC denial and the MAC denial yield the same<br>
error code). &nbsp;But if your real concern is capturing the relevant<br>
security contexts upon a DAC denial, we can support that; SELinux<br>
already provides hook functions for copying the contexts of processes<br>
and files to buffers to support the /proc/pid/attr and xattr APIs, so<br>
that audit framework can call those hooks and save that information for<br>
processing by audit_log_exit upon DAC denials as well.<br>
<br>
&gt; At this point, my only real concern is that it be easier for users
to get this<br>
&gt; information and I simply don't know enough about the audit infrastructure
to<br>
&gt; know whether this will be the case or not. What kind of configuration
will be<br>
&gt; required to get the additional syscall audit messages?<br>
<br>
Boot your kernel with audit=1 or run auditctl -e 1 at any time. &nbsp;That<br>
enables syscall auditing. &nbsp;Then, every time SELinux generates an audit<br>
message via avc_audit, a syscall audit record will also be written at<br>
syscall exit, and they can be tied together based on the<br>
timestamp/serial number in the prefix.<br>
 <br>
-- <br>
Stephen Smalley &lt;sds@tycho.nsa.gov&gt;<br>
National Security Agency<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br>
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br>
</tt></font>
<br>
--=_alternative 006909E786256FE3_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
