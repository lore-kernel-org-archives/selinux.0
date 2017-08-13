Date: Sun, 13 Aug 2017 11:24:34 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Daniel Jurgens <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <20170813162434.GD4515@mail.hallyn.com>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
 <2c4582c9-efc1-4b8c-1095-84e00062c7de@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c4582c9-efc1-4b8c-1095-84e00062c7de@users.sourceforge.net>
Subject: Re: [PATCH 2/4] selinux: Adjust jump targets in
 ebitmap_read()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting SF Markus Elfring (elfring@users.sourceforge.net):
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 13 Aug 2017 15:21:43 +0200
> 
> Adjust jump targets so that the function implementation becomes smaller.

By how much?
