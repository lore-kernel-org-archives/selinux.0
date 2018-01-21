From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Date: Sun, 21 Jan 2018 22:46:03 +0100
Message-Id: <20180121214617.8975-1-marcus.folkesson@gmail.com>
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Subject: Rework of Makefiles v3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I have updated the patchset.

Please test to compile with:
make DESTDIR=/tmp/myroot PREFIX=/myusr install
or
make DESTDIR=/tmp/myroot install

As said before, the goal with this patchset is to clean up the
Makefiles on unused symbols, use standard semantics and keep all
the old functionality.

Changes:
v3:
	- python: Add missing slash 
	- Top makefile: Add default prefix
	- python, mcstrans, selinux: keep the possibility to specify LIBSEPOLA to
	  make depending component recompile on change. If not specified, fall back to
	  libsepola in LDFLAGS path.

v2:
	- Use separate directories for shared libraries as before( Comment from Stephen Smalley)
	- Rework all packages (not just selinux/sepol/semanage)
