Message-ID: <550326BD.10207@tycho.nsa.gov>
Date: Fri, 13 Mar 2015 14:04:45 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Higgs, Stephen" <Stephen.Higgs@icfi.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: selinux category relabel (puppet)
References: <2409d98630af4bc39108524e04557017@VNUCITEX02.ICFI.icfconsulting.com>
 <55032105.1030903@tycho.nsa.gov>
 <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
In-Reply-To: <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2015 01:52 PM, Higgs, Stephen wrote:
>> On 03/13/2015 09:52 AM, Higgs, Stephen wrote:
>>> Hello all,
>>>
>>>
>>>
>>> If there is a more appropriate forum for this question please let me know:
>>>
>>>
>>>
>>> I have a system that uses confined users by default and some files are
>>> managed by a puppet server.  When I run (via run_init) the puppet
>>> startup script, I get the following avc log:
>>>
>>>
>>>
>>> avc: denied { relabelto } for pid=30707 comm="puppet" name="crl.pem"
>>> dev=dm-1 ino=527257 scontext=system_u:system_r:puppet_t:s0
>>> tcontext=system_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=file
>>>
>>> I added "typeattribute puppet_t can_change_object_identity" and
>>> appropriate "allow" statements to the puppet_t type after reading the
>>> constraints in the targeted policy. However, it was the category
>>> "s0:c0.c1023" that was also preventing puppet from relabeling the
>>> crl.pem file.
>>>
>>> I was able to fix this by manually relabeling the file to "s0" instead
>>> of "s0:c0.c1023". My question is, how *should* I handle this so puppet
>>> can handle the relabel of the category?
>>
>> It requires an appropriate attribute for the mcs or mls constraint that is
>> blocking access.  Which attribute depends on your policy; MCS in particular has
>> changed a lot over time in Fedora and RHEL.  What distro & version?
>>
> 
> I'm using CentOS / RedHat 6.6, targeted reference policy 24.

Hmmm...looking at selinux-policy-3.7.19-260.el6.src.rpm,
serefpolicy-3.719/policy/mcs has this:

# New filesystem object labels must be dominated by the relabeling subject
# clearance, also the objects are single-level.
mlsconstrain file { create relabelto }
        (( h1 dom h2 ) and ( l2 eq h2 ));

So no attributes are exempted from that constraint; your only option is
to run puppet ranged (i.e. as system_u:system_r:puppet_t:s0-s0:c0.c1023)
so that its high level dominates any potential file level.

You should be able to do that with a range_transition rule, e.g.
range_transition initrc_t puppet_exec_t:process s0 - s0:c0.c0123;
(assuming that the puppet entrypoint is labeled with puppet_exec_t).
