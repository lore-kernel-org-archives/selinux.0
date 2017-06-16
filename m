Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5GCLVYm003979
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 08:21:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F535C04B945
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-227.rdu2.redhat.com
 [10.10.120.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 192C38B32C
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 12:21:26 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: Collecting ideas for audit2allow improvement
To: selinux@tycho.nsa.gov
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
 <1497450625.9239.6.camel@tycho.nsa.gov>
 <20170614143541.GB5298@julius.enp8s0.d30>
 <20170614144732.GC5298@julius.enp8s0.d30>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <340e54c1-3a75-a35f-09ca-d3f831aaa08f@redhat.com>
Date: Fri, 16 Jun 2017 08:21:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170614144732.GC5298@julius.enp8s0.d30>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/14/2017 10:47 AM, Dominick Grift wrote:
> On Wed, Jun 14, 2017 at 04:35:41PM +0200, Dominick Grift wrote:
>> On Wed, Jun 14, 2017 at 10:30:25AM -0400, Stephen Smalley wrote:
>>> On Wed, 2017-06-14 at 09:01 -0400, Jan Zarsky wrote:
>>>> Hi,
>>>>
>>>> I would like to improve SELinux audit2allow tool as my bachelor
>>>> thesis.
>>>> I collected ideas from my colleagues from RedHat SELinux team and I
>>>> would also
>>>> like to hear your ideas - what would you improve to make audit2allow
>>>> smarter or
>>>> easier to use.
>>>>
>>>> Ideas collected so far:
>>>>
>>>>    * offer dac_read_search when sufficient instead of dac_override
>>>>      (see <https://github.com/SELinuxProject/selinux/issues/31>)
>>> The hard part here is knowing when it is sufficient.  Might require
>>> further kernel patches to get to the point where it is completely
>>> unambiguous from the audit messages alone.  You could perhaps default
>>> to only allowing dac_read_search and only allow dac_override if you see
>>> that dac_read_search is already allowed and you are still getting a
>>> dac_override denial.
>> This should not be an issue anymore. Becuase now (linux v4.12) dac_read_search is first checked
>> so translating a rule for dac_read_search will always be the most secure option. It might not be enough but youll notice if it isnt. Just rerun it again and you'll end up with dac_override if needed.
>>
>>>>    * offer multiple solutions to a problem (example: 1) add allow rule
>>>> for
>>>>      execute + execute_no_trans or 2) add allow rule for execute
>>>>      + type_transition rule)
>>> Is this type_transition to an existing type that already exists, or
>>> defining a new type and transitioning to it, or both?  Generating new
>>> domains and types dynamically is one of the major gaps in current
>>> audit2allow, and to date has only been supported in separate tools like
>>> sepolicy generate.
>> One should be extremely careful here. "execute" does not automatically imply "execute_no_trans". That assumption can lead to disaster (https://www.cvedetails.com/cve/CVE-2015-1815/)
>>>>    * interactive mode: ask questions and choose best solution
>>>>    * warn when solution touches trusted computing base (rules you
>>>> should not be
>>>>      adding)
>>>>    * suggest alternate labels for content, example: httpd_t not
>>>> allowed to write
>>>>      to user_home_t, might suggest that changing the label to
>>>>      httpd_user_content_t
>>> This seems more along the lines of what setroubleshoot does, and tends
>>> to be policy-specific. We need to preserve the usability of audit2allow
>>> for other policies (e.g. Android, DSSP), so any policy-specific logic
>>> needs to be encapsulated, configuration-driven, and optional.
>> setroubleshoot is not smart enough to suggest httpd_user_content_t, instead it suggest you allow full access to /home/* by toggling the boolean that grants access to user home content.
>>
>> I know this from experience. There was a bug in fedora's apache_user_content_template for more than a year and hardly anyone noticed it, probably because setroubleshoot would have just suggested you allow full access to user home content.
> https://bugzilla.redhat.com/show_bug.cgi?id=1457406
I actually think the suggest a accessible type is  the best 
improvement.  audit2allow has defaulted for years to suggesting adding 
allow rules, usually the worst solution.  Later we added boolean 
support, which was better but as you point out the not a great solution 
in a lot of cases.  Most AVC's are caused by mislabeled files or 
processes.  Having audit2allow attempt to examine the policy and figure 
out which types would have been allowed with some simple sorting rules 
might be a big improvement.

Avc denying httpd_t ability to write to httpd_sys_content_t.

audit2allow should examine policy and figure out which domains httpd_t 
can write to with the current policy settings.  Then it should sort the 
solutions based on the characters of the sources context.  Perhaps 
chopping a characters off, maybe down to 3.

  sesearch -A -s httpd_t -p write -c | cut -f1 -d ":"  | cut -d" " -f 3 
| sort -u | grep httpd
httpd_cache_t
httpdcontent
httpd_lock_t
httpd_squirrelmail_t
httpd_sys_rw_content_t
httpd_t
httpd_tmpfs_t
httpd_tmp_t
httpd_user_rw_content_t
httpd_var_lib_t
httpd_var_run_t

Now eliminate the non file types, removes httpd_t.

That would give the user a much better chance of solving the problem 
without becoming policy specific.

Now if you wanted to become a little more smart, you could look at the 
second field of the label, and have a table that says "var" indicates 
the path begins with /var and "tmp" indicates a directory that ends with 
tmp.  But users could probably determine this.




Sort by types starting with httpd, http, htt
