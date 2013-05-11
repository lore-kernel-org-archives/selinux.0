Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4CNclaH028702
	for <selinux@tycho.nsa.gov>; Sun, 12 May 2013 19:38:47 -0400
Received: by mail-wi0-f173.google.com with SMTP id hi5so950317wib.0
        for <selinux@tycho.nsa.gov>; Sun, 12 May 2013 16:38:45 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id fu14sm3097754wic.8.2013.05.11.11.57.23
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 11:57:23 -0700 (PDT)
Date: Sat, 11 May 2013 20:56:24 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH/RFC 1/2] Fix test that compares matchlist length
Message-ID: <20130511185624.GB933@siphos.be>
References: <20130511185446.GA933@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130511185446.GA933@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When running the tests, the following failure occurs:

======================================================================
FAIL: test_append (test_matching.TestMatchList)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/var/portage/portage/dev-python/sepolgen-1.1.9-r1/work/sepolgen-1.1.9-2.7/tests/test_matching.py", line 94, in test_append
    self.assertEqual(len(ml), 1)
AssertionError: 2 != 1

>From the test code, it looks like we use the matchlist length as a way to deduce
if an .append() did the right thing or not (i.e. add to bastards or children).
However, the length for the matchlist is defined as the sum of the lengths of
both:

    def __len__(self):
        # Only return the length of the matches so
        # that this can be used to test if there is
        # a match.
        return len(self.children) + len(self.bastards)

As a result, the len(ml) should always increase with an append, and then check
the length of one of the two sublists (children or bastards) to find out if this
occurred in the right sublist.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 sepolgen/tests/test_matching.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sepolgen/tests/test_matching.py b/sepolgen/tests/test_matching.py
index 2282eca..161e001 100644
--- a/sepolgen/tests/test_matching.py
+++ b/sepolgen/tests/test_matching.py
@@ -56,7 +56,7 @@ class TestMatchList(unittest.TestCase):
         a = matching.Match()
         a.dist = 200
         ml.append(a)
-        self.assertEqual(len(ml), 1)
+        self.assertEqual(len(ml), 2)
         self.assertEqual(len(ml.bastards), 1)
 
         ml.allow_info_dir_change = False
@@ -64,7 +64,7 @@ class TestMatchList(unittest.TestCase):
         a.dist = 0
         a.info_dir_change = True
         ml.append(a)
-        self.assertEqual(len(ml), 1)
+        self.assertEqual(len(ml), 3)
         self.assertEqual(len(ml.bastards), 2)
 
     def test_sort(self):
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
