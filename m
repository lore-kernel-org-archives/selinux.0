Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4LCDc05003344
	for <selinux@tycho.nsa.gov>; Thu, 21 May 2009 08:13:38 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4LCDXRw019026
	for <selinux@tycho.nsa.gov>; Thu, 21 May 2009 12:13:33 GMT
Message-ID: <4A154566.3090006@redhat.com>
Date: Thu, 21 May 2009 08:13:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chcat fixes
References: <C639DAB6.A73D6%csellers@tresys.com>
In-Reply-To: <C639DAB6.A73D6%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------000102070801040306060900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000102070801040306060900
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 05/20/2009 04:05 PM, Chad Sellers wrote:
> On 5/20/09 3:00 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>
>> Expansion of categores is still broken.  Here is a patch to fix.
>>
> This message appears to be missing a patch.
>
> Thanks,
> Chad
>


--------------000102070801040306060900
Content-Type: text/plain;
 name="policycoreutils-chcat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-chcat.patch"

--- nsapolicycoreutils/scripts/chcat	2009-01-13 08:45:35.000000000 -0500
+++ policycoreutils-2.0.62/scripts/chcat	2009-05-04 13:40:26.000000000 -0400
@@ -281,14 +281,14 @@
 def expandCats(cats):
     newcats = []
     for c in cats:
-        if c.find(".") != -1:
-            c = c.split(".")
-            for i in range(int(c[0][1:]), int(c[1][1:]) + 1):
-                x = ("c%d" % i)
-                if x not in newcats:
-                    newcats.append("c%d" % i)
-        else:
-            for i in c.split(","):
+        for i in c.split(","):
+            if i.find(".") != -1:
+                j = i.split(".")
+                for k in range(int(j[0][1:]), int(j[1][1:]) + 1):
+                    x = ("c%d" % k)
+                    if x not in newcats:
+                        newcats.append(x)
+            else:
                 if i not in newcats:
                     newcats.append(i)
     if len(newcats) > 25:

--------------000102070801040306060900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
