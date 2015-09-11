Subject: Re: Can I change default policy from targeted to minimum
To: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250>
 <CA+=dQ--_H_vrh2sLp4UePBaSBipVba+CX-tbsLR3u9Ft8P-MUg@mail.gmail.com>
 <20150911155344.GA4106@x250>
 <CA+=dQ-_fxDCjHZmO39O9=S0eQpWN7fhpQQRyqv9d-f82zXahdA@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55F30B5F.5080203@tycho.nsa.gov>
Date: Fri, 11 Sep 2015 13:11:59 -0400
MIME-Version: 1.0
In-Reply-To: <CA+=dQ-_fxDCjHZmO39O9=S0eQpWN7fhpQQRyqv9d-f82zXahdA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/11/2015 12:43 PM, Divya Vyas wrote:
> Hi Dominick,
> 
> I have a question, What is role of policy.29/28/27 . If I understand
> correctly  It is a binary policy called while kernel booting. Is is
> symbolic lick with policy.kern.

The suffix indicates the policy format version; the version number is
also contained within the file header but having it as a file name
suffix is convenient for supporting multiple versions on the same system
(e.g. for booting different kernels) and for allowing userspace to
select the right file without having to parse it.

It isn't normally just a symlink.

In Android, we dispensed with the policy version suffix and just called
it "sepolicy" because we could ensure that the kernel and userspace were
aligned and that the policy file would always be compatible with the
kernel.  We also had to move it out of /etc and into / so that it could
be loaded before the /system partition was mounted, since /etc in
Android is just a symlink to /system/etc and is not available immediately.
