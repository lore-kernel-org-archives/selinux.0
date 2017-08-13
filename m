Date: Sun, 13 Aug 2017 11:24:14 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Daniel Jurgens <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <20170813162414.GC4515@mail.hallyn.com>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
 <05edc763-dddd-fe48-b98c-21e4ad5463a3@users.sourceforge.net>
 <20170813162233.GB4515@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170813162233.GB4515@mail.hallyn.com>
Subject: Re: [PATCH 1/4] selinux: Delete eight unnecessary variable assignments
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Serge E. Hallyn (serge@hallyn.com):
> Quoting SF Markus Elfring (elfring@users.sourceforge.net):
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 13 Aug 2017 14:17:48 +0200
> > 
> > One local variable was reset to zero at the end of these functions.
> > This value will also be set by a previous call of a function if it was
> > executed successfully. Thus omit an extra assignment there.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

BTW this does add a burden to the maintainers as it makes the
code a bit more fragile in the face of future changes.  So my
ack means it looks ok, but if the maintainers don't want to take
it I absolutely understand.
