Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0PEbY3o010200
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 09:37:34 -0500
Received: from florence.astrium.eads.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0PEbWro022170
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 14:37:33 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: UNCLASSIFIED - Clarification of Symlink labelling...
Date: Fri, 25 Jan 2008 14:37:29 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64C0E@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hi All,

Am presently in the process of creating some SELinux policies for some
in house apps that run on our embedded devices. Thanks to some pointers
and general advice from Stephen & Dave (Smalley and Sugar), have made a
fair bit of headway so far and have something that is almost complete.
Hurrah!!! :)

However am experiencing some strangeness regarding symlinks and am after
either a *RTFM this* or a gentle pointer, because I am slightly
confused...

Most of the apps I am creating policy for, are located in /opt. For
example /opt/<various_appnames>, with the usual
/opt/<various_appnames>/{bin, lib, blah} dirs enclosed. They are
enclosed within the appname_t domain and labelled as follows
appname_libs_t, appname_exec_t, etc. However we also have /opt/lib which
includes symlinks to certain libraries located in
/opt/<various_appnames>/lib that are shared across applications (ORB-TAO
stuff for example).

Because of the default policy from system/libraries, these are
automagically labelled lib_t, which is for the most part fine, however
this causes apps that reference these symlinks to fail, as the app
hasn't access to lib_t.

I have tried relabelling the symlinks directly using chcon and by
editing my apps fc files to include these, however it never *takes*,
they are always labelled lib_t, which is from the enclosing dir.

I can override this by changing the file context for the enclosing dir
(/opt/lib in this case), however all the symlinks then take on the fc of
the enclosing dir I stipulate, which although better than before is not
ideal.

Is there any way to set symlinks directly or are the contexts always
inherited from the enclosing dir???

Or am I just missing something very simple and hence doing something
very stupid???

TIA

Dan

--

Dan Hawker
Linux System Administrator
Astrium
http://www.astrium.eads.net

-- 

This email (including any attachments) may contain confidential and/or
privileged information or information otherwise protected from disclosure.
If you are not the intended recipient, please notify the sender
immediately, do not copy this message or any attachments and do not use it
for any purpose or disclose its content to any person, but delete this
message and any attachments from your system. Astrium disclaims any and all
liability if this email transmission was virus corrupted, altered or
falsified.
---------------------------------------------------------------------
Astrium Limited, Registered in England and Wales No. 2449259
REGISTERED OFFICE:-
Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
