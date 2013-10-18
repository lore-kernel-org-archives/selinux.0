Message-ID: <52617C02.4060500@tycho.nsa.gov>
Date: Fri, 18 Oct 2013 14:20:50 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Steve Lawrence <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Dominick Grift <dominick.grift@gmail.com>
Subject: Update to CIL
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I pushed an update of CIL to bitbucket.

Richard Haines submitted a patch to allow specifying the file contexts file. 
Other than that, the changes were bug fixes or minor cleanups.

Among the bug fixes:

Fixed the following issues with CIL first found by Richard Haines:

- Bug in constraint handling that caused them to be left out of the kernel policy.
- Role and type attributes in constraints were not being expanded.
- block_node was not being initialized before use in cil_resolve_blockabstract.
- The value of CIL_KEY_CONS_T3 should be "u3" rather than "us" in cil_internal.h.

Fixed the following issue first found by Dominick Grift:

- Bug where categories show up in a non-mls kernel policy.


Thank you to those who have been trying CIL out.


Anyone interested in trying CIL out can do the following:

1) Clone the CIL compiler and cilpolicy
git clone https://jwcarter@bitbucket.org/jwcarter/secilc.git
git clone https://jwcarter@bitbucket.org/jwcarter/cilpolicy.git

2) Build secilc
cd secilc
make
cd ..

3) Build cilpolicy
./secilc/secilc `cat cilpolicy/LISTING`


To build an MLS policy:

Edit "cilpolicy/mls_declarations" and change "(tunable enable_mls false)" to 
"(tunable enable_mls true)"

Build the MLS policy: ./secilc/secilc -M `cat cilpolicy/LISTING`

MCS is similar.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
