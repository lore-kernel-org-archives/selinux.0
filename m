Subject: Re: [ SEMANAGE ] More work on policy_components.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4356F1B3.3060000@cornell.edu>
References: <4356F1B3.3060000@cornell.edu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 12:55:34 -0400
Message-Id: <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 21:24 -0400, Ivan Gyurdiev wrote:
> This patch makes the commit function shorter, and more intelligent, and 
> implements a lot more of the "merge into base" function (but not all of 
> it). It also adds comments in database.h about the behavior of the 
> add(), modify(), and iterate() functions.

Oops, this one causes memory errors on a semodule -b base.pp (per
valgrind).

==8109== Invalid read of size 4
==8109==    at 0x1B95D3CD: dbase_policydb_drop_cache (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95D55D: dbase_policydb_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95C1A3: bool_policydb_dbase_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95DE3C: semanage_direct_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95F357: semanage_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x8049571: main (in /home/sds/cvs/obj/usr/sbin/semodule)
==8109==  Address 0x1B9849E0 is 16 bytes inside a block of size 28 free'd
==8109==    at 0x1B90430F: free (vg_replace_malloc.c:235)
==8109==    by 0x1B95D56B: dbase_policydb_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B96197B: port_policydb_dbase_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95DE08: semanage_direct_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95F357: semanage_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x8049571: main (in /home/sds/cvs/obj/usr/sbin/semodule)
==8109==
==8109== Invalid free() / delete / delete[]
==8109==    at 0x1B90430F: free (vg_replace_malloc.c:235)
==8109==    by 0x1B95D56B: dbase_policydb_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95C1A3: bool_policydb_dbase_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95DE3C: semanage_direct_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95F357: semanage_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x8049571: main (in /home/sds/cvs/obj/usr/sbin/semodule)
==8109==  Address 0x1B9849D0 is 0 bytes inside a block of size 28 free'd
==8109==    at 0x1B90430F: free (vg_replace_malloc.c:235)
==8109==    by 0x1B95D56B: dbase_policydb_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B96197B: port_policydb_dbase_release (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95DE08: semanage_direct_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x1B95F357: semanage_disconnect (in /home/sds/cvs/obj/lib/libsemanage.so.1)
==8109==    by 0x8049571: main (in /home/sds/cvs/obj/usr/sbin/semodule)
==8109==
==8109== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 26 from 2)


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
