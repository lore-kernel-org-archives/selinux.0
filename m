Subject: Re: [PATCH] policycoreutils/sepolicy: Check get_rpm_nvr_list() return
 value
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1470315053-18483-1-git-send-email-vmojzis@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <d26f3d4a-06ed-bd40-ba59-e02352f95fc7@tycho.nsa.gov>
Date: Tue, 9 Aug 2016 16:22:49 -0400
MIME-Version: 1.0
In-Reply-To: <1470315053-18483-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/04/2016 08:50 AM, Vit Mojzis wrote:
> get_rpm_nvr_list can fail to get the version of selinux-policy rpm
> package, which leads to error during spec file creation (attempt to
> invoke __getitem__ of "None" object).
>
> This patch sets the policy number to "0.0.0" in case rpm failed to
> get it. This change should be safe because it affects only an example
> of spec file.
>
> Variable "POLICYCOREUTILSVER" was removed (unused).
>
> fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1321499
>
> Failed to retrieve rpm info for selinux-policy
> Traceback (most recent call last):
>   File "/bin/selinux-polgengui", line 360, in forward
>     self.generate_policy()
>   File "/bin/selinux-polgengui", line 506, in generate_policy
>     self.info(my_policy.generate(outputdir))
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1382, in generate
>     out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1228, in write_spec
>     fd.write(self.generate_spec())
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1190, in generate_spec
>     selinux_policyver = get_rpm_nvr_list("selinux-policy")[1]
>   TypeError: 'NoneType' object has no attribute '__getitem__'
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Applied.

Thanks,
Jim

> ---
>  policycoreutils/sepolicy/sepolicy/generate.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
> index a92783a..1c67d99 100644
> --- a/policycoreutils/sepolicy/sepolicy/generate.py
> +++ b/policycoreutils/sepolicy/sepolicy/generate.py
> @@ -1184,8 +1184,12 @@ allow %s_t %s_t:%s_socket name_%s;
>      def generate_spec(self):
>          newspec = ""
>
> -        selinux_policyver = get_rpm_nvr_list("selinux-policy")[1]
> -        POLICYCOREUTILSVER = get_rpm_nvr_list("checkpolicy")[1]
> +        selinux_policynvr = get_rpm_nvr_list("selinux-policy")
> +
> +        if selinux_policynvr is None:
> +            selinux_policyver = "0.0.0"
> +        else:
> +            selinux_policyver = selinux_policynvr[1]
>
>          newspec += spec.header_comment_section
>          if self.type in APPLICATIONS:
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
