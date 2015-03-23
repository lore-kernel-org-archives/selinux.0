Message-ID: <551074FD.6030007@tycho.nsa.gov>
Date: Mon, 23 Mar 2015 16:18:05 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Chludzinski <john.chludzinski@vivaldi.net>,
 Selinux <selinux@tycho.nsa.gov>
Subject: Re: Added project policy code and got "semodule_package:  ..."
References: <fb97f2e61c52ce5eb386dfe0ccd36cae@vivaldi.net>
In-Reply-To: <fb97f2e61c52ce5eb386dfe0ccd36cae@vivaldi.net>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/23/2015 04:12 PM, John Chludzinski wrote:
> I added project specific policy code to policy/module/<project-dir>.
> 
> Then I ran:
> 
> packages/clip-selinux-policy/clip-selinux-policy> make conf
> 
>>>> "make conf" added all the project module to "module" (e.g., projmod1
>>>> = module, projmod2 = module, etc.) in policy/modules.conf.
> 
> then I ran:
> 
> packages/clip-selinux-policy/clip-selinux-policy> make modules
> TYPE="mls" MLS_SENS=1
> 
> and got "semodule_package:  Failed to mmap tmp/<projmod1>.mod.fc: 
> Invalid argument"
> 
> Any suggestions?

Take follow-ups to the clip mailing list, please.

http://oss.tresys.com/mailman/listinfo/clip
