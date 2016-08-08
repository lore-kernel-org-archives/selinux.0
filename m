Subject: Re: Any way to label /proc/self/mem with a different type then the
 process type.
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
References: <8f97fb23-65b5-bef5-bbae-f6139a2766f4@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6db760db-7b20-9fb9-29df-07b4a46b0ace@tycho.nsa.gov>
Date: Mon, 8 Aug 2016 14:32:22 -0400
MIME-Version: 1.0
In-Reply-To: <8f97fb23-65b5-bef5-bbae-f6139a2766f4@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/08/2016 01:41 PM, Daniel J Walsh wrote:
> I have been requested by some container people to make this only
> readable not writable to prevent certain types of attacks on the
> 
> kernel.  No idea if this is a good idea or not.

Would require a kernel change.  Support for per-file labeling of
/proc/pid came up previously in SE for Android, so the SE for Android
todo list has an item here:

Extend SELinux /proc/pid labeling support to support derived types on
specific /proc/pid files based on both the associated task context and
the file name, e.g. name-based type transitions. This would allow
applying different restrictions to different /proc/pid files of the same
process via SELinux.

Probably should go on the SELinux kernel todo list.
