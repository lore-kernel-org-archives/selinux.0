Message-ID: <4B740814.8080802@redhat.com>
Date: Thu, 11 Feb 2010 08:37:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Random fork showing up in policy.
Content-Type: multipart/mixed;
 boundary="------------030206020406050309020503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030206020406050309020503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

There has got to be something I am doing wrong.  But on my blog someone asked about writing a program that does a fork and having SELinux block it.  

Where is the fork access coming from?

In the tmp dir I see this policy being compiled.

# grep process.*fork fork.tmp
	class process { fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate };
	type_transition initrc_t fork_exec_t:process fork_t;
	type_transition init_t fork_exec_t:process fork_t;
	type_transition unconfined_t fork_exec_t:process fork_t;
neverallow fork_t self:process fork;


But if I install.

# semodule -i fork.pp
libsepol.check_assertion_helper: neverallow violated by allow fork_t fork_t:process { fork };
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!

If I remove the neverallow line.

# sesearch -A -s fork_t -p fork
Found 1 semantic av rules:
   allow fork_t fork_t : process { fork sigchld } ; 

Something strange is going on.

--------------030206020406050309020503
Content-Type: application/x-compressed-tar;
 name="fork.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fork.tgz"

H4sIAFYHdEsAA+1Xe2/bNhDPv+anuMrO7HSRLcWxCzR1hgxphgJrMbQosKILZEWibC4S6ZJU
bK/rd9+RkvxIumbdkATFdEBiPu5+PJ54r0TIy260c6fkIQ2Hh+Z32Pf6m7+WBv5gx/f7/YHn
+f0Brvv+wDvcAe9u1SooVzqUADvxPEzV9O/5btv/RqnJeJTmMYVnOWdKx93pMVmv4QIT15Zo
yni+6JW/ZpMwriELGe+YQSgn0T5EU7Tq48c4udoD8pE0FI1yyfQyiATXdKEDDQqHR6QxoRoH
ne/MdA/nM4kwSccpGUe76jfu7Fe7iaTUsK+4WYxQ+B9GkOBj7phFlnRwZTTy9kgDz15DTlka
I5rh+UQaNFUUKl7Xv8ZMpRRym3mbYRZKyvWK4xN56I/5L8iYrJvcbQCw/n94WPn79V/Px3Hl
/4f9ofF/zz+4Z/+XQugv8d22/40S6eVK9i4Y75mX0HBddEde+WhHLZWmWZA/FRe/00gH8qnh
CuiCRoHeV+heD61/Tf+NrP+z5E7PuM3/B8PhDf8/9Gr/vw8izSbm9DzLQrk8nomURUuTRm0q
fdarNgiy/TPawsNJ4znGilxTCCEWpkYALUOumGYChwJkzu1ZXSvY25CEZ5hfwwx4mNGRUwg7
xzfwTwvUME3FnMYGcn3A50B7FhXHpmqhMgkj2hnbqIZHWNH2/pjYKCjph5xJ3Macr5czahXF
uAcbQRAzf3uPkEYlHMxCjbC80/K3+MqJ3iOG/aG/+pqs7e+4rjU+/mRww++r3wPv4MlN/7/v
+v9/6v/NRzb5qym4lJDTF69fnbx8PhrHTBq/g5Y3JlEMrXKDvH1z8tPzkdPy4D24bj6LQ3Tt
c4ewBBfGWIS7+RgejcCD8yPQU8oJjaYC2u9EDhmaGi4oGEtWrq+nTGEfINlMtwldMA0+SRgp
8FpNVOoD+Cushl12Wr6Dxb5Tne/AOVQMDc0wWoxTBW6KCpqZq/QyxQjy/e4Cdn91imiDWv8J
4fwS2h+hKOfB2VWwq5x9aA3x7wl8ahu/l3lK1Wgc5oqGMkIruea9aGgZaHAzCK8iXJThHFxV
RAgjZhVdOC0r7hiLOIstPRvWLs6ZyHlsMNrKmKQ0aBmH50xPnRWvS2GFh7rnMdMHNuqB+3oN
eCpgibaeh9iJ4VGoEnZifEIVhHFcxMcS/f2yx89/sPiShjGcvHpjxqWJcWaNvHTAFRvzd9u3
KE99a/RmfFJiO+utL2kNx8fV17ACTTjDLcQW+WQKIRpG0oscO7YS1t7SdmFmYB6LZ4b4Xtbr
hT6vBHA6N3ZVeAKauDBjJWIkSoFKyZZ92aRk8onhwQ63eoYTCgcbF78utfFyCwV+NGobg5hb
/CxCO/6lNI6iGtwFycJLfEEJ2ApcYb9Mq6a6F9MrmvZeIkPCUlrU6Mr6Kc1EjNYElxWmm80w
N8MZW5gDUDkwAlDW74A5dqu+JwWKpEoLadpocM/Mh3CvrvE9dFiq6Z6o9L87PeOW+t/vD1b5
v39Q5v+BX+f/+6AisgZFVOmY17Dvd70udvZfUfJjBDqlUYqFtam6FS6QjXr5aGNSFc2MMx3E
IUYzHhSlfeczxfXXKmFEIRVRmFYZo2mi4ws8rCwyAJNhjDF2QopTA8zrgW0EwkizKxoksepU
lTqK2i2OeJHIspyzyN4QsGgRiaYcexpOIVcm+CYsETbcI9sClIguqVZdUiS7AhIwvidPDWNg
w7ScB6tJMKMyU0ef4Td4gdKYpLOggIUIJ5puL1YAxKCpwOT0gOrIgq/vlDEVbTBYY7E/7K3W
9y7TUDBBVMpxOaLmhdA1B5pNogWt+cw4mOnlhuGudU/2++cc803COI1t1yRFurUmj0xntNWI
dTZF9sgNCTC4avXKOCZNedN8Mykiqgq2o4d2t5pqqqmmmmqqqaaaaqqppppqehD6C7MHqggA
KAAA
--------------030206020406050309020503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
