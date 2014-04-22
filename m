Message-ID: <535661FC.5090007@tycho.nsa.gov>
Date: Tue, 22 Apr 2014 08:35:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Cannot enable selinux.
References: <5356053E.9080302@gmail.com>
In-Reply-To: <5356053E.9080302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/22/2014 01:59 AM, dE wrote:
> I've SECURITY_SELINUX enabled on my custom kernel, however on mounting
> with selinuxfs --
> 
> mount: unknown filesystem type 'selinuxfs'
> 
> As a result, I cant get sestatus enabled.

dmesg output?

cat /proc/filesystems?

Kernel command line arguments?
