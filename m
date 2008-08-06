Message-ID: <48999F72.2040003@redhat.com>
Date: Wed, 06 Aug 2008 08:56:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Can we make libsemanage default to expand-check=0
References: <489864B4.1090605@redhat.com> <1217948012.2994.93.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217948012.2994.93.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-08-05 at 10:33 -0400, Daniel J Walsh wrote:
>> plain text document attachment (libsemanage-rhat.patch)
>> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage.conf libsemanage-2.0.25/src/semanage.conf
>> --- nsalibsemanage/src/semanage.conf	2008-06-12 23:25:16.000000000 -0400
>> +++ libsemanage-2.0.25/src/semanage.conf	2008-07-17 13:58:44.000000000 -0400
>> @@ -35,4 +35,4 @@
>>  # given in <sepol/policydb.h>.  Change this setting if a different
>>  # version is necessary.
>>  #policy-version = 19
>> -
>> +expand-check=0
> 
> I thought we were going to leave this unchanged upstream, and only make
> this change in Fedora.
>
Ok.  I was just trying to get rid of my patch.

> We want the checking to be applied for policy developers.  If you were
> to incorporate 'make validate' into the policy spec file, then you would
> get it applied when you perform a policy build.  And ideally there would
> be similar support in the selinux-policy-devel Makefile for policy
> module writers to use.  All it does is run semodule_link followed by
> semodule_expand, which applies the checking.
> 
make validate is now in the Rawhide spec file.
> If we were to change the upstream default, we'd likely change it in the
> code (semanage_conf_init()) rather than just in the .conf file.  And
> then policy developers would need to add expand-check=1 to their .conf
> file to set it.  
> 
Putting this into the selinux-policy-devel package (which does not exist
any longer, it is all part of selinux-policy) does not work.  Since the
semodule_lnk and semodule_expand do not use the installed system.  So
you would have hack up the Makefile to grab all of the pp files in
/etc/selinux/TYPE/modules/active/*.pp and isolate the base.pp file, then
add the new pp files that you are creating.  Or somehow add this as a
parameter to semodule_link to make it happen automatically

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
