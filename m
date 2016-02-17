Subject: Re: RESEND [PATCH V3] libselinux: Add selinux_restorecon function
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1452874283-6166-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56C480FF.4070306@tycho.nsa.gov>
Date: Wed, 17 Feb 2016 09:17:35 -0500
MIME-Version: 1.0
In-Reply-To: <1452874283-6166-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/15/2016 11:11 AM, Richard Haines wrote:
> The selinux_restorecon(3) man page details this function.
>
> It has been built using the work from Android where an SHA1 hash
> of the specfiles is held in an extended attribute to enhance
> performance. Also contains components from policycoreutils/setfiles.
>
> The utils/selinux_restorecon.c utility demonstrates the functionality.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.
