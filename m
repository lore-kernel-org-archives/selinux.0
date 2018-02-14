From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 10:57:02 +0100
Message-Id: <20180214095717.1050-1-marcus.folkesson@gmail.com>
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Subject: Rework of makefiles v5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I have updated the patchset.

The biggest change is that $(DESTDIR) is now used in the
install stage only.

Also some overidden CFLAGS/LDFLAGS has been removed since we now have
explicit build rules.

I have moved the changelog into patches.

Please test to compile with:
make DESTDIR=/tmp/myroot PREFIX=/myusr install
or
make DESTDIR=/tmp/myroot install

Thanks for all feedback.

Best regards
Marcus Folkesson
