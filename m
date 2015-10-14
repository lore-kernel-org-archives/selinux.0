Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9EDug3Y028273
 for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2015 09:56:42 -0400
Subject: Re: does load_policy default to loading the lowest polvers available?
To: selinux@tycho.nsa.gov
References: <20151014133408.GA5222@x250>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <561E5EF4.9080606@tycho.nsa.gov>
Date: Wed, 14 Oct 2015 09:56:04 -0400
MIME-Version: 1.0
In-Reply-To: <20151014133408.GA5222@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2015 09:34 AM, Dominick Grift wrote:
>
> I had some issue that just confused me (to say the least) It seems that
> I have now solved this.
>
> There were two policy.X files in my /etc/selinux/SELINUXTYPE/policy dir,
> on 29 an one 30. The 29 seemingly had a bug in it.
>
> It seems that load_policy (or its libselinux equivalent) defaults to
> the lowest policy available (29 instead of 30 in this case)
>
> Why is that?
>
> I fixed the issue by removing the policy.29 file (i think at least)

What policy versions were supported by your kernel (cat 
/sys/fs/selinux/policyvers) and by your libsepol (checkpolicy -V)?

load_policy will try to use the highest policy version that is supported 
by the kernel or by your libsepol.  If supported by the kernel, it can 
just load the file directly.  Otherwise, it can use libsepol to 
downgrade the policy to the highest version supported by the kernel and 
then load the result.  If the version is not supported by either the 
kernel or your libsepol, then it cannot be loaded and it will fall back 
to an older version.
