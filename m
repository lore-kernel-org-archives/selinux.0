Subject: Re: kernel access to device comm is kdevtmpfs
To: Nick Kralevich <nnk@google.com>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov>
 <CAFJ0LnHj44XVf8BfduXDQtsKmNe+Tdc3CMO4HDCU-4qF6u-F6g@mail.gmail.com>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Eric Paris <eparis@redhat.com>, SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55DDE873.5070707@tycho.nsa.gov>
Date: Wed, 26 Aug 2015 12:25:23 -0400
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnHj44XVf8BfduXDQtsKmNe+Tdc3CMO4HDCU-4qF6u-F6g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/26/2015 12:10 PM, Nick Kralevich wrote:
> 
> 
> On Wed, Aug 26, 2015 at 6:47 AM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     With devtmpfs, the kernel itself automatically populates and maintains a
>     device node tree.  The claim is that this provides you with a working
>     /dev tree before udev comes up, and that you can even dispense with
>     running udev entirely on simple systems (e.g. embedded).  However, it
>     seems like everyone continues to run udev on top of devtmpfs in Linux
>     distributions.
> 
>     The problem of course is that the kernel has no clue how to label the
>     device nodes, so it is still necessary to have udev or ueventd handle
>     that.  And with the kernel creation of the device nodes, we then have a
>     race condition where the device node briefly exists in the wrong, most
>     likely inaccessible label.
> 
> 
> Do you know how other standard DAC permissions are configured by the
> kernel? The kernel must have some knowledge of how to set the
> UID/GID/perms/etc...

As per drivers/base/devtmpfs.c, they default to root ownership and mode
0600 unless overridden by the driver.  Otherwise it is up to
udev/ueventd to fix up the permissions afterward.

The situation for SELinux contexts is similar (they will default to
device type until fixed by udev/ueventd), but we are more likely to run
afoul of race conditions because we don't allow all root processes to
access all device nodes. So we can end up denying access that would be
allowed once the label is correctly set by udev/ueventd.

Fedora currently avoids this via lots of name-based type transitions on
(kernel, device, chr_file|blk_file) but that is decidedly suboptimal.

We could certainly add devtmpfs to the list of filesystems for which we
support per-file genfs_contexts-based labeling, and then add /dev
entries there (prefix match, not regex match).

But I guess the question is why use devtmpfs at all if you are going to
run udev/ueventd anyway.  What's the practical benefit?
