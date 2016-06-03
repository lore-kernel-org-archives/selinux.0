Subject: Re: [RFC 1/2] selinux: Stop looking up dentries from inodes
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <1464616742-29271-1-git-send-email-agruenba@redhat.com>
 <1464616742-29271-2-git-send-email-agruenba@redhat.com>
 <2748270d-1c74-b5c8-c9f2-85d898c065e1@tycho.nsa.gov>
 <CAHc6FU7z5bo44radMsKcadxqqhEqRpbfGGeUtR+CohJBMUfzKg@mail.gmail.com>
 <7e716b38-f59b-eff3-152a-4f005b45abd9@tycho.nsa.gov>
 <CAHc6FU67zwdQ6zEjNuDZZpjOsXRYWB0AEWV4orssvgZNpusv-A@mail.gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <83f00c59-e7e0-40db-0bcf-c3ef7654d5c4@tycho.nsa.gov>
Date: Fri, 3 Jun 2016 09:06:45 -0400
MIME-Version: 1.0
In-Reply-To: <CAHc6FU67zwdQ6zEjNuDZZpjOsXRYWB0AEWV4orssvgZNpusv-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/01/2016 05:46 PM, Andreas Gruenbacher wrote:
> On Wed, Jun 1, 2016 at 3:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/31/2016 11:22 AM, Andreas Gruenbacher wrote:
>>> With that fixed, could you possibly put this change to test?
>>
>> Falls over during boot in generic_getxattr(), which still needs a
>> non-NULL dentry in the work.selinux branch.
> 
> dentry->d_sb needs to be changed to inode->i_sb there.
> 
>> Is there a reason that this being done separately from work.xattr?
> 
> I don't know how much work.xattr will shift still (and what I can
> still add there), and this change is unrelated, at least so far.
> 
>> Also, if we aren't going to call d_find_alias() there, we can likely
>> also drop the dget() and dput().
> 
> Ah, yes. I'll remove those, thanks.

Looks like you lost the assignment for dentry entirely when you removed
the dget/dput.  Still need to set it to opt_dentry or just use
opt_dentry directly.

BTW, SELinux will presently never call getxattr for 9p or cifs; those
filesystem types are not configured for xattrs in policy because they do
not truly support labeling (and if they did, we would probably use
SECURITY_LSM_NATIVE_LABELS => SECURITY_FS_USE_NATIVE as with nfsv4
rather than FS_USE_XATTR).  Just because they support xattrs does not
mean that they support security labeling.
