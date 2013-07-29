Message-ID: <51F6A808.5080204@tycho.nsa.gov>
Date: Mon, 29 Jul 2013 13:36:08 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Steve Lawrence <slawrence@tresys.com>
Subject: Common Intermediate Language (CIL) Update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The CIL compiler, secilc, is now able to create MLS, MCS, and non-MLS binary 
policies from a slightly modified version of Refpolicy that has been converted 
to CIL.

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


Anyone interested in trying to create their own CIL policy from Refpolicy can 
clone the Flask Policy Parser (fpp) from bitbucket and follow the instructions 
in the README. To clone fpp:
git clone https://jwcarter@bitbucket.org/jwcarter/fpp.git

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
