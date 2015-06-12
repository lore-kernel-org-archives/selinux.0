Message-ID: <557AFFB1.3030404@tresys.com>
Date: Fri, 12 Jun 2015 11:50:09 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Miroslav Grepl <mgrepl@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: New module store + /var being split off
References: <557AF847.6090504@redhat.com>
In-Reply-To: <557AF847.6090504@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/12/2015 11:18 AM, Miroslav Grepl wrote:
> Hello.
> 
> We are close to get the latest userspace (modules store + CIL) into
> Fedora. We just have a discussion about "/var" being split off and be
> mounted only very late at boot.
> 
> Can you think about an issue with that? I don't see any urgent blocker
> which blocks the boot process.
> 
> Thank you,
> Miroslav
> 

I don't believe anything in /var/selinux is necessary during boot. The
policy store in /var/selinux is only used with commands like
semodule/semanage/etc. so as long as those aren't run during boot I
suspect it should be fine.

- Steve
