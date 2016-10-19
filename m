From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: RE: [PATCH] [RFC] nodups_specs: speedup
Date: Wed, 19 Oct 2016 20:09:24 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD1A131@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Following up on:
http://marc.info/?l=selinux&m=147249024230263&w=2

The speedup only occurs when you have things with very long
And common prefix's that cause strcmp() to run for long periods.

Under actual usecases, like refpolicy and Android, no measurable speedup was
discovered.

Unless anyone else has a use that they would like analyzed, I'll consider this
dead.

-- Bill
