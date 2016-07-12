Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
 <20160706121257.GS16797@redhat.com>
 <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
 <CAFftDdoP7T8nb5SYyKiGhoyc8_E2kLoA1WmajtP55yNNoW93dQ@mail.gmail.com>
 <20160707135017.GA23053@meriadoc.perfinion.com>
 <20160707205614.GA26165@redhat.com>
 <489b58fb-1fad-2456-67bd-8e88f9e8a16d@tycho.nsa.gov>
 <20160712180107.GQ16797@redhat.com>
Cc: Jason Zaman <jason@perfinion.com>, SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d7f0e492-53f2-2826-66bc-d1edb1f3f125@tycho.nsa.gov>
Date: Tue, 12 Jul 2016 14:25:41 -0400
MIME-Version: 1.0
In-Reply-To: <20160712180107.GQ16797@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 07/12/2016 02:01 PM, Richard W.M. Jones wrote:
> On Tue, Jul 12, 2016 at 01:22:55PM -0400, Stephen Smalley wrote:
>> On 07/07/2016 04:56 PM, Richard W.M. Jones wrote:
>>> On Thu, Jul 07, 2016 at 09:50:17PM +0800, Jason Zaman wrote:
>>>> Doesn't Android set the labels on the /system disk image during build?
>>>> Maybe virt-builder can copy that? This would also speed up initial
>>>> deployment of new images.
>>>
>>> Well this is the real problem.  Because the guest policy is a binary
>>> blob, and because the binary blobs are not (necessarily) compatible
>>> across kernel versions, we cannot just load the policy blob of the
>>> guest into our kernel, so we cannot label guests properly.  Sure be
>>> nice if policy wasn't stored in this way.
>>
>> Just to clarify, it is not necessary to load the guest policy into the
>> host kernel in order to set labels on the guest filesystem.  SELinux
>> long ago introduced support for setting foreign/unknown labels on files
>> by processes with the appropriate permissions, and that mechanism was
>> used by livecd creator IIRC - it was also intended for use by rpm for
>> labeling files before the corresponding policy module was installed but
>> they never took advantage of it.
> 
> IME you cannot set any label unless SELinux is enabled in the
> appliance kernel, but even assuming this is really possible, how do
> you know what label should you set?  Really we just want to do
> "restorecon -R /" but that has proven to be impossible.

Hmm...the kernel certainly supports setting labels as long as the
filesystem xattr support is enabled, and setfiles used to work even if
SELinux is disabled, but admittedly we don't test on SELinux-disabled
very often.

For SELinux-enabled, something like:
runcon -t setfiles_mac_t -- chroot /mnt /sbin/setfiles -v -F -e /proc -e
/sys -e /dev -e /selinux
/etc/selinux/targeted/contexts/files/file_contexts /
has been reported to work in the past.  The process needs CAP_MAC_ADMIN
in its effective capability set and it needs to be in a domain that is
allowed mac_admin by policy (hence the runcon -t setfiles_mac_t above).

IIRC, they had to add a local policy module to allow setfiles_mac_t to
be entered via chroot rather than via setfiles.

> 
>> The other approach would be to follow what we did in Android, i.e.
>> extend the filesystem generation tools to look up the appropriate
>> context and set the xattr when generating the image files.  Similar
>> support was also recently added to the OpenEmbedded tools for labeling
>> those images.
> 
> Look up how?

In the Android case, we instrumented the ext4fs tools to use the
libselinux selabel_lookup interface for looking up the right context to
assign to a given file; see ext4_utils in
https://android.googlesource.com/platform/system/extras.  In the
OpenEmbedded case, I think they run setfiles on the directory using
pseudo to store the attributes (so the host OS never sees them), then
have their filesystem generation tools fetch the xattrs again using
pseudo and set them in the image during image generation.
