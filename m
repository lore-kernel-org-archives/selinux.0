Message-ID: <470EB214.9000203@redhat.com>
Date: Thu, 11 Oct 2007 19:30:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
Subject: Re: Are the reference policy abstractions the right ones?
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>	 <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>	 <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>	 <1191956863.23486.62.camel@dhcp-64-223.iad.redhat.com>	 <1191959097.2794.127.camel@moss-lions.epoch.ncsc.mil>	 <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com> <1192029823.2898.32.camel@localhost.localdomain>
In-Reply-To: <1192029823.2898.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl MacMillan wrote:
> On Tue, 2007-10-09 at 16:00 -0400, Karl MacMillan wrote:
>> On Tue, 2007-10-09 at 15:44 -0400, James Carter wrote:
>>> On Tue, 2007-10-09 at 15:07 -0400, Karl MacMillan wrote:
>> [...]
>>
>>>>>  but why would you use the attribute
>>>>> statement?
>>>>>
>>>>> wouldn't it be this?
>>>>>
>>>>> type domain
>>>>> type daemon, domain
>>>>> type network_server, daemon
>>>>>
>>>> Maybe - if we remove the distinction entirely. The only reason I can
>>>> think to leave the attribute statement is to mark a type as "abstract" -
>>>> i.e., can't actually be a label on a real subject or object in the
>>>> running system.
>>>>
>>> There would be a few places where one might use an abstract type, domain
>>> being one of them, but I am not sure they would be needed.
>>>
>>> Your idea does seem to be simple, but it still won't handle the case
>>> where there is type mangling.
>>>
>>> if we have:
>>>
>>> type foo;
>>> allow foo foo_bar : file read;
>>> type baz, foo;
>>>
>>> Where foo_bar was created in some macro or interface.
>>>
>>> It seems like baz would have read permission on foo_bar, when probably
>>> we would like it to have read permission on baz_bar.
>>>
>>> All of which you know and previously mentioned a month ago:
>>> http://marc.info/?l=selinux&m=118961442411429&w=2
>>>
>> Yeah - too bad I don't have an answer. We basically need a way to mark
>> groups of types as related and do self-like replacements. No good syntax
>> suggestions here.
>>
> 
> Here's a suggestion (this assumes that hierarchy stops using dot in
> favor of explicit statements):
> 
> type_group daemon {
> 	type process, domain;
> 	type exec, exec_file;
> 	type conf, file_type;
> 	type log, log_file;
> }
> 
> allow daemon.process daemon.exec : file entrypoint;
> # etc., etc. for the exec permissions - could
> # even have a type_transition.
> allow daemon.process daemon.conf : file read;
> allow daemon.process daemon.log : file { read write };
> 
> # Apache gets all of the types defined in daemon and
> # access to the apache versions - so apache.process
> # can read apache.conf.
> type_group apache, daemon {
> 	type html_files, file;
> }
> 
> allow apache.process apache.html_files : file read;
> 
> This handles the new set of types that is separate from the existing
> set. We could also make some of the groups "abstract" - so that
> daemon.process can't be applied to a process.
> 
> To handle the need for extension - Dan's java_t example. Assuming we
> have unconfined, wouldn't this work:
> 
> type java_t, unconfined_t;
> 
> allow java_t self : process execmem;
> 
> Karl
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

I love the idea of inheritance and bringing the idea of OO to policy
writing.  A lot of the policy we write now is cookie cutter, and
system-config-selinux/poligygentool is attempting to create as much of
this reference policy as possible.   We should be able to easily
generate most of the policy out of a few basic types.  My tool currently
 defines four types of applications  and two types of users/roles.

All the interfaces for a new type should be created automatically based
on the type.  So if I create a file_type.  You get getattr, read , rw,
manage.  If the file type is defined as a var_lib, you automatically get
the transition from var_lib to domain_var_lib.




Ok a couple of hard questions.

My java_t example, requires all of the same permissions as unconfined_t
including if java_t creates a file in /tmp, it gets created as
unconfined_tmp_t not java_tmp_t.

But other situations if I create a

type webmail_t, http_sys_script_t.

I want total separation.


So one relations ship is a exend and the second one is a duplicate.

java_t extends unconfined_t only adding java_exec_t

while webmail_t would need all the types associated with the
http_sys_script_t

The tools should generate all of the "interfaces automatically.  So
If I want to show the relationship between two domains.

system_dbus_t.transition(networkmanager_t)

system_dbus_t.signal(network_manager_t)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHDrIUrlYvE4MpobMRAjriAKDjW5myjwZRKXtL4z5SgH90IRSYZgCcCnK7
Cqk6kg0uVLgAa8a1+Xl/qVc=
=4QaF
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
