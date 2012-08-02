Message-ID: <1343912782.30052.4.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH build/] Fix mkyaffs2image call to add a '/' to the mount
 point
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Robert Craig <robertpcraig@gmail.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Joshua
	Brindle <jbrindle@tresys.com>
Date: Thu, 02 Aug 2012 09:06:22 -0400
In-Reply-To: <CADQgGG3t4OHF9rBGzDjPwm-Cxm_aFvMi1YdmGv6qQZ0rxfA4dQ@mail.gmail.com>
References: <1343874989-13155-1-git-send-email-method@manicmethod.com>
	 <5019E85E.1070402@manicmethod.com>
	 <CADQgGG3t4OHF9rBGzDjPwm-Cxm_aFvMi1YdmGv6qQZ0rxfA4dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-02 at 06:04 -0400, Robert Craig wrote:
> There has already been a patch merged with the master branch
> (external/yaffs2 bd009e4d493deaf90c38da1cdbaa1db69db073ba).  For now I
> would cherry-pick. I'll see what we can do about getting that patch
> applied to the other branches as well.

I cherry-picked it over to seandroid-4.1.1.  I assume it isn't needed on
4.0.4 (and it didn't apply cleanly there).

> 
> 
> 
> On Wed, Aug 1, 2012 at 10:39 PM, Joshua Brindle
> <method@manicmethod.com> wrote:
>         Note, I have no idea why this just started happening but it is
>         consistent on my 4.1.1_r3 checkout. I don't know what the
>         ramifications of changing the mountpoint are (e.g., is that
>         used by something other than selabel_lookup?) so I haven't
>         submitted it to AOSP.
>         
>         
>         Joshua Brindle wrote:
>                 From: Joshua Brindle<jbrindle@tresys.com>
>                 
>                 selabel_lookup requires the mountpoint start with a
>                 '/' to match specifications in the file_context file.
>                 Change mkyaffs2image call to add a '/' to the mount
>                 point argument
>                 
>                 Change-Id: I255b661822401f9253ef58a2a4bdada85fc96b23
>                 
>                 Signed-off-by: Joshua Brindle<jbrindle@tresys.com>
>                 ---
>                   tools/releasetools/build_image.py |    2 +-
>                   1 file changed, 1 insertion(+), 1 deletion(-)
>                 
>                 diff --git a/tools/releasetools/build_image.py
>                 b/tools/releasetools/build_image.py
>                 index a615d1a..610e634 100755
>                 --- a/tools/releasetools/build_image.py
>                 +++ b/tools/releasetools/build_image.py
>                 @@ -56,7 +56,7 @@ def BuildImage(in_dir, prop_dict,
>                 out_file):
>                       build_command.append(out_file)
>                       if "selinux_fc" in prop_dict:
>                         build_command.append(prop_dict["selinux_fc"])
>                 -      build_command.append(prop_dict["mount_point"])
>                 +      build_command.append("/%s" %
>                 prop_dict["mount_point"])
>                 
>                     print "Running: ", " ".join(build_command)
>                     p = subprocess.Popen(build_command);
>         
>         --
>         
>         This message was distributed to subscribers of the selinux
>         mailing list.
>         If you no longer wish to subscribe, send mail to
>         majordomo@tycho.nsa.gov with
>         the words "unsubscribe selinux" without quotes as the message.
>         
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
