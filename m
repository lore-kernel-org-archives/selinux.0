Subject: Re: RHEL4 Selinux mailinglist
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ulrich Althaus <ulrich.althaus@triagnosys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4B8BEB95.3070509@triagnosys.com>
References: <4B8BDE81.7020800@triagnosys.com> <4B8BE693.8090304@redhat.com>
	 <4B8BEB95.3070509@triagnosys.com>
Content-Type: text/plain
Date: Mon, 01 Mar 2010 15:06:51 -0500
Message-Id: <1267474011.601.104.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-03-01 at 17:30 +0100, Ulrich Althaus wrote:
> 
> Am 01.03.2010 17:08, schrieb Daniel J Walsh:
> > On 03/01/2010 10:34 AM, Ulrich Althaus wrote:
> >> Hi,
> >>
> >> if I have problems with telnet in RHEL4, which mailing list should I
> >> write to?
> >>
> >> Regards
> >> Ulrich
> >>    
> > Depends on what the problem is.  The official response probably would be
> > open a bugzilla.  Or talk to your support person.
> > 
> > What is the problem you are seeing?
> > 
> 
> I have a RHEL4 Server on which I cannot execute telnet when being in
> enforcing mode, while in permissive mode it works without any problems.
> Plus I don't get any avc denies.

avc denials may be suppressed by dontaudit rules in the policy (used to
silence denials that may occur normally due to harmless application
probing).  Have you tried rebuilding your policy without dontaudit
rules?

On RHEL4, that would look like:
# requires selinux-policy-targeted-sources to be installed
cd /etc/selinux/targeted/src/policy
make enableaudit load

Then retry the operation and check again for avc messages
in /var/log/messages or dmesg output.  There may be numerous unrelated
avc messages that were previously silenced by dontaudit rules, so you
need to look for ones that appear to be relevant to the operation in
question.

When finished, restore your dontaudit rules via:
cd /etc/selinux/targeted/src/policy
make clean load

sestatus and pstree -Z output can often be helpful too when diagnosing
problems.

References:
Fedora Core 3 SELinux FAQ (RHEL 4 SELinux was very similar to Fedora Core 3), http://docs.fedoraproject.org/selinux-faq-fc3/
RHEL 4 SELinux Guide, http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
