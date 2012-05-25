Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4PGNZ7E005061
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2012 12:23:35 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4PGNXTo010483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2012 12:23:33 -0400
Received: from localhost (unused-4-136.brq.redhat.com [10.34.4.136] (may be forged))
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q4PGNWW1012222
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2012 12:23:33 -0400
Date: Fri, 25 May 2012 18:23:32 +0200
From: Adam Tkac <atkac@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Two optimizations for libsepol
Message-ID: <20120525162331.GA17191@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

I've just finished two optimizations which speeds-up libsepol's
expand_filename_trans() function. Various se* commands (like setsebool,
semodule) now consumes only 15% of CPU time compared to current
expand_filename_trans() implementation.

The first patch is fairly simple and straightforward.

The second patch improves main expand_filename_trans() headache, comparsion of
two linked lists. It chunks the second list by filename_trans->stype value and
now algorithm walks only through piece of list where all elements have matching
filename_trans->stype value.

As an example, semodule run time is greatly decreased on my machine:

Original libsepol:
# time /usr/sbin/semodule -b /etc/selinux/targeted/modules/active/base.pp

real    1m54.548s
user    1m51.535s
sys     0m0.875s

After the first patch:
# time /usr/sbin/semodule -b /etc/selinux/targeted/modules/active/base.pp

real    1m43.243s
user    1m40.247s
sys     0m0.902s

Both patches applied:
# time /usr/sbin/semodule -b /etc/selinux/targeted/modules/active/base.pp

real    0m20.752s
user    0m18.508s
sys     0m0.984s

Any comments are welcomed.

Regards, Adam

-- 
Adam Tkac, Red Hat, Inc.

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Optimize-expand_filename_trans-function-part1.patch"


--k+w/mQv8wyuph6w0--
