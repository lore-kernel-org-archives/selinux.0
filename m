MIME-Version: 1.0
Date: Mon, 17 Nov 2014 14:44:36 +0000
Message-ID: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
Subject: Question on unconfined_t
From: "Paddie O'Brien" <paddieobrien@gmail.com>
To: Selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

As a learning exercise I created a simple policy to sandbox a simple
program in its own domain.

I had to add rules to the policy to allow the program to be executed
from unconfined_t. Is this normal? My understanding was that a process
in unconfined_t was subject only to DAC so why did I have to add this
rule? What does unconfined_t actually mean?

Thanks.
