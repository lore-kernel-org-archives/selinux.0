Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8SJJ9iF016372
	for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2012 15:19:09 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8SJIZBE010632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2012 15:18:36 -0400
Received: from [10.11.10.123] (vpn-10-123.rdu.redhat.com [10.11.10.123])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q8SJIZiT012629
	for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2012 15:18:35 -0400
Message-ID: <1348859914.2845.4.camel@localhost>
Subject: semanage: should -a imply -m?
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 28 Sep 2012 15:18:34 -0400
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan has a patch in Fedora which causes semanage -a to act like semanage
-m if the record already exists instead of raising an error and
aborting.  Example of the patch is below:


@@ -493,7 +493,9 @@ class loginRecords(semanageRecords):
                if rc < 0:
                        raise ValueError(_("Could not check if login mapping for %s is defined") % name)
                if exists:
-                       raise ValueError(_("Login mapping for %s is already defined") % name)
+                       semanage_seuser_key_free(k)
+                       return self.__modify(name, sename, serange)
+

What do others think about this?  Should we cause -a to act like -m or
should it abort?  Should we force the -a -> -m logic up to the caller?
I guess I'm fine with either.  Is semanage -a enough like semodule -i
and -m like -u that this would actually be expected behavior?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
