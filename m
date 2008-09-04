Message-ID: <48C03421.2040406@redhat.com>
Date: Thu, 04 Sep 2008 15:16:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Ivan Gyurdiev <ivg231@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com>	 <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil>	 <48B41D0E.6060509@redhat.com>  <48B4B348.2080801@gmail.com> <1219838648.5708.10.camel@moss-spartans.epoch.ncsc.mil> <48B5D8D4.8010502@tresys.com> <48BFFBD7.9070806@manicmethod.com>
In-Reply-To: <48BFFBD7.9070806@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Tue, 2008-08-26 at 21:52 -0400, Ivan Gyurdiev wrote:
>>>>>> I'm a little unclear on what this is doing - can you clarify?
>>>>>>     
>>>>> This is clearing the existing seusers.final file, otherwise delete was
>>>>> not working.
>>>>>   
>>>> I think the previous code was doing more - it was merging the local file 
>>>> with the shipped base package file, like this:
>>>>
>>>>     data = extract_file_from_policy_package( )
>>>>     write_file ( "seusers.final", data )
>>>>     if ( data != null ) {
>>>>         seusers.clear_cache()  // thereby forcing reload from 
>>>> seusers.final when cache() is called again (in merge_components)
>>>>     } else {
>>>>         seusers.clear()
>>>>     }
>>>>
>>>> It's also doing this three times (once for fcontexts, once for seusers, 
>>>> once for seusers_extra).
>>>> The problem is that you're skipping the link_sandbox call, which builds 
>>>> the base package, containing this information.
>>> We're trying to avoid the overhead of re-linking the policy when we are
>>> only modifying non-policy components like seusers and fcontexts.
>>> fcontexts.local is split out to a separate file for precedence reasons
>>> so it doesn't get merged anymore.  I don't think Dan actually uses
>>> seusers in the base policy for anything at present, but others may be.
>>>
>> Verified. The seusers coming from the policy are not merged into the seusers.final with this patchset. 
>>
>> It appears that at present in sepol_link_packages() there is no merging of seusers from each module so we only support seusers in base presently. Therefore we don't have to worry about getting the seusers from all the modules but we do need to grab them out of the base module and combine them in.
>>
> 
> Ping on this, were you able to reproduce this Dan? I'd like to get this patch in before we do a toolchain release (which is soonish).

Testing results. On my rawhide system.


NOTE: Rebuild policy old fashioned way
# rpm -Uhv --force
/home/dwalsh/sources/RPMS/noarch/selinux-policy*3.5.6-2.fc10.noarch.rpm
Preparing...                ###########################################
[100%]
   1:selinux-policy         ###########################################
[ 50%]
   2:selinux-policy-targeted###########################################
[100%]


# grep root /etc/selinux/targeted/seusers
/etc/selinux/targeted/modules/active/seusers
/etc/selinux/targeted/modules/active/seusers.final
/etc/selinux/targeted/seusers:root:unconfined_u:s0-s0:c0.c1023
/etc/selinux/targeted/modules/active/seusers:root:unconfined_u:s0-s0:c0.c1023
/etc/selinux/targeted/modules/active/seusers.final:root:unconfined_u:s0-s0:c0.c1023

Note all three seusers files reference root.

# semanage login -d root
NOTE: Command did not fail.  This command is actually deleting the
customization of root to use unconfined_u.

# grep root /etc/selinux/targeted/seusers \
/etc/selinux/targeted/modules/active/seusers \
/etc/selinux/targeted/modules/active/seusers.final
/etc/selinux/targeted/seusers:root:root:s0-s0:c0.c1023
/etc/selinux/targeted/modules/active/seusers.final:root:root:s0-s0:c0.c1023

NOTE root entry is still in
/etc/selinux/targeted/modules/active/seusers.final and
/etc/selinux/targeted/seusers
But it is using SELinux User "root" now which is the default in the base
package.

# semanage login -l | grep root
root                      root                      s0-s0:c0.c1023

NOTE semanage and getseuserbyname still have root entry

# semanage login -d root
/usr/sbin/semanage: Login mapping for root is defined in policy, cannot
be deleted

NOTE If I try to delete root a second time, it gives me an error because
now there is no local customization.

So the patch does not leave us in a bad state even if the user tries to
do something evil.  But it is not perfect, the same command acts
differently depending on local customization.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
