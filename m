Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2OGJaRZ023847
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 12:19:41 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2OGKKoH011688
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 16:20:21 GMT
Message-ID: <4BAA3B96.9000706@manicmethod.com>
Date: Wed, 24 Mar 2010 12:19:34 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <karlwmacmillan@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: sepolgen unit tests fail
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not sure when this happened or what caused it but when I try to run 
the unit tests in the userspace repo I get this:

python run-tests.py
...........F...............................
======================================================================
FAIL: test_to_string (test_access.TestAccessVector)
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/root/dev/selinux/sepolgen/tests/test_access.py", line 85, in 
test_to_string
     self.assertEquals(str(a), "allow foo bar : file { read write };")
AssertionError: 'allow foo bar:file { read write };' != 'allow foo bar : 
file { read write };'

----------------------------------------------------------------------
Ran 43 tests in 3.112s

FAILED (failures=1)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
