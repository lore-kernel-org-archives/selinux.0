Message-ID: <526E6A01.4070904@redhat.com>
Date: Mon, 28 Oct 2013 09:43:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: Sven Vermeulen patch to fix sepolgen test code
References: <526ACA3C.7020206@redhat.com> <526AD092.3070903@tycho.nsa.gov>
In-Reply-To: <526AD092.3070903@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/25/2013 04:12 PM, Stephen Smalley wrote:
> On 10/25/2013 03:45 PM, Daniel J Walsh wrote:
>> 
>> This patch looks good to me. acked.
> 
> This reverts the fix I just applied, and causes make test to fail in 
> sepolgen for me.  Do you see a different result?  Also, cc me.
> 
> Current selinux master: cd selinux git checkout master git pull cd
> sepolgen make test $ make test make -C tests test make[1]: Entering
> directory `/home/sds/selinux/sepolgen/tests' python run-tests.py 
> .......................................... 
> ---------------------------------------------------------------------- Ran
> 43 tests in 0.811s
> 
> OK make[1]: Leaving directory `/home/sds/selinux/sepolgen/tests'
> 
> With this patch: make -C tests test make[1]: Entering directory
> `/home/sds/selinux/sepolgen/tests' python run-tests.py 
> ...........................F.............. 
> ====================================================================== 
> FAIL: test_append (test_matching.TestMatchList) 
> ---------------------------------------------------------------------- 
> Traceback (most recent call last): File
> "/home/sds/selinux/sepolgen/tests/test_matching.py", line 54, in 
> test_append self.assertEqual(len(ml), 2) AssertionError: 1 != 2
> 
> ---------------------------------------------------------------------- Ran
> 43 tests in 0.796s
> 
> FAILED (failures=1) make[1]: *** [test] Error 1 make[1]: Leaving directory
> `/home/sds/selinux/sepolgen/tests' make: *** [test] Error 2
> 
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 

I agree the value should be 1 not 2.  Need to drop patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuagEACgkQrlYvE4MpobPrcwCghA4N8gmCWO2B1lpFIpoZtTup
dRAAnRYzJTYM1bunKIz84G1U4bf1dcHU
=tFPq
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
