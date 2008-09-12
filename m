Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CFqflb020319
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 11:52:41 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8CFqf77011013
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 15:52:41 GMT
Message-ID: <48CA903F.6080109@redhat.com>
Date: Fri, 12 Sep 2008 11:52:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Changes to semanage to allow it to handle transactions.
References: <48C57780.6090408@redhat.com> <48CA8062.7000808@manicmethod.com>
In-Reply-To: <48CA8062.7000808@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------060301020801010903030308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060301020801010903030308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> semanage -S targeted -i - << __eof
> user -a -P user -R "unconfined_r system_r" -r s0-s0:c0.c1023 unconfined_u
> user -a -P user -R guest_r guest_u
> user -a -P user -R xguest_r xguest_u
> __eof
> semanage -S targeted -i - << __eof
> login -m  -s unconfined_u -r s0-s0:c0.c1023 __default__
> login -m  -s unconfined_u -r s0-s0:c0.c1023 root
> __eof
> 
> So you can add multiple records in a single pass.
>>

> This patch seems to cause some issues:

> [root@misterfreeze selinux-pristine]# semanage --help
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 433, in <module>
>     usage(_("Requires 2 or more arguments"))
>   File "/usr/sbin/semanage", line 98, in usage
>     """) % message)
> TypeError: float argument required




> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Patch off your latest policycoreutils.

--------------060301020801010903030308
Content-Type: text/plain;
 name="semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.patch"

diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.55/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.55/semanage/semanage	2008-09-12 11:49:59.000000000 -0400
@@ -43,7 +43,7 @@
 if __name__ == '__main__':
 
 	def usage(message = ""):
-               raise ValueError(_("""
+               text = _("""
 semanage [ -S store ] -i [ input_file | - ]
 
 semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D} [-n]
@@ -94,8 +94,8 @@
 	-s, --seuser     SELinux User Name
 	-t, --type       SELinux Type for the object
 	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)
-%s
-""") % message)
+""")
+               raise ValueError("%s\n%s" % (text, message))
 		
 	def errorExit(error):
 		sys.stderr.write("%s: " % sys.argv[0])
@@ -198,7 +198,7 @@
 		object = argv[0]
 		option_dict=get_options()
 		if object not in option_dict.keys():
-			usage(_("%s not defined") % object)
+			usage(_("Invalid parameter %s not defined") % object)
 			
 		args = argv[1:]
 

--------------060301020801010903030308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
