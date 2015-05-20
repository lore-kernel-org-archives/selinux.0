From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
Date: Wed, 20 May 2015 16:39:14 -0400
Message-ID: <2663534.8stSKUUHdD@x2>
In-Reply-To: <555CED00.9010208@tycho.nsa.gov>
References: <1428616171-14767-1-git-send-email-jeffv@google.com>
 <11866875.LIkutgAE8Q@x2> <555CED00.9010208@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 james.l.morris@oracle.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, May 20, 2015 04:22:24 PM Stephen Smalley wrote:
> On 05/20/2015 04:21 PM, Steve Grubb wrote:
> > On Wednesday, May 20, 2015 04:06:55 PM Paul Moore wrote:
> >> On Thursday, April 09, 2015 02:49:31 PM Jeff Vander Stoep wrote:
> >>> Add information about ioctl calls to the LSM audit data. Log the
> >>> file path and command number.
> >>> 
> >>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> >>> ---
> >>> 
> >>>  include/linux/lsm_audit.h |  7 +++++++
> >>>  security/lsm_audit.c      | 15 +++++++++++++++
> >>>  2 files changed, 22 insertions(+)
> >> 
> >> No real comment other than we should include the linux-audit list on this
> >> patch (added to the To/CC line).
> >> 
> >> From an audit perspective the only new field would be the ioctl number
> >> which is represented by the "ioctlcmd" name.  Does anyone in the audit
> >> space have any strong feelings on this one way or another?
> > 
> > Isn't that in arg1 already? I know I wrote interpretations for it.
> 
> Only with syscall audit, often not enabled.  This is to capture the
> information on AVC denials for an extension to SELinux to support ioctl
> whitelisting.

OK. ioctlcmd is fine. I'll add it to the lookup table to interpret the value.

-Steve
