Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m55FBASF023941
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 11:11:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m55FBAJQ026720
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 15:11:10 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m55FBAr6017622
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 11:11:10 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m55FB9sn012107
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 11:11:09 -0400
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m55FB8F5018102
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 11:11:09 -0400
Message-ID: <48480210.60309@redhat.com>
Date: Thu, 05 Jun 2008 11:11:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Trying to get XAce policy straightened out but our tool chain is
 too broken to handle it.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The interfaces I want to add are something like

template - xserver_common_domain_template(staff)
	Used to generate types for $1_xserver_t and $1_xrootwindow_t

interface - xserver_use(staff, staff, staff_nsplugin_t)
	    xserver_use(xdm, staff, staff_nsplugin_t)
	All interaction between application and X Server

template - xserver_common_user_template(staff, staff_r, staff_t)

	This generates all of the user types/rules for a user X Sessionps
started by the user, Calls out to xserver_common_template

interface - xserver_common_app(staff, staff_nsplugin_t)

	This defines all the common rules for a confined application like
nsplugin running in the user domain
	
Then we can begin to write communications between staff and unconfined_t
or other user domains.

The problem I have is the compiler is too stupid to understand the
differences between a gen_requires block defining the required types and
the actual type definition.

So I end up in a catch 22 where the compiler tells me I need to require
$1_rootwindow_t, but if I gen_require type $1_rootwindow_t, it tells me
I have a duplicate definition.

So if you have a derived type in a gen_requires block the compiler can
not handle it.


/usr/bin/checkmodule -M -m tmp/staff.tmp -o tmp/staff.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/staff.tmp
policy/modules/roles/staff.te":11:ERROR 'duplicate declaration of
type/attribute' at token 'staff_input_xevent_t' on line 66981:
#line 11
		type staff_input_xevent_t;
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/staff.mod] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.86849 (%install)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.86849 (%install)


Which is complaining about:

interface(`xserver_use',`
	gen_require(`
		type $1_rootwindow_t;
		attribute $1_x_domain, $1_input_xevent_type;
		type $1_xserver_t, $1_xserver_tmpfs_t;
		type $2_input_xevent_t;
	')

	typeattribute $2_input_xevent_t $1_input_xevent_type;

...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
