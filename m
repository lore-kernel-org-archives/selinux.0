Subject: patching 2.6.0-test1
From: max barwell <maxb@paradise.net.nz>
To: SElinux list <SELinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058497958.1735.11.camel@orac.lite.net.nz>
Mime-Version: 1.0
Date: 18 Jul 2003 15:12:38 +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wanted to try out 2.6.0-test1, with selinux too of course.

I used the http://www.nsa.gov/selinux/lk/2.6.0-test1-selinux1.patch.gz
patch, but when i booted and tried to relabel my system, an error said I
was running a non selinux kernel.

Inspection of my dmesg does however say selinux initialised, but there
are none of the usual messages about context labeling etc.

I noticed there are several patches in the
http://www.nsa.gov/selinux/lk/ directory, do I only need the patch I
mentioned above, or a combo, or do I need updated selinux files to
handle a kernel this new.

I am using debian sid with Russel's selinux packages.

regards Max


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
