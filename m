From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Date: Wed, 24 Jan 2018 10:27:21 +0100
Message-Id: <20180124092736.8432-1-marcus.folkesson@gmail.com>
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Subject: Rework of Makefiles
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I have updated the patchset.

We had a problem with overriding LIBDIR.

Please test to compile with:
make DESTDIR=/tmp/myroot PREFIX=/myusr install
or
make DESTDIR=/tmp/myroot install

Thanks to Nicolas and Petr for feedback.

Changes:
v4:
	- top Makefile: add LIBDIR to LDFLAGS if DESTDIR is specified
	- top Makefile: export LIBSEPOLA  if DESTDIR is specified
	- python: move platform from platform specific to platform shared installation directory
	- Introduce LDLIBS_LIBSEPOLA if LIBSEPOLA is not defined. 

v3:
	- python: Add missing slash 
	- Top makefile: Add default prefix
	- python, mcstrans, selinux: keep the possibility to specify LIBSEPOLA to
	  make depending component recompile on change. If not specified, fall back to
	  libsepola in LDFLAGS path.

v2:
	- Use separate directories for shared libraries as before( Comment from Stephen Smalley)
	- Rework all packages (not just selinux/sepol/semanage)
