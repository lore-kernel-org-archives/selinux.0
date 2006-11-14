Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAEGQKER024132
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 11:26:21 -0500
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAEGPcWe014268
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 16:25:38 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAEGQY0N021495
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 11:26:34 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAEGQTGH139212
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 11:26:32 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAEGQT8h005830
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 11:26:29 -0500
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.130])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id kAEGQRg8005229
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 11:26:28 -0500
Message-ID: <4559EE2E.3040807@us.ibm.com>
Date: Tue, 14 Nov 2006 10:26:22 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Valid setrans.conf entries?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, in order to do some testing on the "robustness" of the label 
translation system, we have tried the follow set of entries in setrans.conf:

s2:c1-s15:c0.c1023=Secret:B-SystemHigh
s2:c0,c1-s15:c0.c1023=Secret:AB-SystemHigh
s0:c1,c3=&*!?_-+=<>[]{áñ�}
s0:c1,c3=&*!?_-+=<>[]{áñ�}

These last two entries are causing the chcat utility to bomb (and 
possibly others, I haven't checked them all). The root of the error for 
this particular problem is that in /usr/bin/chcat, the line (314):
     print "%-30s %s" % tuple(rec)

Is resulting in a 3-tuple and error that looks like:
('s0:c1,c3', '&*!?_-+', '<>[]{\xc3\xa1\xc3\xb1\xc3\x9f}')
Traceback (most recent call last):
   File "/usr/bin/chcat", line 378, in ?
     sys.exit(listcats())
   File "/usr/bin/chcat", line 314, in listcats
     print "%-30s %s" % tuple(rec)
TypeError: not all arguments converted during string formatting

The normal behaviour is a 2-tuple like this:
('s2:c0,c1-s15:c0.c1023', 'Secret:AB-SystemHigh')
s2:c0,c1-s15:c0.c1023          Secret:AB-SystemHigh

The question is, should the equals sign '=' be a valid character for the 
  translated label? If so, then it would be possible to adjust the 
parsing logic in chcat. If not, then nothing really needs to change, 
although it might be nice to have a more robust check done regardless?

A really simple, quick patch added to give an idea of an additional check...

Thanks,
Mike

-----

--- /usr/bin/chcat.orig 2006-11-14 05:16:06.000000000 -0600
+++ /usr/bin/chcat      2006-11-14 05:18:52.000000000 -0600
@@ -304,12 +304,18 @@
         sys.exit(1)

  def listcats():
+    count = 0
      fd = open(selinux.selinux_translations_path())
      for l in fd.read().split("\n"):
+        count = count + 1
          if l.startswith("#"):
              continue
          if l.find("=") != -1:
              rec = l.split("=")
+            if (len(rec) > 2):
+                print _("Invalid line: %s") % l
+                print _("Error: equals (=) is not a label character 
(line %d)") % count
+                return 1
              print "%-30s %s" % tuple(rec)
      fd.close()
      return 0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
