Message-ID: <4D7EA42A.2030802@windriver.com>
Date: Mon, 14 Mar 2011 19:26:34 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: libselinux version bump past 99
References: <4D76AD1C.8080901@tycho.nsa.gov>
In-Reply-To: <4D76AD1C.8080901@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11-03-08 05:26 PM, Eamon Walsh wrote:
> Libselinux has reached version 2.0.99 and I need to push a bug fix, just checking to make sure 2.0.100 is fine and won't cause any problems e.g. with upgrades.
>
>

On a related note, is there a reason why the shared objects don't
track a similar versioning number?    We came across a situation
where an internal update added a new dir for libs.   But note the
shared objects are hard coded to version 1,  and the old selinux
libs just happened to be found 1st.   Which leads to a cryptic
internal selinux error message like this:

"libsepol.policydb_read: policydb module version 10 does not
match my version range 4-8"

Granted, this may not be a common problem, but the solution that
came to me was to simply let the normal ld.so dynamic library
versioning do its job in determining which bins need which libs;
something that it is remarkably good at.  :)

To that end, a trivial patch like the below, applied to the two main
libraries seems to fix things up. If this seems OK, then I can send
proper patches with a Signed-off-by, but I guess that would leave
you folks stuck with the question of when to make the switchover...

Thanks,
Paul.

-------------------

--- a/src/Makefile
+++ b/src/Makefile
@@ -15,7 +15,7 @@ RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/
 LIBBASE=$(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
-LIBVERSION = 1
+LIBVERSION = $(VERSION)
 
 LIBA=libselinux.a
 TARGET=libselinux.so


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
