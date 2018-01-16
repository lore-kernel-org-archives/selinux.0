From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Date: Tue, 16 Jan 2018 21:23:13 +0100
Message-Id: <20180116202327.23253-1-marcus.folkesson@gmail.com>
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Subject: Rework of Makefiles v2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I have updated the patchset.

Please test to compile with:
make DESTDIR=/tmp/myroot PREFIX=/myusr install


Changes:
v2:
	- Use separate directories for shared libraries as before( Comment from
	  Stephen Smalley)
	- Rework all packages (not just selinux/sepol/semanage)


Best regards
Marcus Folkesson
