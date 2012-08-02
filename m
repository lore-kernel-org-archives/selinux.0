Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q722dQSi002173
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2012 22:39:26 -0400
Message-ID: <5019E85E.1070402@manicmethod.com>
Date: Wed, 01 Aug 2012 22:39:26 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH build/] Fix mkyaffs2image call to add a '/' to the mount
 point
References: <1343874989-13155-1-git-send-email-method@manicmethod.com>
In-Reply-To: <1343874989-13155-1-git-send-email-method@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Note, I have no idea why this just started happening but it is 
consistent on my 4.1.1_r3 checkout. I don't know what the ramifications 
of changing the mountpoint are (e.g., is that used by something other 
than selabel_lookup?) so I haven't submitted it to AOSP.

Joshua Brindle wrote:
> From: Joshua Brindle<jbrindle@tresys.com>
>
> selabel_lookup requires the mountpoint start with a '/' to match specifications in the file_context file. Change mkyaffs2image call to add a '/' to the mount point argument
>
> Change-Id: I255b661822401f9253ef58a2a4bdada85fc96b23
>
> Signed-off-by: Joshua Brindle<jbrindle@tresys.com>
> ---
>   tools/releasetools/build_image.py |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/releasetools/build_image.py b/tools/releasetools/build_image.py
> index a615d1a..610e634 100755
> --- a/tools/releasetools/build_image.py
> +++ b/tools/releasetools/build_image.py
> @@ -56,7 +56,7 @@ def BuildImage(in_dir, prop_dict, out_file):
>       build_command.append(out_file)
>       if "selinux_fc" in prop_dict:
>         build_command.append(prop_dict["selinux_fc"])
> -      build_command.append(prop_dict["mount_point"])
> +      build_command.append("/%s" % prop_dict["mount_point"])
>
>     print "Running: ", " ".join(build_command)
>     p = subprocess.Popen(build_command);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
