Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2OGfWU6025563
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 12:41:32 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2OGf67Y013855
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 16:41:07 GMT
Message-ID: <4BAA40B5.7010303@redhat.com>
Date: Wed, 24 Mar 2010 12:41:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <karlwmacmillan@gmail.com>
Subject: Re: sepolgen unit tests fail
References: <4BAA3B96.9000706@manicmethod.com>
In-Reply-To: <4BAA3B96.9000706@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/24/2010 12:19 PM, Joshua Brindle wrote:
> I'm not sure when this happened or what caused it but when I try to 
> run the unit tests in the userspace repo I get this:
>
> python run-tests.py
> ..........F...............................
> ======================================================================
> FAIL: test_to_string (test_access.TestAccessVector)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/root/dev/selinux/sepolgen/tests/test_access.py", line 85, in 
> test_to_string
>     self.assertEquals(str(a), "allow foo bar : file { read write };")
> AssertionError: 'allow foo bar:file { read write };' != 'allow foo bar 
> : file { read write };'
>
> ----------------------------------------------------------------------
> Ran 43 tests in 3.112s
>
> FAILED (failures=1)
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
Looks like the space I removed between "bar : file" -> bar:file might be 
causing the problem.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
