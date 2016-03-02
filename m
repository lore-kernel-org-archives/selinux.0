Subject: Re: Linux sandbox and the -i option
To: w.chimiak@ieee.org, "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <56D599AE.3050009@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56D6F06B.2070904@tycho.nsa.gov>
Date: Wed, 2 Mar 2016 08:53:47 -0500
MIME-Version: 1.0
In-Reply-To: <56D599AE.3050009@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/01/2016 08:31 AM, Bill wrote:
> Is anyone else having issues with the
> % sandbox -i [path]
> not working?  What happens is the context is incorrectly done.
>
> %ls -Zd /tmp/.sandbox_home_[whatever]
> gives
> unconfined_u:object_r:sandbox_file_t:s0:cxx,cyyy .
> BUT
> %ls -Z [path] is
> gives
> unconfined_u:object_r:mozilla_home_t:s0 [path]
>
> This causes all sorts of read/write issues.
>
> I guess I can write a script to do the
> chcon, but that is a bit painful and you have to hunt
> for the correct sandbox directory (not optimal at all).
>
> Any suggestions?

I think this is really a question for the fedora selinux list and/or a 
redhat bugzilla, but regardless, you need to provide more information 
(e.g. distro version, package version, etc).
