Message-ID: <418107A6.6070104@redhat.com>
Date: Thu, 28 Oct 2004 10:52:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Finally got around to adding the following patch to policycoreutils
Content-Type: multipart/mixed;
 boundary="------------040902040602050500080704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040902040602050500080704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

for audit2allow.

Enhanced Thomas Bleher's Patch a little bit.

Dan



--------------040902040602050500080704
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.17.7/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2004-09-10 11:25:57.000000000 -0400
+++ policycoreutils-1.17.7/audit2allow/audit2allow	2004-10-28 10:34:33.476265420 -0400
@@ -124,13 +124,19 @@
 foreach $k (sort keys %rules)
 { 
     my ($a,$scontext,$tcontext,$tclass) = split /\|/, $k;
-    print OUT  "allow $scontext $tcontext:$tclass {";
+    if ($scontext eq $tcontext) {
+        $tcontext = 'self';
+    }
+    print OUT  "allow $scontext $tcontext:$tclass";
     
     my $access_types = $rules{$k};
+    $len=(keys %$access_types);
+    if ($len gt 2 ) { print OUT  " {"; }
     foreach $t (sort keys %$access_types) {
-		print OUT  "$t ";
+      if ($t ne "") {print OUT  " $t";}
     }
-    print OUT "};\n";
+    if ($len gt 2 ) { print OUT " }"; }
+    print OUT ";\n";
     $occur{$k} =~ s/\\(.)/$1/g;  # de-escape string
     print OUT "$occur{$k}\n" if ($verbose);
 }

--------------040902040602050500080704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
