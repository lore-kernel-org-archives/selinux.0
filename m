Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3SMdu1q022242
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 18:39:56 -0400
Message-ID: <4816523B.4030905@tycho.nsa.gov>
Date: Mon, 28 Apr 2008 18:39:55 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Xavier Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: copy/paste policy patch
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com> <1209386863.30483.44.camel@gorn.columbia.tresys.com>
In-Reply-To: <1209386863.30483.44.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2008-04-25 at 08:07 -0500, Xavier Toth wrote:
>   
>> Here's a patch I'm using with an MLS version of glipper to give the
>> capability to check for dominance between copy and paste data
>> contexts. Hopefully some version of this can be upstreamed.
>>     

Here is a revised patch.  I support including this in refpolicy as it's 
generally useful for supporting selection managers.

Note that the access_vectors definition is at the end of the file in 
this patch.  Not sure if the ordering matters in that file, if it 
doesn't you can move this to coincide with the other X classes.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---


Index: policy/flask/security_classes
===================================================================
--- policy/flask/security_classes	(revision 2667)
+++ policy/flask/security_classes	(working copy)
@@ -114,5 +114,6 @@
 class x_resource		# userspace
 class x_event			# userspace
 class x_synthetic_event		# userspace
+class x_application_data	# userspace
 
 # FLASK
Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2667)
+++ policy/flask/access_vectors	(working copy)
@@ -775,3 +775,10 @@
 {
 	recv
 }
+
+class x_application_data
+{
+	paste
+	paste_after_confirm
+	copy
+}
Index: policy/mls
===================================================================
--- policy/mls	(revision 2667)
+++ policy/mls	(working copy)
@@ -568,7 +568,13 @@
 	 ( t1 == mlsxwinwrite ));
 
 
+#
+# MLS policy for the x_application_data class
+#
+mlsconstrain x_application_data { paste }
+	( l1 domby l2 );
 
+
 #
 # MLS policy for the pax class
 #



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
