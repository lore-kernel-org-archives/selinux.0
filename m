Message-ID: <485F863B.1040603@redhat.com>
Date: Mon, 23 Jun 2008 07:17:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Trying to get XAce policy straightened out but our tool chain
 is too broken to handle it.
References: <48480210.60309@redhat.com> <1213625437.15523.71.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213625437.15523.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-06-05 at 11:11 -0400, Daniel J Walsh wrote:
>> The interfaces I want to add are something like
>>
>> template - xserver_common_domain_template(staff)
>> 	Used to generate types for $1_xserver_t and $1_xrootwindow_t
>>
>> interface - xserver_use(staff, staff, staff_nsplugin_t)
>> 	    xserver_use(xdm, staff, staff_nsplugin_t)
>> 	All interaction between application and X Server
>>
>> template - xserver_common_user_template(staff, staff_r, staff_t)
>>
>> 	This generates all of the user types/rules for a user X Sessionps
>> started by the user, Calls out to xserver_common_template
>>
>> interface - xserver_common_app(staff, staff_nsplugin_t)
>>
>> 	This defines all the common rules for a confined application like
>> nsplugin running in the user domain
>> 	
>> Then we can begin to write communications between staff and unconfined_t
>> or other user domains.
>>
>> The problem I have is the compiler is too stupid to understand the
>> differences between a gen_requires block defining the required types and
>> the actual type definition.
>>
>> So I end up in a catch 22 where the compiler tells me I need to require
>> $1_rootwindow_t, but if I gen_require type $1_rootwindow_t, it tells me
>> I have a duplicate definition.
>>
>> So if you have a derived type in a gen_requires block the compiler can
>> not handle it.
> 
> I'm a little unclear as to why this is required (why do you need to
> require and declare the same symbol again?).  However, is there some
> reason we can't just automatically promote a require to a declaration
> upon encountering the latter?  Seems like we've talked about this
> before.  Not sure whether that should happen within libsepol
> symtab_insert() or in the callers, e.g. declare_type().
> 
I don't know,  All I know is the compiler complains if it is there and
if it is not there.  Catch 22.  I end up going to great lengths to hack
around compiler errors...
>>
>> /usr/bin/checkmodule -M -m tmp/staff.tmp -o tmp/staff.mod
>> /usr/bin/checkmodule:  loading policy configuration from tmp/staff.tmp
>> policy/modules/roles/staff.te":11:ERROR 'duplicate declaration of
>> type/attribute' at token 'staff_input_xevent_t' on line 66981:
>> #line 11
>> 		type staff_input_xevent_t;
>> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>> make: *** [tmp/staff.mod] Error 1
>> error: Bad exit status from /var/tmp/rpm-tmp.86849 (%install)
>>
>>
>> RPM build errors:
>>     Bad exit status from /var/tmp/rpm-tmp.86849 (%install)
>>
>>
>> Which is complaining about:
>>
>> interface(`xserver_use',`
>> 	gen_require(`
>> 		type $1_rootwindow_t;
>> 		attribute $1_x_domain, $1_input_xevent_type;
>> 		type $1_xserver_t, $1_xserver_tmpfs_t;
>> 		type $2_input_xevent_t;
>> 	')
>>
>> 	typeattribute $2_input_xevent_t $1_input_xevent_type;
>>
>> ...
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
