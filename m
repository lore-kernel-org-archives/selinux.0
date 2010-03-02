Message-ID: <4B8D4283.1060208@triagnosys.com>
Date: Tue, 02 Mar 2010 17:53:23 +0100
From: Ulrich Althaus <ulrich.althaus@triagnosys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: RHEL4 Selinux mailinglist
References: <4B8BDE81.7020800@triagnosys.com> <4B8BE693.8090304@redhat.com>	 <4B8BEB95.3070509@triagnosys.com> <1267474011.601.104.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267474011.601.104.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Am 01.03.2010 21:06, schrieb Stephen Smalley:
> On Mon, 2010-03-01 at 17:30 +0100, Ulrich Althaus wrote:
>>
>> Am 01.03.2010 17:08, schrieb Daniel J Walsh:
>>> On 03/01/2010 10:34 AM, Ulrich Althaus wrote:
>>>> Hi,
>>>>
>>>> if I have problems with telnet in RHEL4, which mailing list should I
>>>> write to?
>>>>
>>>> Regards
>>>> Ulrich
>>>>    
>>> Depends on what the problem is.  The official response probably would be
>>> open a bugzilla.  Or talk to your support person.
>>>
>>> What is the problem you are seeing?
>>>
>>
>> I have a RHEL4 Server on which I cannot execute telnet when being in
>> enforcing mode, while in permissive mode it works without any problems.
>> Plus I don't get any avc denies.
> 
> avc denials may be suppressed by dontaudit rules in the policy (used to
> silence denials that may occur normally due to harmless application
> probing).  Have you tried rebuilding your policy without dontaudit
> rules?
> 
> On RHEL4, that would look like:
> # requires selinux-policy-targeted-sources to be installed
> cd /etc/selinux/targeted/src/policy
> make enableaudit load
> 
> Then retry the operation and check again for avc messages
> in /var/log/messages or dmesg output.  There may be numerous unrelated
> avc messages that were previously silenced by dontaudit rules, so you
> need to look for ones that appear to be relevant to the operation in
> question.
> 
> When finished, restore your dontaudit rules via:
> cd /etc/selinux/targeted/src/policy
> make clean load
> 
> sestatus and pstree -Z output can often be helpful too when diagnosing
> problems.
> 
> References:
> Fedora Core 3 SELinux FAQ (RHEL 4 SELinux was very similar to Fedora Core 3), http://docs.fedoraproject.org/selinux-faq-fc3/
> RHEL 4 SELinux Guide, http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/
> 

I solved the problem by looking at dontaudits. In my case the telnet was
started from an expect script, which could not open a pty. So all I had
to do was add the following rule:

allow agscm_t devpts_t:chr_file { read write };

But it took me some hours to understand what expect is doing. :)

Thanks for your quick answers.
Regards,
Ulrich

-- 
-------------------------------------------------------------------------------------------------
Ulrich Althaus
TriaGnoSys GmbH
Argelsrieder Feld 22
D-82234 Wessling-Oberpfaffenhofen
Germany

Tel: +49 8153 88678-218
Fax:+49 8153 88678-1

email: Ulrich.Althaus@triagnosys.com
www: http://www.triagnosys.com
------------------------------------
TriaGnoSys GmbH, Registergericht: München HRB 141647, Vat. :DE 813396184
Geschäftsführer: Matthias Holzbock, Dr. Axel Jahn, Dr. Markus Werner

This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they are
addressed. If you are not the addressee or authorized to receive this
for the addressee, you must not use, copy, disclose or take any action
based on this message or any information herein. If you have received
this message in error, please advise the sender immediately by replying
to this e-mail and delete the material from any computer. Thank you for
your cooperation.
-------------------------------------------------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
