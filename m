Message-ID: <4849CD6E.9080405@tycho.nsa.gov>
Date: Fri, 06 Jun 2008 19:51:10 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Trying to get XAce policy straightened out but our tool chain
 is too broken to handle it.
References: <48480210.60309@redhat.com>
In-Reply-To: <48480210.60309@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> The interfaces I want to add are something like
>
> template - xserver_common_domain_template(staff)
> 	Used to generate types for $1_xserver_t and $1_xrootwindow_t
>
> interface - xserver_use(staff, staff, staff_nsplugin_t)
> 	    xserver_use(xdm, staff, staff_nsplugin_t)
> 	All interaction between application and X Server
>
> template - xserver_common_user_template(staff, staff_r, staff_t)
>
> 	This generates all of the user types/rules for a user X Sessionps
> started by the user, Calls out to xserver_common_template
>
> interface - xserver_common_app(staff, staff_nsplugin_t)
>
> 	This defines all the common rules for a confined application like
> nsplugin running in the user domain
> 	
> Then we can begin to write communications between staff and unconfined_t
> or other user domains.
>   

After some discussion, it's been decided that the desktop effort here 
should continue devoting time to X policy development.  My earlier 
statements notwithstanding.

What's your current policy patch for the above?

> The problem I have is the compiler is too stupid to understand the
> differences between a gen_requires block defining the required types and
> the actual type definition.
>
> So I end up in a catch 22 where the compiler tells me I need to require
> $1_rootwindow_t, but if I gen_require type $1_rootwindow_t, it tells me
> I have a duplicate definition.
>   

I encountered a bug where the "get_type_attr_decl.sed" script that 
reorders declarations wasn't matching properly, because it depends on a 
_comment_ at the end of the block to work (I forgot to use gen_require).

This sounds like a different bug but it might be related.


> So if you have a derived type in a gen_requires block the compiler can
> not handle it.
>
>
> /usr/bin/checkmodule -M -m tmp/staff.tmp -o tmp/staff.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/staff.tmp
> policy/modules/roles/staff.te":11:ERROR 'duplicate declaration of
> type/attribute' at token 'staff_input_xevent_t' on line 66981:
> #line 11
> 		type staff_input_xevent_t;
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/staff.mod] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.86849 (%install)
>
>
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.86849 (%install)
>
>
> Which is complaining about:
>
> interface(`xserver_use',`
> 	gen_require(`
> 		type $1_rootwindow_t;
> 		attribute $1_x_domain, $1_input_xevent_type;
> 		type $1_xserver_t, $1_xserver_tmpfs_t;
> 		type $2_input_xevent_t;
> 	')
>
> 	typeattribute $2_input_xevent_t $1_input_xevent_type;
>
> ...
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
