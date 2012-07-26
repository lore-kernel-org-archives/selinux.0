MIME-Version: 1.0
In-Reply-To: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
References: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
Date: Thu, 26 Jul 2012 15:58:31 -0700
Message-ID: <CAFftDdrMCnTA+jLrv-8A6f_J-dfaD_eDacQy=LL+SyfKLadfoQ@mail.gmail.com>
Subject: Re: Questions about the MLS to "read down"
From: William Roberts <bill.c.roberts@gmail.com>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would it be ok to add release_app as an mlstrustedsubject since OEM's
hold those keys?

On Thu, Jul 26, 2012 at 3:49 PM, Haiqing Jiang <hqjiang1988@gmail.com> wrote:
> Hi, all
>
> I have the following denials. But from my understanding, the reading-down
> rule is not violated according to the scontext and tcontext. Could you help
> to explain why? Thanks.
>
> <5>[15423.456451] type=1400 audit(1342836229.562:2241): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=127269
> scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c16
> tclass=lnk_file
> <5>[15423.807434] type=1400 audit(1342836229.914:2242): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=129294
> scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c17
> tclass=lnk_file
> <5>[15423.963287] type=1400 audit(1342836230.070:2243): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=130190
> scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c0
> tclass=lnk_file
> <5>[15424.055236] type=1400 audit(1342836230.164:2244): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=130739
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c35
> tclass=lnk_file
> <5>[15424.145263] type=1400 audit(1342836230.250:2245): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=131183
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c36
> tclass=lnk_file
> <5>[15424.224792] type=1400 audit(1342836230.328:2246): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=131613
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c34
> tclass=lnk_file
> <5>[15424.290008] type=1400 audit(1342836230.398:2247): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=131971
> scontext=u:r:release_app:s0:c42 tcontext=u:r:platform_app:s0:c9
> tclass=lnk_file
> <5>[15424.409912] type=1400 audit(1342836230.515:2248): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=132511
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c14
> tclass=lnk_file
> <5>[15424.477813] type=1400 audit(1342836230.585:2249): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=132869
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c22
> tclass=lnk_file
> <5>[15424.548034] type=1400 audit(1342836230.656:2250): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=133227
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c25
> tclass=lnk_file
> <5>[15424.613525] type=1400 audit(1342836230.718:2251): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=133585
> scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c28
> tclass=lnk_file
> <5>[15424.797546] type=1400 audit(1342836230.906:2252): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=134474
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c38
> tclass=lnk_file
> <5>[15425.225646] type=1400 audit(1342836231.335:2253): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=136217
> scontext=u:r:release_app:s0:c42 tcontext=u:r:platform_app:s0:c19
> tclass=lnk_file
> <5>[15425.354034] type=1400 audit(1342836231.460:2254): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=136878
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c5
> tclass=lnk_file
> <5>[15425.443725] type=1400 audit(1342836231.546:2255): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=137392
> scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c6
> tclass=lnk_file
> <5>[15425.521240] type=1400 audit(1342836231.625:2256): avc:  denied  { read
> } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=137823
> scontext=u:r:release_app:s0:c42 tcontext=u:r:media_app:s0:c11
> tclass=lnk_file
>
>
> --
> -----------------------------------
> Haiqing Jiang, PH.D student
>
> Computer Science Department, North Carolina State University
>
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
