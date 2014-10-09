Message-ID: <5436CC14.2040906@schaufler-ca.com>
Date: Thu, 09 Oct 2014 10:55:32 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: SELinux <Selinux@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>
Subject: Functions prefixed with security_ in SELinux
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


As I've been working on the multiple concurrent modules project I have
frequently encountered the use of the function prefix security_ in
SELinux specific code. I understand and appreciate that this code has
been there since the dawn of time. The LSM infrastructure also uses this
prefix, and that's where I have my concern. When I'm grubbing about for
uses of the LSM infrastructure in the SELinux code it's really quite
annoying. Would the SELinux community be open to considering the
possibility of thinking about cleaning up this bit of namespace
pollution? It surely isn't a critical issue, but it would certainly look
better.

security_context_to_sid -> selinux_context_to_sid

Just a thought.
